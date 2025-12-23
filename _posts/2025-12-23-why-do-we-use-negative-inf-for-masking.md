---
layout: post
title: "Why Do We Use Negative Infinity for Masking in Attention?"
date: 2025-12-23
author: "Sachin Kalsi"
---
## Introduction

In Causal Attention (i.e, decoder-only models), a token can not look into the future tokens and to enable this we use `masking`. We don't mask future tokens by filling with zero but filling with negative infinity ($-\infty$).

---

### 1. Causal Masking

In a sequence of tokens, we want the attention mechanism for the $i$-th token to only consider tokens from $0$ to $i$. Generally masking will be applied to attention scores. And to do this, we create a mask using `torch.tril` . And in this representation future tokens are represented as `0` (False) & past/previous tokens as `1` (True).

---

### 2. Why "0" Fails

Let’s look at the Softmax formula:

$$\text{Softmax}(x_i) = \frac{e^{x_i}}{\sum_{j} e^{x_j}}$$

If you set an attention score to $0$, the numerator becomes $e^0 = 1$ & the future "ignored" token still gets a non-zero probability!

---

### 3. The Solution: The Power of $-\infty$

Replace the scores of future tokens with $-\infty$ instead of $0$ since $e^{-\infty}$ becomes $0$ and the softmax output for those future tokens becomes exactly $0$.

**Note:** in actual FP16 training, we often use -65504 instead of a literal inf to avoid numerical instability. `min_value = torch.finfo(dtype).min` would help

---

## 4. How to do it in Python?

```
import torch
import torch.nn.functional as F

# Simulated attention scores (Query @ Key.T)
scores = torch.tensor([[10.0, 2.0, 1, 4], 
                       [5.0, 11.0, 7, 3],
                       [3, 9, 7, 5],
                       [8, 9, 4, 8]])

mask = torch.tril(torch.ones(scores.shape[1], scores.shape[1])) 
# tensor([[1., 0., 0., 0.],
#       [1., 1., 0., 0.],
#        [1., 1., 1., 0.],
#        [1., 1., 1., 1.]])

dtype=torch.float32
masked_scores = scores.masked_fill(mask == 0, torch.finfo(dtype).min) # or float('-inf')
# tensor([[10., -inf, -inf, -inf],
#        [ 5., 11., -inf, -inf],
#        [ 3.,  9.,  7., -inf],
#        [ 8.,  9.,  4.,  8.]])

probs = F.softmax(masked_scores, dim=-1)
# tensor([[1.0000, 0.0000, 0.0000, 0.0000], <-- Future is successfully hidden!
#        [0.0025, 0.9975, 0.0000, 0.0000],
#        [0.0022, 0.8789, 0.1189, 0.0000],
#        [0.2111, 0.5739, 0.0039, 0.2111]])
```
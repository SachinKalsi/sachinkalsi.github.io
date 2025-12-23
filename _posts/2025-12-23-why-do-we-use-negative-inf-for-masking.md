---
layout: post
title: "Why Do We Use Negative Infinity for Masking in Attention?"
date: 2025-12-23
author: "Sachin Kalsi"
---
Why Setting Scores to `0` Doesn't Work?

## Introduction

In decoder-only models (like GPT), each token should only "see" previous tokens, not future ones. This is called **causal attention**. To enforce this, we use **masking**. But here's the trick: we don't mask future tokens with `0`—we use **negative infinity** ($-\infty$).

---

## 1. What is Causal Masking?

When processing a sequence, the $i$-th token should only attend to tokens from position $0$ to $i$. We apply masking to the attention scores before softmax.

We create a mask using `torch.tril` (lower triangular matrix):
- Past/current tokens → `1` (True)
- Future tokens → `0` (False)

---

## 2. Why Setting Scores to `0` Doesn't Work

Here's the softmax formula:

$$\text{Softmax}(x_i) = \frac{e^{x_i}}{\sum_{j} e^{x_j}}$$

If you set a future token's score to $0$:
- The numerator becomes $e^0 = 1$
- The token still gets a **non-zero probability**!

This defeats the purpose of masking.

---

## 3. The Solution: Use $-\infty$

Replace future token scores with $-\infty$ instead of $0$:
- $e^{-\infty} = 0$
- Softmax output for future tokens becomes **exactly** $0$

**Practical Note:** In FP16 training, we use `-65504` (the minimum float16 value) instead of literal infinity to avoid numerical issues. Use `torch.finfo(dtype).min` to get this value.

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
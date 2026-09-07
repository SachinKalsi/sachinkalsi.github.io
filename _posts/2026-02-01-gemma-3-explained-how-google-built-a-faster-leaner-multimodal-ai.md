---
layout: post
title: "Gemma 3 Explained: How Google Built a Faster, Leaner Multimodal AI"
date: 2026-02-01
author: "Sachin Kalsi"
description: "How Gemma 3 got faster and leaner: SigLIP over CLIP, 128K context by interleaving, grouped-query attention, QK-Norm, and quantization-aware training."
image: "/assets/images/posts/gemma-3-explained-how-google-built-a-faster-leaner-multimodal-ai/gemma-3-explained-how-google-built-a-faster-leaner-multimodal-ai-og.jpg"
image_width: 1200
image_height: 630
image_alt: "created using Nano Banana"
tags:
  - LLM Architecture
  - Gemma 3
  - Multimodal
  - NLP
  - Decoder
# Migrated from Medium. Set the Medium story canonical to this URL.
---
Google released the Gemma 3 technical report and it shows real progress in open weights AI. Instead of focusing only on scale, Gemma 3 is built around efficiency. It can handle much longer context, understand images better and run faster on hardware.

This post explains the main technical decisions behind Gemma 3 and why they matter.

![](/assets/images/posts/gemma-3-explained-how-google-built-a-faster-leaner-multimodal-ai/gemma-3-explained-how-google-built-a-faster-leaner-multimodal-ai-1.png)

*created using Nano Banana*

## Multimodal Architecture: Why SigLIP Trumps CLIP

Gemma 3 is a native multimodal LLM, but it moves away from the traditional CLIP-based approach. Instead, it utilizes the **SigLIP (Sigmoid Language-Image Pre-training)** architecture

**The Scalability Secret:** Unlike CLIP, which uses a contrastive loss requiring all image-text pairs to be calculated (softmax), SigLIP uses a sigmoid loss. This treats the task as a series of binary outcomes, making it significantly easier to scale.

## Breaking the Context Barrier: 128K with Interleaving

Handling a **128K context window** is computationally expensive. In standard decoder-only LLMs, every token must “see”every previous token at every layer, leading to massive slowdowns.

Gemma 3 solves this with **Interleaving Methods**:

**Local Layers:** These focus on a limited window (e.g., the last 1024 tokens) to maintain high speed.

**Global Layers:** These layers look at the entire 128K context.

**The Ratio:** To balance performance and speed, Gemma 3 places **one global layer for every five local layers**.

## The Efficiency Engine: GQA and QK-Norm

Gemma 3 introduces two major changes to how the model processes information to speed up inference without sacrificing accuracy.

### Grouped-Query Attention (GQA)

Gemma 3 utilizes **Grouped-Query Attention**. As explained in the deep-dive video, GQA is the “sweet spot” between Multi-Head Attention (high quality, slow) and Multi-Query Attention (fast, lower quality).

### Replacing Soft-Capping with QK-Norm

Gemma 2 uses “soft-capping” to prevent attention scores from exploding by passing them through a tanh function. While effective, it added mathematical overhead at every step.

> **QK-Norm (Query-Key Normalization):** Gemma 3 standardizes the Q and K vectors *before* they are multiplied. By ensuring they have a mean of 0 and specific variance, it prevents the “Softmax collapse” more efficiently, making the model faster during generation.

## Training at Scale: 14 Trillion Tokens

1. **Dataset:** Trained on **14T tokens**.

2. **Tokenizer:** Uses a **SentencePiece tokenizer** with a massive **262K vocabulary**. It preserves whitespace and uses byte-level encodings to handle multilinguality and code more effectively.

3. **Distillation:** The model utilizes a teacher-student distillation process where the student model learns from **256 logits per token**, effectively using the teacher’s “mini-map” of probabilities to accelerate learning.

## Quantization-Aware Training (QAT)

Most models are trained in high precision and then “quantized” later (i.e., Post-Training Quantization), which often causes a “precision shock” that drops accuracy. But Gemma 3 uses **QAT**:

- **The “Fake Quantization” Loop:** During training, the model rounds weights in the forward pass but uses high-precision math in the backward pass. Yes, during traning there are 2 copies of models stored: one with quantised & one without!

- **The Result:** The model is able to handle low-precision environments, ensuring that the different versions remain highly accurate even when running on consumer hardware.

## Post-Training and RL: BOND, WARM, and WARP

The final “polish” of the model involves advanced Reinforcement Learning (RL) phases based on improved versions of **BOND, WARM, and WARP**.

- **Focus Areas:** These reward functions are specifically tuned for helpfulness, math, coding, and reasoning.

- **Context Scaling:** Rather than training at 128K from day one, the models are pre-trained at 32K and then “upscaled” to 128K at the very end using **RoPE (Rotary Positional Embeddings) rescaling**.

## Conclusion

Gemma 3 focuses on smarter design rather than increasing model size

## Resources

1. Gemma 3: [https://arxiv.org/abs/2503.19786](https://arxiv.org/abs/2503.19786)

2. Gemma 2: [https://arxiv.org/abs/2408.00118](https://arxiv.org/abs/2408.00118)

3. Gemma 2 explained: [https://huggingface.co/blog/gemma2](https://huggingface.co/blog/gemma2)

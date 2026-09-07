---
layout: post
title: "A Deep Dive into FlashAttention V1 -part 3"
date: 2023-10-24
author: "Sachin Kalsi"
description: "Part 3 of a FlashAttention series: the V1 algorithm in detail, covering tiling, safe softmax, and the online normalizer calculation that makes it work."
image: "/assets/images/posts/a-deep-dive-into-flashattention-v1-part-3/a-deep-dive-into-flashattention-v1-part-3-og.jpg"
image_width: 1200
image_height: 630
image_alt: "source: FlashAttention paper"
tags:
  - Transformers
  - FlashAttention
  - Large Language Models
  - Deep Learning
# Migrated from Medium. Set the Medium story canonical to this URL.
---
![](/assets/images/posts/a-deep-dive-into-flashattention-v1-part-3/a-deep-dive-into-flashattention-v1-part-3-1.png)

*source: FlashAttention paper*

Welcome to the third part of our Flash Attention series! In this segment, we will delve into the inner workings of the FlashAttention V1 algorithm, breaking down its core concepts and principles. If you’re new to the topic or want to learn more about GPUs and how FlashAttention works at a high level, be sure to check out the [Understanding GPU](/blog/flashattention-understanding-gpu-architecture-part-1/) & [advancement in GPU acceleration](/blog/flashattention-an-advancement-in-gpu-acceleration-for-training-llms/) in this series.

To begin, let’s clarify that FlashAttention’s optimizations and speed enhancements primarily target GPUs. While the paper does mention L1 and L2 cache, these optimizations are fundamentally centered around GPU performance and not the RAM or other memory components.

## A Quick Recap

In a typical GPU architecture, data is stored on the hard disk, but for any meaningful computation to occur, the data must be moved into the RAM. From there, it undergoes a journey through various memory hierarchies until it reaches the GPU. The FlashAttention algorithm is finely tuned to exploit the capabilities of the tensor cores in modern GPUs. This is especially crucial since, during the training of models like GPT-3, the tensor cores were found to be idle ~50% of the time.

FlashAttention is a notable algorithm for two primary reasons: tiling and recomputation.

**Tiling** is a technique that divides the Q, K, and V matrices into smaller blocks. This division enables the algorithm to read and process these matrices block by block instead of loading everything into the GPU’s memory at once.

**Recomputation**, on the other hand, deals with backpropagation, an essential aspect of training models. Instead of storing values in the high-bandwidth memory (HBM) and repeatedly accessing this memory, Flash Attention recomputes values when needed. Although recomputation increases the number of floating-point operations, it significantly reduces the time spent on memory access.

Now, let’s get into the nitty-gritty details of the algorithm mentioned in the paper:

> Prefer a visual explanation? Check out my video on FlashAttention V1 algorithm

## FlashAttention Algorithm

![](/assets/images/posts/a-deep-dive-into-flashattention-v1-part-3/a-deep-dive-into-flashattention-v1-part-3-2.png)

*Source: FlashAttention paper*

### Tiling Concept

The first critical concept in FlashAttention is tiling. Each token in a transformer model has associated matrices for Q, K, and V. The tiling process divides these matrices into manageable blocks for processing. The block size is typically set at 128, as mentioned by the authors.

To start with, we need to determine the block sizes for the Q, K, and V matrices. Additionally, we initialize intermediate variables such as “l” and “m” to store results. The final output is a product of all the intermediate variables. This division into blocks and storage of intermediate results is essential for efficiently combining these results later in the process.

### Safe Softmax

The heart of FlashAttention lies in its implementation of the Softmax function. The standard Softmax function often encounters challenges related to overflow and underflow, as exponential values can become excessively large or small. FlashAttention employs a “safe Softmax” to mitigate these issues.

The Safe Softmax operates by finding the maximum value in the input array and subtracting this maximum from each element in the array before exponentiation. This adjustment avoids potential overflow or underflow issues, making the calculations numerically stable.

The formula for Safe Softmax:

![](/assets/images/posts/a-deep-dive-into-flashattention-v1-part-3/a-deep-dive-into-flashattention-v1-part-3-3.png)

*Source: Image by the author*

### SafeSoftmax with Online Normalizer Calculation

FlashAttention’s Safe Softmax draws inspiration from a concept known as “online normalizer calculation.” This method, outlined in a paper by NVIDIA, [Online normalizer calculation for Softmax](https://arxiv.org/abs/1805.02867), provides a way to calculate Softmax without performing redundant memory accesses. The approach is designed to reduce the number of memory operations, making the algorithm more memory-efficient.

![](/assets/images/posts/a-deep-dive-into-flashattention-v1-part-3/a-deep-dive-into-flashattention-v1-part-3-4.png)

*Source: Image by the author.*

In this process, the algorithm maintains a running sum and modifies the Softmax calculation using intermediate values calculated on the fly. It achieves this by undoing changes made during previous iterations and applying the necessary adjustments as new elements are processed. This approach allows for Softmax calculations without revisiting all elements in the input array, thereby significantly reducing memory access.

### Combining Tiling and Safe Softmax

FlashAttention expertly combines the concepts of tiling and Safe Softmax to maximize the efficiency of its attention mechanism. By dividing the input into manageable blocks and applying Safe Softmax at the block level, FlashAttention minimizes memory access while maintaining numerical stability. This approach ensures that the algorithm operates seamlessly with GPU tensor cores, which are often underutilized during deep learning/language model training.

## Conclusion

In summary, FlashAttention V1 is a highly efficient and numerically stable attention mechanism that leverages the power of GPUs and tensor cores. Its innovative use of tiling and Safe Softmax ensures that memory access bottlenecks are minimized, allowing LLMs like GPT-3 to train more effectively.

The integration of these techniques showcases the brilliant synergy between mathematical concepts, algorithmic ingenuity, and hardware optimization in the realm of deep learning.

## References

1. [FlashAttention Paper](https://arxiv.org/abs/2205.14135)

2. [Annoted FlashAttention Paper](https://github.com/SachinKalsi/annotated-research-papers/tree/main/flash-attention)

3. [Online normalizer calculation for Softmax](https://arxiv.org/abs/1805.02867)​

4. [NVIDIA Deep Learning GPU Performance Guide​](https://docs.nvidia.com/deeplearning/performance/dl-performance-gpu-background/index.html)

---

[A Deep Dive into FlashAttention V1 -part 3](/blog/a-deep-dive-into-flashattention-v1-part-3/) was originally published in [Towards AI](https://pub.towardsai.net) on Medium, where people are continuing the conversation by highlighting and responding to this story.

---
layout: post
title: "FlashAttention: Understanding GPU Architecture-Part 1"
date: 2023-10-23
author: "Sachin Kalsi"
description: "Part 1 of a FlashAttention series: how data moves through a system, the GPU memory hierarchy, and why attention is bottlenecked by memory bandwidth."
image: "/assets/images/posts/flashattention-understanding-gpu-architecture-part-1/flashattention-understanding-gpu-architecture-part-1-og.jpg"
image_width: 1200
image_height: 630
image_alt: "Source: Image by the author."
tags:
  - GPU Computing
  - Large Language Models
  - GPU Architecture
  - FlashAttention
  - Transformers
# Migrated from Medium. Set the Medium story canonical to this URL.
---
![](/assets/images/posts/flashattention-understanding-gpu-architecture-part-1/flashattention-understanding-gpu-architecture-part-1-1.png)

*Source: Image by the author.*

## Introduction

In this three-part blog series, we will delve into the intricate world of FlashAttention, a technology that has been making waves in the field of large language models (LLMs). FlashAttention is a novel approach to optimizing the attention mechanism, making it faster and more memory-efficient.

Before we explore FlashAttention in detail, it’s crucial to have a solid grasp of the underlying hardware, specifically GPU (Graphics Processing Unit) architecture, as ***FlashAttention leverages the GPU for efficient execution***. Let’s break down the essential concepts:

## How Data Moves Through a System

![](/assets/images/posts/flashattention-understanding-gpu-architecture-part-1/flashattention-understanding-gpu-architecture-part-1-2.png)

*Source: Image by the author.*

To understand how data moves within a system, let’s begin with a simple breakdown. Data typically starts on the hard disk (HDD drive). However, for processing, we need this data in the Random Access Memory (RAM), also called main memory. Depending on the system, there may be multiple layers of memory, each with varying speeds and sizes.

1. **L3 and L2 Cache**: Some systems have L3 or L2 cache implemented, which is a fast memory compared to RAM. These caches help improve data access speed and are typically in the megabytes (MBs) range.

2. **L1 Cache/Registers**: L1 cache is an even faster memory, often referred to as SRAM or shared memory. It is located very close to the CPU and is sometimes integrated into the CPU chip. It is measured in kilobytes usually (KBs).

3. **CPU**: The central processing unit (CPU) itself has various levels of memory. These on-chip memories are much faster than off-chip memories.

4. **GPU**: In deep learning and other compute-intensive tasks, Graphics Processing Units (GPUs) are preferred due to their parallel processing capabilities. GPUs are much faster than CPUs and play a crucial role in speeding up various algorithms. FlashAttention harnesses the power of GPU

It is indeed essential to minimize data movement between these storage levels to optimize computation. This is because the time it takes to access data increases as you move further from the CPU, and data transfer can be a bottleneck in computing tasks.

## Understanding GPU Memory Hierarchy

1. **GPU Memory** (VRAM): GPUs have their own dedicated memory, often referred to as VRAM or GPU RAM. The size of this memory varies based on the GPU model, such as 16GB, 40GB, or 80GB.

2. **L2 Cache (**in GPU**)**: A level of cache memory, which is faster than GPU memory (VRAM).

3. **Streaming Multiprocessors** (SMs): GPUs are made up of multiple streaming multiprocessors, which you can think of as CPU cores (not exactly though). The number of SMs varies depending on the GPU model and the architecture.

4. **L1 Cache** (SRAM or Shared Memory): Each SM typically contains registers, L1 cache, and optionally CUDA cores and tensor cores, which are specialized hardware for matrix operations. Example: NVIDIA A100 contains 108 Streaming Multiprocessors (SMs).

5. **Tensor Cores**: Tensor cores are specialized hardware components designed for accelerated matrix multiplication. They are incredibly fast and can be idle a significant portion of the time, even during complex computations.

6. **Processing Power**: GPU performance is often measured in gigahertz (GHz), representing the number of operations it can execute in one second. In the context of deep learning, GPUs offer significantly more processing power than CPUs due to their parallelism and specialized hardware.

7. **High Bandwidth Memory** (HBM): To make the most of GPU performance, technologies like HBM have been introduced. HBM stacks memory vertically, increasing bandwidth and improving data access speeds.

8. **Kernel Fusion**: Kernel fusion is a technique that combines multiple operations into a single kernel or function. This reduces the need to transfer data between different stages of computation, minimizing data movement and memory access, and improving overall performance.

> In the case of NVIDIA A100 80GB GPUs, for instance, HBM may be implemented using 6 vertical stacks, where each stack, except one, contains 16GB of memory, summing up to the total GPU memory.

Remember, to fully utilize GPU processing power, you need to ensure that data can be moved efficiently between GPU memory, cache, and processing units.

## FlashAttention and GPU Memory

One of the challenges in training large language models is efficient memory usage. As the demand for GPU memory increases, optimizing the memory hierarchy becomes crucial. FlashAttention is designed to maximize the utilization of GPU memory and leverage its high-speed components, such as tensor cores.

The process of optimizing involves increasing the data throughput between different levels of memory, such as from GPU memory to L2 cache, and ensuring that data fits into on-chip memory like L1 cache or SRAM. This optimization allows FlashAttention to unlock the full potential of the GPU’s parallel processing power. By fusing kernels, FlashAttention can achieve faster execution and improved memory efficiency, making it a crucial optimization technique.

In [Part 2](/blog/flashattention-an-advancement-in-gpu-acceleration-for-training-llms/) of this series, we will delve deeper into the FlashAttention algorithm and how it leverages GPU architecture to enhance the performance of language models.

### References

1. [FlashAttention Paper](https://arxiv.org/abs/2205.14135)

2. [Annoted FlashAttention Paper](https://github.com/SachinKalsi/annotated-research-papers/tree/main/flash-attention)

3. [Choosing the Right GPU for Deep Learning](https://timdettmers.com/2023/01/30/which-gpu-for-deep-learning/')​

4. [NVIDIA Deep Learning GPU Performance Guide​](https://docs.nvidia.com/deeplearning/performance/dl-performance-gpu-background/index.html)

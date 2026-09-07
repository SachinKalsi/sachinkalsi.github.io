# Blog Post Template

Everything needed to add a post. `BLOG_POST_TEMPLATE.md` is in `exclude:` in
`_config.yml`, so this file is never published.

## 1. Create one file

`_posts/YYYY-MM-DD-your-slug.md` — that is the whole job. Jekyll picks it up and
it flows automatically into `/blog/`, the homepage's latest-two list,
`sitemap.xml`, `feed.xml`, and the related-notes block on other posts.

**The filename is the URL.** The permalink is `/blog/:title/`, so
`2026-09-10-kv-cache-explained.md` becomes `/blog/kv-cache-explained/`.
Put keywords in the slug — it is permanent once indexed.

## 2. Front matter

```yaml
---
layout: post
title: "KV Cache Explained: Why Inference Speeds Up After the First Token"
date: 2026-09-10
author: "Sachin Kalsi"
description: "How the KV cache trades memory for speed in autoregressive decoding, what it costs per token, and when it stops being worth it."
image: "/assets/images/posts/kv-cache-explained/kv-cache-explained-og.jpg"
image_width: 1200
image_height: 630
image_alt: "Attention keys and values reused across decoding steps instead of recomputed"
tags:
  - Large Language Models
  - PyTorch
  - Transformers
  - Attention Mechanism
categories:
  - Tutorial
---
```

| Key | Required | Notes |
|---|---|---|
| `layout` | yes | always `post` |
| `title` | yes | keep under ~60 chars; ` \| Sachin Kalsi` is appended automatically |
| `date` | yes | `YYYY-MM-DD` |
| `author` | yes | `"Sachin Kalsi"` |
| `description` | yes | **≤155 characters** — see the rule below |
| `image` | recommended | 1200×630 social card; falls back to `site.og_image` if omitted |
| `image_width` / `image_height` | with `image` | emits accurate `og:image:width`/`height` |
| `image_alt` | with `image` | describes the image; also used as the blog-grid `alt` |
| `tags` | yes | drives related-notes matching — see the rule below |
| `categories` | optional | e.g. `Tutorial`, `NLP`, `Deep Learning`; becomes `articleSection` |
| `last_modified_at` | optional | sets `dateModified`; otherwise equals `date` |

### Two hard rules

**`description` must be ≤155 characters.** `_layouts/default.html` applies
`truncate: 160` and Liquid counts the `...` inside that limit. Anything longer
ships visibly cut off mid-sentence in Google results, and the ellipsis
propagates into `og:description`, `twitter:description`, and the JSON-LD.

**Reuse existing tags — do not invent new ones.** Related notes are matched by
shared tags (max 3 shown). A post whose tags are all novel renders zero internal
links. Current vocabulary across the published posts:

```
Large Language Models · Deep Learning · NLP · Transformers · FlashAttention
PyTorch · Machine Learning · Attention Mechanism · Decoding · Decoder
Constrained Decoding · Generative AI · LLM Architecture · LLM Training
GPU Architecture · GPU Computing · GPU Acceleration · Optimization
Data Quality · Data Cleaning · Open Source · Multimodal · Gemma 3
Python · Unicode · Text Processing · Weight Initialization
```

Aim for at least two tags that overlap an existing post.

## 3. Images

Store in `assets/images/posts/<slug>/`.

- The `image:` card must be **1200×630**. The blog grid uses that aspect ratio
  with `object-fit: contain`, so off-ratio images letterbox rather than crop.
- **JPEG** for photos/gradients, **PNG** for flat text and diagrams. One card
  went 640KB as PNG → 118KB as JPEG at q86; page weight feeds Core Web Vitals.
- Body images: always write real alt text. Use empty `![]()` **only** when an
  italic caption immediately follows, so the text is not duplicated.

```markdown
![Trie of valid label tokens, with invalid branches masked](/assets/images/posts/my-slug/trie.png)

![](/assets/images/posts/my-slug/logits.png)

*Logit distribution before and after masking.*
```

## 4. Code snippets

Fence with a language tag so Rouge highlights it. The post layout adds a copy
button automatically, and `.blog-post-content pre` scrolls horizontally, so long
lines never break the page.

````markdown
```python
import torch

logits[~valid_token_mask] = float("-inf")
probs = torch.softmax(logits, dim=-1)
```
````

Use `bash`, `yaml`, `json`, `text` as appropriate. An unlabelled fence renders
but is not highlighted.

## 5. Math

MathJax 3 is already loaded on post pages — no setup. Inline `$...$`, display
`$$...$$`. kramdown rewrites `$$...$$` to `\[...\]`, which the config handles.

```markdown
Softmax over the logit vector:

$$p_i = \frac{\exp(l_i)}{\sum_{j} \exp(l_j)}$$

so a masked token with $l_i = -\infty$ gets exactly $0$.
```

- **Prefer LaTeX over screenshots of equations.** Rendered-formula images are
  invisible to search; LaTeX is real text in the HTML, stays crisp at any zoom,
  and is selectable.
- **Keep math out of `##` headings** — it mangles the generated anchor id.
- Display math cannot wrap. Long equations scroll inside their own box
  (`mjx-container[display="true"]` has `overflow-x: auto`), but prefer splitting
  a wide expression into two `$$` blocks over one very long line.

## 6. Interactive widgets and raw HTML

Raw HTML goes straight into the `.md` — kramdown passes it through, so a small
interactive demo is just a `<div>` and a `<script>`. Three gotchas:

1. Leave a **blank line** before and after the block.
2. **No leading indentation** — 4+ spaces makes kramdown treat it as a code block.
3. Add `markdown="1"` on a wrapper if you want markdown processed inside it.

If the same widget is needed in more than one post, create `_includes/widgets/`
and move it there, then pull it in with:

```liquid
{% include widgets/my-widget.html %}
```

That keeps the JS in one place instead of copy-pasted per post. Use the site's
CSS tokens (`--border`, `--signal`, `--ink-soft`, `--paper`) so it looks native.
Do not create the directory until something actually needs it.

**Widgets must supplement prose, never carry the explanation.** They render
client-side, so a crawler sees an empty `<div>`. If the point only exists inside
the widget, it does not exist for search.

## 7. Before publishing

```bash
bundle exec jekyll build     # must be warning-free
bundle exec jekyll serve     # http://127.0.0.1:4000/blog/
```

A **permalink-conflict warning** means two files claim the same URL and Jekyll
silently drops one. Never ship past it.

Checklist:

- [ ] `description` ≤155 chars, does not end in `...` in the built HTML
- [ ] at least two tags shared with an existing post
- [ ] **2–3 internal links** to related posts in the body
- [ ] outbound citations to papers, docs, or repos
- [ ] **≥600 words** — short generic explainers read as AI slop wherever hosted
- [ ] leads with something only you have: a production number, the approach that
      failed, real logs, exact versions
- [ ] 1200×630 card present, correct format, alt text written
- [ ] exactly one `<h1>` (the title — do not repeat it as `##` in the body)
- [ ] no stray `\xa0` if the text was pasted from Medium or Google Docs

## 8. If you also post it to Medium

Publish **here first**, let the URL get indexed, *then* post to Medium with the
canonical pointing back:

> Edit story → **Advanced Settings** → "This story was originally published
> elsewhere" → paste your URL → Save canonical link → Publish

Reversing that order is what caused Medium to outrank this site in the first
place. Only the story's author can set a canonical — which also works for
publication pieces such as Towards AI.

# Blog Post Front Matter Guide

## Complete Example with All Fields

Here's a complete example of what you can add to your blog post front matter:

```yaml
---
layout: post
title: "Your Blog Post Title"
date: 2025-12-22
author: "Sachin Kalsi"
description: "A compelling 150-160 character description for SEO and social sharing"
image: "/assets/images/your-post-image.jpg"  # Optional: For social sharing
tags: 
  - Python
  - NLP
  - Machine Learning
  - Unicode
categories:
  - Tutorial
  - Data Science
excerpt: "Optional excerpt that appears on blog listing page (if not provided, first paragraph is used)"
last_modified_at: 2025-12-23  # Optional: When you last updated the post
---
```

## Required Fields (Minimum)

```yaml
---
layout: post
title: "Your Post Title"
date: 2025-12-22
author: "Sachin Kalsi"
description: "SEO description"
---
```

## Optional Fields Explained

### `description` (Recommended for SEO)
- **What**: 150-160 character description
- **Used for**: Meta tags, social sharing, search results
- **Example**: `"Learn about Unicode normalization and text encoding in Python"`

### `image` (Optional but Recommended)
- **What**: Path to an image for social sharing (Open Graph/Twitter Cards)
- **Best size**: 1200x630px
- **Example**: `"/assets/images/unicode-guide.jpg"`
- **Note**: If not provided, uses default OG image

### `tags` (Optional)
- **What**: Array of topic tags
- **Used for**: Categorization, filtering (if you add tag pages later)
- **Example**: 
  ```yaml
  tags:
    - Python
    - NLP
    - Tutorial
  ```

### `categories` (Optional)
- **What**: Array of categories
- **Used for**: Broader categorization
- **Example**:
  ```yaml
  categories:
    - Tutorial
    - Data Science
  ```

### `excerpt` (Optional)
- **What**: Custom excerpt for blog listing page
- **Note**: If not provided, Jekyll uses first paragraph automatically

### `last_modified_at` (Optional)
- **What**: Date when post was last updated
- **Format**: `YYYY-MM-DD` or `YYYY-MM-DD HH:MM:SS`
- **Used for**: SEO (shows Google when content was updated)

## Where Social Links Go

**IMPORTANT**: Social links (LinkedIn, GitHub, etc.) are NOT in individual blog posts!

They go in `_config.yml` (site-wide settings):

```yaml
# In _config.yml
author:
  name: "Sachin Kalsi"
  linkedin: "https://www.linkedin.com/in/sachinkalsi/"
  github: "https://github.com/sachinkalsi"
  medium: "https://medium.com/@sachinkalsi"
  youtube: "https://www.youtube.com/@ml-simplified/"
```

These are automatically used in:
- SEO meta tags
- Structured data (JSON-LD)
- Social sharing
- Site header/footer

## Quick Reference

| Field | Required? | Purpose |
|-------|----------|---------|
| `layout` | ✅ Yes | Always `post` |
| `title` | ✅ Yes | Post title |
| `date` | ✅ Yes | Publication date |
| `author` | ✅ Yes | Author name |
| `description` | ⚠️ Recommended | SEO & social sharing |
| `image` | ❌ Optional | Social sharing image |
| `tags` | ❌ Optional | Topic tags |
| `categories` | ❌ Optional | Post categories |
| `excerpt` | ❌ Optional | Custom listing excerpt |
| `last_modified_at` | ❌ Optional | Update date |


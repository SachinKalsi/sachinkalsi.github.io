# Portfolio Website with Jekyll

This portfolio website is now powered by Jekyll, making it easy to write and manage blog posts.

## Setup

1. **Install Ruby and Bundler** (if not already installed):
   ```bash
   # macOS (using Homebrew)
   brew install ruby
   
   # Or use rbenv/rvm for Ruby version management
   ```

2. **Install Jekyll and dependencies**:
   ```bash
   bundle install
   ```

3. **Run the Jekyll server**:
   ```bash
   bundle exec jekyll serve --host 0.0.0.0
   ```

4. **View your site**:
   Open [http://localhost:4000](http://localhost:4000) in your browser

## Writing Blog Posts

1. Create a new file in the `_posts` directory with the naming format:
   ```
   YYYY-MM-DD-your-post-title.md
   ```

2. Add front matter at the top of each post:
   ```yaml
   ---
   layout: post
   title: "Your Post Title"
   date: 2024-01-15
   author: "Sachin Kalsi"
   description: "A clear 140-160 character summary that includes the main topic and value."
   image: "/assets/images/posts/your-post-og.png"
   tags:
     - NLP
     - Machine Learning
     - PyTorch
   categories:
     - Tutorial
   ---
   ```

3. Write your content in Markdown below the front matter.

4. Your post will automatically appear on:
   - The blog listing page: `/blog/`
   - The homepage (if configured)

## Blog SEO Checklist

Use this checklist every time you create or update a post.

- **Title:** Use a clear, searchable title. Prefer specific terms like `Transformer Attention Masking in PyTorch` over vague titles like `Attention Notes`.
- **Description:** Add a unique `description` in the front matter. Keep it around 140-160 characters and describe what the reader will learn.
- **Tags/categories:** Add 3-6 relevant `tags` and 1-2 `categories`. These power metadata and topic signals.
- **Headings:** The post title becomes the page `<h1>`. Start the body with `##` sections, then use `###` for subsections. Avoid adding another `#` heading inside the post body.
- **Internal links:** Add links to related posts, `/blog/`, or relevant portfolio content when useful.
- **External links:** Link to useful references, docs, papers, or source material when they help the reader.
- **Content quality:** Make the post specific, original, and complete enough to answer the search intent. Avoid publishing very short notes as indexable posts.
- **Code blocks:** Use fenced code blocks with a language when possible:
  ````
  ```python
  print("hello")
  ```
  ````
- **Build check:** Run `bundle exec jekyll build` before deploying.

## Adding Images To Markdown Posts

Place post images under:

```text
assets/images/posts/
```

Use normal Markdown image syntax:

```markdown
![Lower triangular causal attention mask used in transformer decoder self-attention](/assets/images/posts/causal-attention-mask.png)
```

Image tips:

- Use descriptive filenames, such as `causal-attention-mask.png`.
- Always write descriptive alt text. Avoid generic alt text like `image` or `thumbnail`.
- Compress large images before adding them.
- Use `.webp` or `.png` for diagrams and `.jpg`/`.webp` for photos.

## Social / OG Images

Each important post should have a social preview image for Google, LinkedIn, Twitter/X, and other link previews.

Recommended size:

```text
1200 x 630 px
```

Add the image path in the post front matter:

```yaml
image: "/assets/images/posts/transformer-attention-masking-og.png"
```

Good OG images usually include:

- The post topic or title in large readable text
- Your name or site identity
- A simple relevant visual, diagram, or code/ML theme
- Enough contrast to be readable on mobile previews

## Google Search Console Checklist

After deploying a new or updated post:

1. Open Google Search Console.
2. Submit or resubmit:
   ```text
   https://sachinkalsi.github.io/sitemap.xml
   ```
3. Use URL Inspection for:
   - `https://sachinkalsi.github.io/blog/`
   - The new post URL
4. Click **Test Live URL**.
5. If the page is available to Google, click **Request indexing**.
6. Check that:
   - Crawl allowed: `Yes`
   - Page fetch: `Successful`
   - Indexing allowed: `Yes`
   - User-declared canonical points to the expected URL
   - Google-selected canonical is the inspected URL or the intended canonical

If Google reports `Crawled - currently not indexed`, wait a few days and improve content quality/internal links if it persists.

## Handling Old Blog URLs

If an old URL exists in Google Search Console or has backlinks, do not leave it as a 404 if it has value.

Best option:

- Migrate the old article into a new `_posts/...md` post.
- Add a small legacy redirect page at the old path.
- Point the old URL to the closest matching new post.

Acceptable option:

- If the old article is not worth migrating, redirect the old URL to `/blog/`.
- Mark the legacy page `noindex, follow`.
- Keep it out of the sitemap with `sitemap: false`.

Example legacy redirect page:

```html
---
layout: null
permalink: /old/blog/url.html
robots: "noindex, follow"
sitemap: false
---

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="0; url=/blog/">
    <meta name="robots" content="noindex, follow">
    <link rel="canonical" href="https://sachinkalsi.github.io/blog/">
    <title>Article moved | Sachin Kalsi</title>
</head>
<body>
    <p>This article moved to <a href="/blog/">the blog</a>.</p>
</body>
</html>
```

## Lighthouse / PageSpeed Checks

Use [PageSpeed Insights](https://pagespeed.web.dev/) after deployment for:

- Homepage: `https://sachinkalsi.github.io/`
- Blog index: `https://sachinkalsi.github.io/blog/`
- Each important post URL

Focus on mobile results first.

Core Web Vitals targets:

- **LCP:** under 2.5 seconds
- **INP:** under 200 ms
- **CLS:** under 0.1

Common things to watch:

- Large images without compression
- Too many external scripts or stylesheets
- MathJax loading on posts that do not need math
- Font and icon libraries blocking render
- Layout shifts from images without stable dimensions

## File Structure

```
portfolio/
├── _config.yml          # Jekyll configuration
├── _layouts/            # HTML layouts
│   ├── default.html     # Base layout with header/footer
│   └── post.html        # Blog post layout (includes "Return to All Blogs" link)
├── _posts/              # Blog posts (Markdown files)
├── assets/images/posts/ # Blog content and OG images
├── blog/index.html      # Blog listing page at /blog/
├── index.html           # Homepage
└── Gemfile              # Ruby dependencies
```

## Features

- ✅ Easy blog post creation with Markdown
- ✅ Blog listing page at `/blog/`
- ✅ Each blog post has a "Return to All Blogs" link
- ✅ Automatic date formatting
- ✅ Responsive design matching your portfolio style

## Building for Production

To build the static site:
```bash
bundle exec jekyll build
```

The generated site will be in the `_site` directory.

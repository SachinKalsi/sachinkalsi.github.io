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
   thumbnail: "/path/to/thumbnail.jpg"  # Optional
   ---
   ```

3. Write your content in Markdown below the front matter.

4. Your post will automatically appear on:
   - The blog listing page: `/blog/`
   - The homepage (if configured)

## File Structure

```
portfolio/
├── _config.yml          # Jekyll configuration
├── _layouts/            # HTML layouts
│   ├── default.html     # Base layout with header/footer
│   └── post.html        # Blog post layout (includes "Return to All Blogs" link)
├── _posts/              # Blog posts (Markdown files)
├── blog.html            # Blog listing page
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


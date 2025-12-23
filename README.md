# Portfolio Website with Jekyll

This portfolio website is powered by Jekyll, making it easy to write and manage blog posts.

## Getting Started

### Prerequisites

- Ruby (version 2.6 or higher)
- Bundler gem

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/SachinKalsi/sachinkalsi.github.io.git
   cd sachinkalsi.github.io
   ```

2. **Install Ruby and Bundler** (if not already installed):
   ```bash
   # macOS (using Homebrew)
   brew install ruby
   
   # Or use rbenv/rvm for Ruby version management
   ```

3. **Install Jekyll and dependencies**:
   ```bash
   bundle install
   ```
   
   If you encounter permission issues, install to a local directory:
   ```bash
   bundle install --path vendor/bundle
   ```

## Running the Site Locally

1. **Start the Jekyll development server**:
   ```bash
   bundle exec jekyll serve --host 0.0.0.0
   ```
   
   The `--host 0.0.0.0` flag allows access from other devices on your network.

2. **View your site**:
   - Open [http://localhost:4000](http://localhost:4000) in your browser
   - Or access from other devices using your machine's IP address on port 4000

3. **Stop the server**:
   Press `Ctrl+C` in the terminal

## Adding Blog Posts

### Creating a New Blog Post

1. **Create a new file** in the `_posts` directory with the naming format:
   ```
   YYYY-MM-DD-your-post-title.md
   ```
   
   Example: `2024-12-23-my-awesome-post.md`

2. **Add front matter** at the top of the file:
   ```yaml
   ---
   layout: post
   title: "Your Post Title"
   date: 2024-12-23
   author: "Sachin Kalsi"
   ---
   ```

3. **Write your content** in Markdown below the front matter:
   ```markdown
   ---
   layout: post
   title: "My Awesome Post"
   date: 2024-12-23
   author: "Sachin Kalsi"
   ---
   
   # Introduction
   
   This is my blog post content written in Markdown.
   
   ## Section 1
   
   You can use all standard Markdown features:
   
   - Lists
   - **Bold text**
   - *Italic text*
   - [Links](https://example.com)
   
   ### Code Blocks
   
   ```python
   def hello_world():
       print("Hello, World!")
   ```
   
   ### Images
   
   To add images, place them in the `assets/images/` directory and reference them:
   
   ![Alt text](/assets/images/your-image.jpg)
   ```

4. **Save the file** - Your post will automatically appear on:
   - The blog listing page: `/blog/`
   - The homepage (if configured)

### Blog Post Features

- ✅ Automatic date formatting
- ✅ "Return to All Blogs" link on each post
- ✅ Syntax highlighting for code blocks
- ✅ Copy-to-clipboard button for code snippets
- ✅ Responsive design

### Adding Medium Articles

Medium articles are loaded from `medium-blogs.json`. To add a new Medium article:

1. Edit `medium-blogs.json`
2. Add a new entry with the following structure:
   ```json
   {
     "link": "https://medium.com/@sachinkalsi/your-article",
     "thumbnail": "https://example.com/thumbnail.png",
     "type": "blog",
     "icon": "fas fa-pen",
     "title": "Your Article Title",
     "description": "Your article description",
     "footerIcon": "fab fa-medium",
     "footerText": "Medium"
   }
   ```

## File Structure

```
portfolio/
├── _config.yml          # Jekyll configuration
├── _layouts/            # HTML layouts
│   ├── default.html     # Base layout with header/footer
│   └── post.html        # Blog post layout
├── _posts/              # Blog posts (Markdown files)
│   └── YYYY-MM-DD-title.md
├── assets/               # Static assets
│   └── images/          # Blog post images
├── blog.html            # Blog listing page
├── blog/                # Blog directory
│   └── index.html       # Blog listing page (served at /blog/)
├── index.html           # Homepage
├── medium-blogs.json    # Medium articles data
├── Gemfile              # Ruby dependencies
└── README.md            # This file
```

## Building for Production

To build the static site:
```bash
bundle exec jekyll build
```

The generated site will be in the `_site` directory.

## Deployment

This site is automatically deployed to GitHub Pages via GitHub Actions when you push to the `master` branch.

## Troubleshooting

### Port Already in Use
If port 4000 is already in use, specify a different port:
```bash
bundle exec jekyll serve --host 0.0.0.0 --port 4001
```

### Bundle Install Issues
If you encounter permission errors:
```bash
bundle install --path vendor/bundle
```

### Jekyll Build Errors
If you see SCSS or other build errors, ensure all dependencies are installed:
```bash
bundle update
bundle exec jekyll clean
bundle exec jekyll build
```

## Features

- ✅ Easy blog post creation with Markdown
- ✅ Blog listing page at `/blog/`
- ✅ Each blog post has a "Return to All Blogs" link
- ✅ Automatic date formatting
- ✅ Syntax highlighting for code blocks
- ✅ Copy-to-clipboard for code snippets
- ✅ Responsive design
- ✅ Monochromatic professional design
- ✅ Support for both Jekyll posts and Medium articles

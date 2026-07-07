---
target: index.html + blog (homepage, blog index, post layout)
total_score: 19
p0_count: 2
p1_count: 2
timestamp: 2026-07-07T09-52-29Z
slug: index-html-blog
---
Method: dual-agent (A: a47b5f5ed0faed960 · B: ac28916d3ba08cd7f)

## Design Health Score

| # | Heuristic | Score | Key Issue |
|---|-----------|-------|-----------|
| 1 | Visibility of System Status | 2 | JSON-fetched video/Medium grids fail silently to console only; user sees an empty section forever |
| 2 | Match System / Real World | 2 | Card-grid-for-everything doesn't match how a technical reader mentally sorts videos vs. original posts vs. reposts |
| 3 | User Control and Freedom | 2 | No search/filter on blog index despite tag data existing; tags render as inert `<span>`, not links |
| 4 | Consistency and Standards | 2 | Homepage hero and `body.writing-page` header are two different identities (bio/CTAs hidden entirely on writing pages) |
| 5 | Error Prevention | 3 | Low-risk surface, no destructive actions |
| 6 | Recognition Rather Than Recall | 2 | No breadcrumbs beyond one "Return to All Blogs" link; zero next/prev post navigation |
| 7 | Flexibility and Efficiency | 1 | No keyboard shortcuts, no visible RSS, no sort/filter |
| 8 | Aesthetic and Minimalist Design | 2 | `text-align: justify` on post body text creates uneven rivers; decorative eyebrows/badges add noise without payoff |
| 9 | Error Recovery | 2 | Jekyll-post empty state exists, but JS-driven video/Medium grids degrade via console log only, no visible message |
| 10 | Help and Documentation | 1 | No credibility content beyond one bio line; no contextual help near code blocks |
| **Total** | | **19/40** | **Poor — major UX overhaul needed** |

## Anti-Patterns Verdict

**Start here. Does this look AI-generated? Yes, unambiguously.**

**LLM assessment**: This is textbook AI/template output. `--primary: #2563eb` (labeled "Royal Blue" in a code comment), `--bg-body: #f8fafc`, white cards, 8px radius everywhere, and `.card:hover { transform: translateY(-4px); box-shadow: var(--shadow-lg) }` are the default output of every "build me a landing page" AI prompt from 2024-25. Compounding it: uppercase-tracked eyebrows (`.hero-role`, `.writing-eyebrow`), a gradient badge (`linear-gradient(135deg, var(--primary), var(--accent-purple))`), and unused "brand" variables (`--accent-purple`, `--accent-cyan`) that exist by convention, not by choice. One typeface (Inter) carries every role from a 2.75rem hero to a 0.7rem badge — zero contrast axis, zero technical voice. DESIGN.md already names this "The SaaS Template" baseline and flags these exact patterns as anti-references, so the codebase is self-aware of the problem but hasn't fixed it yet.

**Deterministic scan**: `detect.mjs` returned exit code 2 with 6 findings, all warning-severity, all in `_layouts/default.html` (the shared stylesheet):
- 2× **side-tab accent border** — `.writing-preview-copy { border-left: 3px solid var(--primary) }` (line 665) and a second instance at line 937. Both are true positives — an absolute-banned pattern per the parent skill's rules.
- 3× **overused font** — `font-family: 'Inter'` flagged at the `@font-face` declaration and two usages (lines 147, 184, 1002). True positive, though self-hosted/preloaded deliberately rather than pulled lazily from a CDN.
- 1× **dark-glow** — `box-shadow: 0 4px 12px rgba(37,99,235,0.12)` on `.cta-btn:hover` (line 335). Likely a **false positive**: this is a light-mode button hover elevation, not a dark-mode glow; the detector's heuristic fired on the colored rgba shadow alone without checking background context.

No findings in `index.html`, `blog/index.html`, or `post.html` — the anti-patterns are concentrated entirely in the shared stylesheet, which is good news for how surgical a fix can be.

**Browser evidence**: Skipped. No dev server was running and no built `_site/` output exists for this Jekyll project in this session, and no browser automation tool was loaded — the review is based on full source + CSS inspection instead.

## Overall Impression

The site is engineered with real care under the hood (structured data, reading-time calc, a working copy-code button, semantic markup) but the surface reads as a generic SaaS template rather than a technical expert's home. The biggest opportunity: the visual system is the thing standing between "solid engineering" and "credible technical voice" — and per the detector, it's isolated almost entirely in one file (`_layouts/default.html`), so a redesign is more tractable than the score suggests.

## What's Working

- **Copy-code button** on `pre` blocks (`.copy-code-button`, clipboard fallback via `execCommand`) is a genuinely practitioner-useful, well-implemented detail — exactly the kind of thing a technical reader notices.
- **SEO/structured-data discipline** is unusually thorough for a personal site: schema.org JSON-LD for Person, WebSite, BlogPosting, and VideoObject.
- **Reading-time calculation and semantic `itemprop` markup** in `post.html` show real engineering care, even where the surface design doesn't reflect it yet.

## Priority Issues

**[P0] The entire visual system is the site's own named anti-reference.** Royal-blue accent, slate/white two-tone background, uniform card grid, single typeface, ambient-shadow hover-lift — this is generic SaaS-template DNA, and PRODUCT.md explicitly says it undercuts credibility with NLP/ML practitioners. **Fix**: replace the accent palette, remove the `translateY(-4px)` hover-lift, and introduce a real typographic contrast axis (e.g., a mono face for code/labels, distinct from body). **Suggested command**: `/impeccable colorize` + `/impeccable typeset`.

**[P0] Blog treats original posts and Medium reposts as visually identical.** Both render as the same `.card.writing-card` in `blog/index.html`, so a visitor can't tell a from-scratch technical deep-dive from a syndicated summary — directly undermining the "assess credibility fast" job PRODUCT.md defines for this audience. **Fix**: differentiate treatment (primary list vs. a secondary "also published elsewhere" strip) instead of parallel grids. **Suggested command**: `/impeccable layout`.

**[P1] Justified body text in blog posts.** `.blog-post-content p { text-align: justify; text-justify: inter-word }` produces uneven word-spacing/rivers on the web without hyphenation — a known readability anti-pattern for long technical reading. **Fix**: switch to `text-align: left`. **Suggested command**: `/impeccable typeset`.

**[P1] No prev/next or related-post navigation.** `post.html` offers only a single "Return to All Blogs" link — no session depth, no related-by-tag suggestions, no way to keep a technical reader reading. **Fix**: add prev/next post links and 2-3 related-by-tag posts at the article footer. **Suggested command**: `/impeccable onboard` or `/impeccable layout`.

**[P2] Tags are decorative, not functional.** `post.tags` data exists but renders as static `<span>` elements on both the homepage and blog index, offering zero filtering utility. **Fix**: link tags to a filtered `/blog/` view. **Suggested command**: `/impeccable clarify` / `/impeccable layout`.

## Persona Red Flags

**Alex (Power User)**: No RSS link surfaced in the UI (only `<link rel="alternate">` in `<head>`), no tag filtering despite the data existing, no way to move faster than reading every card top to bottom. Will bounce to a competitor's blog with a filterable index.

**Sam (Accessibility-Dependent)**: `:focus` is entirely absent from the stylesheet — keyboard users get zero visual indication of which link or button is focused anywhere on the site. This is a hard blocker for keyboard navigation, not a nice-to-have.

**Casey (Distracted Mobile)**: Homepage stacks video grid, writing preview, and ~10 topic-tag chips vertically with no mobile-specific prioritization, producing a long undifferentiated scroll before reaching any real technical content.

## Minor Observations

- `<meta name="theme-color" content="#3b82f6">` doesn't even match `--primary: #2563eb` — two different blues in the same file.
- "Watch Now →" / "Read →" microcopy is generic filler, not the sharp/technical voice PRODUCT.md calls for.
- Empty-state icons (e.g. `fa-blog` at 0.3 opacity) are decorative filler rather than useful guidance.

## Questions to Consider

- If every card — a YouTube video, a 2000-word technical post, a Medium repost — gets the same border-radius, shadow, and hover-lift, what is the grid actually telling a visitor about content quality?
- If the reader's job-to-be-done is "decide if this person knows what they're talking about" in under 10 seconds, why is the first thing they see a centered bio and social icons rather than a single piece of real technical proof — a diagram, a benchmark, a code snippet?
- What would it look like for the blog to feel like an active technical publication instead of a static brochure?

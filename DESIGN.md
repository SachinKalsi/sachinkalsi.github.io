---
name: Sachin Kalsi Portfolio
description: Personal blog and portfolio for a Data Science Architect (NLP) — a technical field-notebook identity replacing the prior generic-SaaS baseline.
colors:
  ink: "#12141a"
  ink-soft: "#454b58"
  ink-faint: "#848c9c"
  paper: "#f5f6f8"
  surface: "#ffffff"
  border: "#d8dbe2"
  border-strong: "#b3b8c4"
  signal: "#d94a1f"
  signal-dark: "#b23a17"
  signal-tint: "#fdece4"
  code-bg: "#14161c"
  code-ink: "#d8dbe2"
  badge-video: "#9a3412"
  badge-video-bg: "#fff4ec"
  badge-video-border: "#fdba8c"
  badge-blog: "#0f5132"
  badge-blog-bg: "#eefbf3"
  badge-blog-border: "#9fd8b8"
typography:
  display:
    fontFamily: "Archivo, sans-serif"
    fontSize: "clamp(2.25rem, 4vw, 2.9rem)"
    fontWeight: 800
    lineHeight: 1.2
    letterSpacing: "-0.03em"
  headline:
    fontFamily: "Archivo, sans-serif"
    fontSize: "1.75rem"
    fontWeight: 800
    lineHeight: 1.25
    letterSpacing: "normal"
  title:
    fontFamily: "Archivo, sans-serif"
    fontSize: "1.35rem"
    fontWeight: 700
    lineHeight: 1.4
    letterSpacing: "-0.02em"
  body:
    fontFamily: "Archivo, sans-serif"
    fontSize: "1rem"
    fontWeight: 400
    lineHeight: 1.6
    letterSpacing: "normal"
  label:
    fontFamily: "JetBrains Mono, monospace"
    fontSize: "0.8rem"
    fontWeight: 500
    lineHeight: 1.4
    letterSpacing: "0"
  code:
    fontFamily: "JetBrains Mono, monospace"
    fontSize: "0.9em"
    fontWeight: 400
    lineHeight: 1.5
    letterSpacing: "0"
rounded:
  sm: "3px"
  md: "3px"
  lg: "6px"
spacing:
  sm: "8px"
  md: "20px"
  lg: "30px"
  xl: "40px"
components:
  button-primary:
    backgroundColor: "{colors.ink}"
    textColor: "#ffffff"
    rounded: "{rounded.sm}"
    padding: "10px 20px"
  button-primary-hover:
    backgroundColor: "{colors.signal}"
  button-secondary:
    backgroundColor: "{colors.surface}"
    textColor: "{colors.ink}"
    rounded: "{rounded.sm}"
    padding: "10px 20px"
  button-secondary-hover:
    backgroundColor: "{colors.surface}"
  card:
    backgroundColor: "{colors.surface}"
    rounded: "{rounded.sm}"
    padding: "20px"
---

# Design System: Sachin Kalsi Portfolio

## 1. Overview

**Creative North Star: "The Field Notebook"**

The site reads as a working engineer's technical notebook, not a marketing template: high-contrast ink-on-paper for reading, a single committed signal color (burnt-orange) used sparingly and deliberately, and monospace reserved for exactly the places a developer expects it — code, dates, tags, source labels — never as costume. This replaces the prior "SaaS Template" baseline (royal-blue `#2563eb`, Slate-50/white, Inter-everywhere, ambient-shadow hover-lift cards), which PRODUCT.md named as an explicit anti-reference undermining credibility with an NLP/ML practitioner audience.

The structural skeleton from the previous system is preserved (hero → content sections → grid/list → footer) because it was sound information architecture; what changed is the surface treatment and, on the blog specifically, the decision to stop giving original technical notes and syndicated reposts the same visual weight.

**Key Characteristics:**
- One committed accent — signal orange (#d94a1f) — carries links, hover states, and the hero role marker. Everywhere else is ink/paper neutrals.
- Flat by default: no ambient shadows, no hover-lift transforms. Depth comes from a 1px border shifting to signal-orange on hover.
- Two-family type system: Archivo (sans, UI/display/body) + JetBrains Mono (code, dates, tags, source labels, the `hero-role` marker) — a real contrast axis, not size/weight variation on one face.
- Original blog posts (a card grid, "Implementation Notes") are visually distinct from syndicated reposts (a compact row list, "Also Published Elsewhere") so depth is never confused with a repost.
- Sharper geometry: 3px card radius (down from 8–16px), signaling precision over the prior rounded-SaaS softness.

## 2. Colors

Restrained-to-committed strategy: a near-black ink on near-white paper carries almost all of the surface; one saturated accent (signal orange) is spent deliberately on interactive and identity moments, never as background wash.

### Primary
- **Signal Orange** (#d94a1f): links, hover borders, the `// ` hero-role marker, read-more CTAs, tag-badge accents, blockquote mark. The one color that means "interactive" or "brand" anywhere on the site.
- **Signal Orange Dark** (#b23a17): pressed/dark hover variant where needed.
- **Signal Tint** (#fdece4): reserved for future soft-fill use (e.g. selection highlight); not yet spent anywhere — don't add it without a reason.

### Neutral
- **Ink** (#12141a): primary text, headings, primary button fill.
- **Ink Soft** (#454b58): secondary/muted text (descriptions, meta).
- **Ink Faint** (#848c9c): tertiary text — footer meta, mono labels, timestamps.
- **Paper** (#f5f6f8): page background, subtle card-image placeholder fill.
- **Surface** (#ffffff): card and container background, sitting just above paper.
- **Border** (#d8dbe2): default hairline borders and dividers.
- **Border Strong** (#b3b8c4): secondary-button borders, stronger dividers.
- **Code BG / Code Ink** (#14161c / #d8dbe2): reserved exclusively for `<pre>` code blocks — the only intentionally dark surface on the site.

### Named Rules
**The One Accent Rule.** Signal orange is the only saturated color on the site. If a new component reaches for a second bright hue, that's drift — stop and ask whether ink, paper, or an existing neutral would do the job instead.

**Documented exception:** the copy-code button's `.copied` success state uses green (`rgba(34,197,94,*)` / `#86efac`) on the dark code surface. This is universal success semantics, not brand color, and is scoped to a two-second transient state — it doesn't violate the One Accent Rule.

## 3. Typography

**Display/Body Font:** Archivo (Google Fonts, weights 400–800), fallback `sans-serif`.
**Mono/Label Font:** JetBrains Mono (Google Fonts, weights 400–700), fallback `monospace`.

**Character:** A geometric grotesk (Archivo) for everything a reader parses as prose or UI, paired with a monospace face (JetBrains Mono) for everything that's technically precise — code, dates, tags, source labels, the hero-role line. The pairing itself is the "engineer's notebook" signal: prose reads cleanly, metadata reads like annotations in the margin.

### Hierarchy
- **Display** (800, `clamp(2.25rem, 4vw, 2.9rem)`, letter-spacing -0.03em): homepage hero name (`.hero-name`).
- **Headline** (800, 1.75rem, line-height 1.25): blog listing/writing-page hero title (`.writing-hero h1`).
- **Title** (700, 1.35rem, letter-spacing -0.02em): section headers, card titles (600/1.02rem).
- **Body** (400, 1rem–1.125rem, line-height 1.6–1.75): bio copy and post content. Post body is capped at `max-width: 72ch` and left-aligned (previously justified, which produced uneven rivers).
- **Label/Mono** (500, 0.7–0.85rem, JetBrains Mono): hero role marker, card-source tags, footer meta, badges, pager labels — every piece of metadata on the site now reads in mono, consistently.

### Named Rules
**The Mono-Is-Metadata Rule.** JetBrains Mono is reserved for metadata and code — dates, tags, source labels, badges. It never appears in headings or body prose. This keeps the mono accent earned (this is a genuinely technical site) rather than costume.

## 4. Elevation

Flat by default. No ambient shadows anywhere in the system; depth and interactivity are communicated entirely through a 1px border shifting from neutral to signal-orange on hover, plus (on cards) a background tint on repost list rows. This directly replaces the prior ambient-shadow + `translateY(-4px)` hover-lift pattern, which is now a Don't (see below).

### Named Rules
**The Flat-By-Default Rule.** No `box-shadow` for elevation anywhere outside the `.blog-post` container's structural 1px border (which is a border, authored as a shadow only for a legacy reason and should migrate fully to `border` over time). Cards, buttons, and badges use border-color changes, not shadows, to signal state.

## 5. Components

### Buttons
- **Shape:** 3px radius (`--radius`), sharper than the prior 8px — deliberate, precise geometry.
- **Primary (`.cta-btn`):** ink fill, white text; hovers to signal-orange fill and border. No shadow, no lift.
- **Secondary (`.cta-btn.secondary`):** surface background, 1px border-strong border; hovers to signal-orange border/text.
- **Outline (`.btn-outline`):** same shape family; hovers to signal-orange border/text.

### Cards
- **Corner Style:** 3px radius, consistent across video/post cards.
- **Background:** surface (white) on paper page background.
- **Elevation:** flat at rest; border shifts to signal-orange on hover. No shadow, no translate.
- **Border:** 1px `--border`, no default darkening — color is the only signal.
- **Badges:** flat monospace label, bordered, semantic tint per type (amber-adjacent for video, green for blog, neutral for code) — no gradient, no white-95%-opacity overlay softness.

### Repost List (new — replaces a second card grid)
- **Purpose:** deliberately secondary treatment for syndicated Medium/Towards AI articles, so they're never visually confused with original "Implementation Notes."
- **Style:** plain row list (`.repost-item`), hairline dividers, mono source label at fixed width, sans title, external-link glyph. Background tints to paper on hover; title turns signal-orange.

### Tags / Chips
- **Card tags (`.card-tag`):** paper background, ink-soft mono text, 1px border, 3px radius.
- **Post tag badges (`.tag-badge`):** outlined pill, signal-orange border/text on paper, inverts to solid signal-orange with white text on hover — no shadow, no translate.
- **Category badge (`.category-badge`):** solid ink fill, white mono text — flat, no gradient (previously a Royal-Blue→Purple gradient, now removed).

### Post Pager & Related Posts (new)
- **Post Pager (`.post-pager`):** two-column older/newer navigation at the foot of each post; bordered cards, mono label + sans title, border turns signal-orange on hover.
- **Related Posts (`.related-posts`):** same-tag notes surfaced below the pager as a compact list, mono tag label on the right of each row.

### Navigation / Header
- Homepage hero now carries an explicit mono role marker (`// Data Science Architect, NLP`) above the bio, giving a fast credibility signal before any body copy. The condensed `body.writing-page` header (used on the blog index and posts) remains visually distinct from the homepage hero — this reconciliation is deferred, not solved, in this pass.

## 6. Do's and Don'ts

### Do:
- **Do** spend signal-orange deliberately — links, hovers, one hero marker, tag accents. If it starts showing up as a background fill or a decorative wash, that's drift from the One Accent Rule.
- **Do** keep JetBrains Mono scoped to metadata and code (the Mono-Is-Metadata Rule); Archivo carries all prose and headings.
- **Do** keep the repost list visually lighter than the Implementation Notes card grid — the distinction is the point.
- **Do** keep cards and buttons flat; signal state with border-color, not shadow or transform.

### Don't:
- **Don't** reintroduce `#2563eb` royal-blue, Slate-50/white, or Inter — that system is retired, not just "not currently used."
- **Don't** bring back `translateY(-4px)` hover-lift or ambient box-shadows on cards; flat-by-default is the rule now.
- **Don't** use a `border-left` accent stripe on quotes, callouts, or preview copy (removed from `.writing-preview-copy` and `.blog-post-content blockquote` in this pass) — use background tint, a leading glyph, or nothing.
- **Don't** give a Medium/external repost the same `.card` treatment as an original post; route new external-content types through `.repost-item`, not the card grid.
- **Don't** justify body text (`text-align: justify`) — left-aligned with `text-wrap: pretty` is the standard for `.blog-post-content p`.
- **Don't** let the homepage hero and the writing-page header identities diverge further; reconciling them is flagged as the next design debt, not solved here.

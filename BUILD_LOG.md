# Build Log: pleasejusttryhtmx.com

A transcript of building the HTMX advocacy site with Claude Code.

---

## Project Brief

From `AGENTS.md`:
- Build a single-page website for https://pleasejusttryhtmx.com
- Advocate for HTMX in a pugnacious, opinionated, but factual style
- Inspired by: motherfuckingwebsite.com, justfuckingusehtml.com, bettermotherfuckingwebsite.com, justfuckingusereact.com
- The site should be "in dialog" with these reference sites

---

## Research Phase

### Reference Sites Analysis

**Common patterns identified:**
1. Aggressive, profane tone as rhetorical device
2. Direct second-person address ("you dipshit")
3. Minimal design as proof - the medium IS the message
4. Short, punchy sections with headers and bullet points
5. Hyperbolic comparisons for humor
6. Self-aware irony acknowledging exceptions
7. Structure: hook → problem → solution → proof → exceptions → call to action

**The debate these sites represent:**
- motherfuckingwebsite: "Your site doesn't need all that crap"
- bettermotherfuckingwebsite: "Ok but a LITTLE CSS is nice"
- justfuckingusehtml: "Stop using frameworks, HTML does everything"
- justfuckingusereact: "Actually complex apps NEED React"

**Our position:** The middle path - you don't need React's complexity AND you don't have to accept raw HTML's limitations. HTMX gives you interactivity without the bullshit.

### HTMX Research

**Key selling points:**
- Any HTML element can make HTTP requests
- Server returns HTML, not JSON
- ~14kb gzipped, zero dependencies
- "Locality of Behavior" - logic is in the markup

**Killer stats (Contexte case study):**
- 67% less code (21,500 → 7,200 lines)
- 96% fewer JS dependencies (255 → 9)
- 88% faster builds (40s → 5s)
- 50-60% faster page loads

---

## Implementation

### Initial Approach

Created a single HTML file with:
- Minimal, readable CSS (inspired by bettermotherfuckingwebsite)
- Working HTMX demos with mocked server responses
- Profane but measured tone - "I'm not going to call you a fucking moron every other sentence. That's been done."

### The Demo Problem

**First attempt:** Mocked XMLHttpRequest
- Didn't work - HTMX 2.x was using XHR but our mock wasn't firing

**Second attempt:** Mocked fetch()
- Didn't work - turned out HTMX 2.x actually uses XHR, not fetch

**Third attempt:** Back to XHR mock
- Still had issues

**Solution:** Upgraded to HTMX 4.0.0-alpha2
- HTMX 4 uses fetch() by default ("The Fetchening")
- Our fetch() mock worked perfectly

### Mock Server Implementation

```javascript
// Intercept fetch() for demo purposes (HTMX 4.x uses fetch)
const originalFetch = window.fetch;
window.fetch = function(input, options = {}) {
    // Handle both Request objects and string URLs
    let url, method;
    if (input instanceof Request) {
        url = input.url;
        method = input.method.toUpperCase();
    } else {
        url = String(input);
        method = (options.method || 'GET').toUpperCase();
    }

    // Match against mock responses...
};
```

Console logging kept intentionally - educational for developers who open DevTools.

---

## Deployment

### GitHub Pages Setup

1. Created repo with `gh repo create`
2. Switched remote from HTTPS to SSH: `git remote set-url origin git@github.com:algal/pleasejusttryhtmx.git`
3. Added `CNAME` file with domain
4. Enabled Pages in repo settings (Deploy from branch: main)

### DNS Configuration

```
A     @     185.199.108.153
A     @     185.199.109.153
A     @     185.199.110.153
A     @     185.199.111.153
CNAME www   algal.github.io
```

### HTTPS

GitHub Pages auto-provisions Let's Encrypt certificates for custom domains. Takes 15-30 minutes after DNS is configured.

---

## Revisions & Polish

### User Edits
- Added inline links to reference sites in opening paragraphs
- Praise for bettermotherfuckingwebsite moved to footnote
- Changed "tasteful" from bold to italic
- Various copy tweaks

### Fixes
- Title/h1 mismatch identified (intentional - different for SEO vs display)
- "motherfucking fucking" double-word typo fixed
- Added link to Contexte case study
- Added link to hypermedia.systems on "hypermedia architecture"
- Fixed `.cta code` CSS (was white-on-white)

---

## Comparison with Official HTMX Demo Approach

The official htmx.org demos use `demo.js` which:
- Uses Sinon.js for fake server
- Has routing API: `onGet('/path', handler)`
- Includes visual activity tracker

**We kept our approach because:**
1. No external dependencies (fits "no package.json" message)
2. Simpler for 3 demos vs dozens
3. Works with htmx 4's fetch()
4. Console logs serve similar purpose to activity tracker

---

## Final Tech Stack

- Single HTML file
- HTMX 4.0.0-alpha2 from unpkg CDN
- Pure CSS (no framework)
- Pure JS fetch() mock (no Sinon)
- GitHub Pages hosting
- Custom domain with Let's Encrypt HTTPS

---

## Key Learnings

1. **HTMX 2.x uses XHR, HTMX 4.x uses fetch()** - important for mocking
2. **Chrome caches aggressively** - Ctrl+Shift+R for hard refresh
3. **GitHub Pages HTTPS takes time** - certificate provisioning is automatic but not instant
4. **The genre has rules** - profanity as rhetoric, minimal design as proof, self-aware acknowledgment of exceptions
5. **`gh` CLI defaults to HTTPS** - use `git remote set-url` to switch to SSH

---

*Built with Claude Code (Opus 4.5) - December 2024*

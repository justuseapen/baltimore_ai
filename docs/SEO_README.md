# Search and AI discovery for Baltimore.ai

The September 2026 refresh prioritizes verifiable local content and accessible pages. Google's [AI optimization guide](https://developers.google.com/search/docs/fundamentals/ai-optimization-guide) (updated July 10, 2026) is the current source of guidance. The older six SEO playbook documents are historical notes, not verified rules about rankings. In particular, fixed anchor ratios, minimum word counts, claimed penalties and promised rich-result eligibility should not guide implementation.

## What the site now does

- Server-rendered content with a single page heading, useful internal links, and visible primary sources.
- Explicit geography and acquired-company labels; no inflated local-company counts from accelerator participation.
- Sources-checked dates separate from original publication and source update dates.
- Unique, concise page titles with the brand last; 60/160 character editorial budgets for titles/descriptions are presentation choices, not Google ranking requirements.
- Stable production canonical URLs, social metadata, safe JSON-LD, and Article citations matching visible source links.
- `/robots.txt` allows public crawling and excludes account, administration and claim paths.
- `/sitemap.xml` reads current published records automatically; `/sitemap.xml.gz` redirects to it. No manual generation or deploy-time sitemap file is needed. Categories with fewer than three companies remain noindex and excluded under the site's editorial policy.
- Mobile navigation wraps and wide guide tables scroll within the article.

No special AI file, hidden content or extra keyword-variant pages are required. Structured data does not guarantee rich results, indexing, search rankings or AI citations. The site's category FAQ content is for readers; it is not a promise of Google FAQ rich results.

## Refresh and verification

Run `bin/rails content:refresh` to import `db/content/catalog.json` and the guide Markdown files. Company-managed records are preserved. The operation is transactional and idempotent; unchanged records retain modification dates. Do not run stale copies of the old seed corpus.

Run `bin/rails test`, `bin/rubocop`, and `bin/brakeman --no-pager`; build Tailwind assets and inspect changed pages on desktop/mobile. The integration suite checks public content, source links, metadata, JSON-LD, publication filtering and sitemap behavior. Check source URLs and time-sensitive facts again for the next editorial release.

## Account-level follow-up

On September 8, 2026, the `https://baltimore.ai/` URL-prefix property was verified in Google Search Console using the public HTML meta tag in the application layout. Keep that tag in future deployments. Google successfully fetched `/sitemap.xml` and reported 55 discovered pages. Indexing requests for the September field report and fall events guide were accepted; this does not mean the pages are already indexed. Performance and indexing reports were still processing.

The live Settings → Search generative AI screen showed inherited default **Current control: Include**. No change was necessary. Bing Webmaster Tools remains pending an authenticated owner session. See the [campaign execution ledger](marketing/2026-09-execution.md) for completed actions and remaining measurement work. Email delivery separately requires the Resend domain and API-key setup in `RESEND_SETUP.md`.

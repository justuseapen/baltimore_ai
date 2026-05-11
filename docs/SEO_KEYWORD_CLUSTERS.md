# SEO Keyword Clusters — baltimore.ai

**Adapted from RooferRate's keyword cluster framework.** baltimore.ai is a single-metro, B2B-skewed directory of AI companies, research labs, and resources. That changes the cluster shape: there's no multi-city geo dimension to scale, and the "service" axis becomes AI vertical / capability.

## The rule

Define a primary keyword cluster (synonyms for the same intent), then layer secondary axes — affiliation, vertical, capability, intent — rotating naturally and never stuffing. **One primary keyword per page.** Body copy uses ≥3 cluster variations naturally.

## Cluster axes

### 1. Primary cluster — the head query

This is the query baltimore.ai must own. Synonyms rotate at H2 / H3 / body level.

- AI companies in Baltimore
- Baltimore AI companies
- Baltimore artificial intelligence companies
- AI startups in Baltimore
- machine learning companies Baltimore
- Baltimore AI directory
- AI companies near Baltimore

Branded variants:
- baltimore.ai
- the Baltimore AI directory

### 2. Affiliation cluster — Baltimore-specific entities

This replaces RooferRate's geo-city cluster. Affiliation modifiers carry trust and produce unique long-tail combinations Google rewards.

- Johns Hopkins AI / Hopkins AI startups
- Hopkins APL spinouts / APL AI research
- JHU AI Institute / JHU MINDS
- UMBC AI / UMBC machine learning
- bwtech AI companies / bwtech@UMBC AI
- FastForward U AI
- TEDCO AI portfolio
- Fort Meade AI / Maryland defense AI
- Baltimore-DC corridor AI

### 3. Vertical cluster — what kind of AI

Replaces RooferRate's "service type" cluster. Each company maps to one primary vertical; pages target one vertical at a time.

- healthcare AI Baltimore
- defense AI Maryland
- cybersecurity AI Baltimore
- AI consulting Baltimore
- biotech AI Baltimore
- generative AI Baltimore
- enterprise AI Baltimore
- AI infrastructure Baltimore
- robotics Baltimore
- govtech AI Baltimore
- edtech AI Baltimore

### 4. Capability / tech cluster — how the AI works

Replaces RooferRate's "material" cluster. Long-tail, lower competition, high intent.

- LLM companies Baltimore
- computer vision Baltimore
- NLP companies Baltimore
- MLOps Baltimore
- vector database Baltimore
- agentic AI Baltimore
- foundation models Baltimore
- AI inference / model serving Baltimore
- RAG vendors Baltimore

### 5. Intent cluster — buyer / job-seeker / founder queries

This is where buyers, recruits, and founders enter the funnel.

- AI consultants Baltimore
- hire an AI engineer Baltimore
- Baltimore AI jobs
- AI internships Baltimore
- Baltimore AI accelerator
- AI grant Maryland
- pitch competition AI Baltimore
- AI hackathon Baltimore

### 6. Content cluster — guide / explainer queries

Editorial pages (`/guides/*`) target these. Always include the year on guide titles.

- best AI companies Baltimore 2026
- top healthcare AI companies Baltimore
- how to choose an AI consultant Baltimore
- AI salary Baltimore
- where to learn AI Baltimore
- Baltimore AI ecosystem report

## Mapping clusters → page types

| Page type | Primary cluster slot | Secondary mix |
|---|---|---|
| Homepage `/` | "Baltimore AI companies & labs directory" | affiliation, vertical |
| Category `/categories/healthcare_ai` | "healthcare AI Baltimore" | affiliation, capability |
| Company `/companies/[slug]` | "[Company] — Baltimore [vertical] company" | affiliation, capability |
| Resource `/resources/[slug]` | "[Resource]" | affiliation, intent |
| Guide `/guides/[slug]` | content cluster phrase (with year) | primary, vertical |

## Dos and don'ts

**Do:**
- Use ≥3 cluster variations per page, distributed across title / H1 / H2 / body.
- One primary keyword per page. If a page is trying to rank for two head queries, split it.
- Rotate synonyms aggressively. "AI company" → "AI startup" → "machine learning firm" → "artificial intelligence company".
- Cross-link guide pages to ≥2 directory entries (company or resource) with descriptive anchor text.
- Front-load the primary keyword in title and H1.

**Don't:**
- Don't repeat the exact same phrase 6 times on one page. That's stuffing.
- Don't combine two head queries in one title ("Baltimore AI companies and healthcare AI" — pick one).
- Don't target a vertical that has fewer than 3 entities (noindex the page, see SEO_TRUST_AND_POLISH).
- Don't use vague filler ("technology company", "innovative AI") — Google's classifier flags it.

## Quantitative thresholds

| Rule | Threshold |
|---|---|
| Cluster variations per page (in body) | ≥3 |
| Primary keyword mentions in body | 3–5 |
| Internal links from guide → directory pages | ≥2 |
| Pages per facet to publish (else noindex) | ≥3 entities |

## RooferRate parallels (for reference)

- The geo-city dimension in RooferRate's docs (`roofers in [city]`) **does not apply** here — baltimore.ai is single-metro.
- RooferRate's "material cluster" (asphalt, metal, slate) → "capability cluster" (LLM, computer vision, NLP) on baltimore.ai.
- RooferRate's "service cluster" (repair, replacement, inspection) → "vertical cluster" (healthcare AI, cybersecurity AI, etc.).
- RooferRate's trust modifiers ("licensed", "insured") → affiliation modifiers ("Hopkins-affiliated", "APL spinout", "Y Combinator-backed").

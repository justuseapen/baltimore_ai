# Editorial guides for baltimore.ai. Hand-written, opinionated, intentionally
# avoiding generic SEO mush. Each guide is the "top X" content the plan calls for —
# they outrank pure facet pages for head queries.
#
# Loaded from db/seeds.rb. Idempotent.

GUIDES = [
  {
    slug: "ai-companies-baltimore-2026",
    title: "AI companies in Baltimore: a 2026 field guide",
    intro: "There isn't a single 'Baltimore AI scene' — there are at least three, and they barely talk to each other.",
    meta_title: "AI companies in Baltimore (2026)",
    meta_description: "An opinionated field guide to the AI companies, sub-clusters, and quiet patterns shaping AI in Baltimore in 2026.",
    body: <<~MD
      Most lists of "AI companies in Baltimore" make the same mistake: they collapse three very different kinds of company into one alphabetized blob. The applied-AI startups in Hampden don't talk to the Hopkins APL spinouts in Laurel, and neither of them talks to the cybersecurity-AI cluster around Ellicott City and Columbia. So before the list, the map.

      ## The three Baltimore AI scenes

      **Healthcare and life-sciences AI** is the densest cluster, and it's almost entirely a Hopkins phenomenon. [Personal Genome Diagnostics](/companies/personal-genome-diagnostics) (now Labcorp), [Haystack Oncology](/companies/haystack-oncology) (acquired by Quest), [Protenus](/companies/protenus), [Sonavex](/companies/sonavex), [Emocha Health](/companies/emocha-health) — these are companies whose founding teams overlap, whose papers cite each other, and whose existence is downstream of decades of NIH and Johns Hopkins funding. If you walk into any of them, you'll find the same dozen people on each other's advisory boards.

      **Cybersecurity AI** is the loudest and most commercial cluster. [Tenable](/companies/tenable), [ZeroFox](/companies/zerofox), [Huntress](/companies/huntress), [Blackpoint Cyber](/companies/blackpoint-cyber), [QOMPLX](/companies/qomplx), [CyberPoint International](/companies/cyberpoint) — most of these are not headquartered in Baltimore proper but in the suburbs along the I-95 / NSA corridor. They share an unusual hiring pool: former NSA, former military, and Hopkins APL alumni. AI in this cluster is mostly ML for anomaly detection and triage, not LLMs for chat.

      **Generalist applied AI and consulting** is the smallest but most visible cluster. [RedShred](/companies/redshred), [Mindgrub](/companies/mindgrub), [Fearless](/companies/fearless), [Huntr](/companies/huntr) — these are the companies that run the city's AI conversation on social media and show up at the occasional ad-hoc tech event. They're the ones building LLM-powered features for clients and shipping consumer-ish products. If you're new to Baltimore tech, this is the cluster you'll meet first; it's also the one that gets most of the press coverage despite being the smallest by headcount.

      ## What's missing

      A few categories Baltimore conspicuously lacks compared to peer cities:

      - **No serious AI infrastructure company.** No Modal, no Anyscale, no Pinecone analogue. The closest is some of [Tenable](/companies/tenable)'s internal ML platform work, but nothing customer-facing.
      - **Limited consumer AI.** [Huntr](/companies/huntr) is the rare counterexample. Most Baltimore AI is B2B or B2G.
      - **Weak open-source presence.** Despite the research density, very little of it ends up on GitHub at the company level.

      ## Why this matters for hiring

      If you're moving here for AI work, the cluster you join shapes what your career looks like more than the company name does. Healthcare AI means slow regulatory cycles, deep specialization, and acquisitions to incumbents (PGDx → Labcorp, Haystack → Quest). Cybersecurity AI means faster commercial cycles, security-cleared work, and IPO-or-PE outcomes (ZeroFox, Tenable). Applied AI consulting means project variety and lower equity ceiling.

      ## What to read next

      - [Healthcare AI in Baltimore: the Hopkins effect](/guides/healthcare-ai-baltimore-hopkins) — the dense interconnections in the medical cluster.
      - [Cybersecurity AI in the Baltimore-DC corridor](/guides/cybersecurity-ai-baltimore-dc-corridor) — why the I-95 cluster is what it is.
      - [Where to learn AI in Baltimore](/guides/where-to-learn-ai-baltimore) — universities, programs, and the free options.

      ---

      *Last updated May 2026. Found something missing or wrong? [Claim your listing](/companies) or get in touch.*
    MD
  },
  {
    slug: "healthcare-ai-baltimore-hopkins",
    title: "Healthcare AI in Baltimore: the Hopkins effect",
    intro: "The healthcare-AI cluster in Baltimore is one of the densest in the country — and it's almost entirely downstream of Johns Hopkins.",
    meta_title: "Healthcare AI companies in Baltimore",
    meta_description: "How Johns Hopkins shaped Baltimore's healthcare and life-sciences AI cluster — the companies, the spinouts, and the patterns.",
    body: <<~MD
      You can almost draw a line on a map. Start at the East Baltimore campus of Johns Hopkins. Trace south to [Personal Genome Diagnostics](/companies/personal-genome-diagnostics) (founded by Hopkins researchers, acquired by Labcorp). North to [Sonavex](/companies/sonavex) (a Hopkins spinout building AI ultrasound). East to [Protenus](/companies/protenus) (founded by Hopkins MD-PhDs). The same dozen advisors, board members, and post-doc cohort show up on every cap table.

      This is unusual. Most "healthcare AI hubs" — Boston, the Bay Area, San Diego — have multiple research feeders. Baltimore essentially has one, plus University of Maryland Medical Center as a distant second. That concentration has trade-offs.

      ## What the Hopkins effect looks like

      **Founding teams skew clinician-engineer.** A typical Baltimore healthcare-AI company has at least one MD-PhD on the founding team — often a Hopkins faculty member with a part-time appointment. This is different from Bay Area healthcare AI, which is more often pure-engineering teams partnering with health systems.

      **Acquisition is the dominant exit.** [Haystack Oncology](/companies/haystack-oncology) → Quest Diagnostics (2023). [Personal Genome Diagnostics](/companies/personal-genome-diagnostics) → Labcorp (2022, eventually). [Sonavex](/companies/sonavex) is widely expected to go the same way. There aren't many IPOs from this cluster — partly the regulatory cycle, partly the reality that diagnostics and devices fit cleanly inside large incumbents.

      **Research-to-startup latency is short.** A pattern that recurs: a Hopkins lab publishes a paper showing an ML method outperforms standard-of-care on some clinical decision. Within 18 months, there's a startup. [Sonavex](/companies/sonavex) followed this pattern. [Haystack](/companies/haystack-oncology) followed this pattern. It's a great pipeline; it also means the cluster is unusually exposed to NIH funding cycles.

      ## The Hopkins ecosystem support

      Three institutions matter most for new healthcare-AI founders here:

      - **[Johns Hopkins Technology Ventures](https://ventures.jhu.edu)** — the licensing arm, the [FastForward U](/resources/fastforward-u) accelerator, and an active venture capital fund.
      - **[JHU MINDS](/resources/jhu-mathematical-institute-data-science)** — the cross-school AI/ML research institute. Most of the foundational ML work that becomes startups comes through MINDS-affiliated labs.
      - **[JHU Data Science and AI Institute (DSAI)](/resources/jhu-data-science-and-ai-institute)** — the new (2024) university-wide AI institute. Too soon to tell what it produces, but the early bets are aggressive.

      Outside Hopkins, [TEDCO](/resources/tedco) is the most active early-stage capital source — it's done dozens of small checks into Maryland life-sciences and AI startups, and it's much friendlier to non-traditional founders than the Hopkins channel.

      ## What's underserved

      A few patterns the Baltimore healthcare-AI cluster is bad at:

      - **Consumer-facing health AI.** Almost everything here is B2B sold into health systems and pharma. Direct-to-patient products are rare.
      - **Mental health AI.** Despite Hopkins's psychiatry strength, there's no real Baltimore startup analogue to [Spring Health](https://www.springhealth.com) or [Lyra](https://www.lyrahealth.com).
      - **AI in administrative health workflows.** Prior auth, RCM, scheduling — these are huge markets and Baltimore is barely participating. This is a gap, not a feature.

      ## What to read next

      - [AI companies in Baltimore: a 2026 field guide](/guides/ai-companies-baltimore-2026) — the broader map.
      - [Hopkins APL: spinouts and the unsung half of Baltimore AI](/guides/hopkins-apl-spinouts) — the other Hopkins.

      ---

      *Last updated May 2026.*
    MD
  },
  {
    slug: "cybersecurity-ai-baltimore-dc-corridor",
    title: "Cybersecurity AI in the Baltimore-DC corridor",
    intro: "The strip of I-95 between Baltimore and DC is one of the densest cybersecurity-AI clusters on Earth. Most people outside the industry don't know it exists.",
    meta_title: "Cybersecurity AI companies in Baltimore",
    meta_description: "A guide to the cybersecurity-AI cluster between Baltimore and DC — the companies, the talent flows, and the unusual constraints.",
    body: <<~MD
      Drive south on I-95 from Baltimore. In about thirty minutes you'll pass within a few miles of: NSA headquarters at Fort Meade, Johns Hopkins APL in Laurel, the offices of [Tenable](/companies/tenable), [ZeroFox](/companies/zerofox), [Huntress](/companies/huntress), [Blackpoint Cyber](/companies/blackpoint-cyber), [QOMPLX](/companies/qomplx), and [CyberPoint International](/companies/cyberpoint). It's one of the most concentrated cybersecurity-AI clusters anywhere — and it's invisible from outside the industry because almost all of these companies sell to enterprises, governments, and other security companies.

      ## Why this cluster exists where it does

      The honest answer: NSA. Fort Meade has been pumping out cybersecurity talent for fifty years, and after the [Snowden disclosures](https://en.wikipedia.org/wiki/Edward_Snowden) accelerated NSA-to-private-sector flow, that talent largely stayed in Maryland. [Blackpoint Cyber](/companies/blackpoint-cyber) was founded by former NSA staff. So were many of the technical leads at [Tenable](/companies/tenable), [ZeroFox](/companies/zerofox), and [CyberPoint](/companies/cyberpoint). Hopkins APL contributes a separate but adjacent talent stream.

      Add the federal customer base — DC is right there — and you have the conditions for a self-sustaining cluster.

      ## What "cybersecurity AI" means here

      It is mostly *not* what consumer AI press covers. There are very few LLM products in this cluster. What you'll find instead:

      - **Anomaly detection on telemetry.** Endpoint, network, identity, cloud — the volumes are so large that ML triage is the only way to make human analysts effective. [Huntress](/companies/huntress) and [Tenable](/companies/tenable) are the canonical examples.
      - **Graph-based threat modeling.** [QOMPLX](/companies/qomplx) leans heavily into graph analytics over enterprise telemetry to score risk.
      - **NLP on threat intelligence.** [ZeroFox](/companies/zerofox) is the loudest example — public web and dark web monitoring with NLP at the core.
      - **Adversarial ML research.** Less commercialized, mostly inside [Hopkins APL](/resources/johns-hopkins-apl), [CyberPoint](/companies/cyberpoint), and federal labs.

      ## The hiring market is unusual

      Several things to know if you're considering joining this cluster:

      1. **Many roles require security clearances.** This narrows the candidate pool dramatically and pushes salaries up. If you don't have a clearance, [Huntress](/companies/huntress) and [Tenable](/companies/tenable)'s commercial sides are your most accessible entry points.
      2. **Career mobility within the cluster is high.** People rotate between [ZeroFox](/companies/zerofox), [Tenable](/companies/tenable), [Blackpoint](/companies/blackpoint-cyber), and APL like it's one company. If you join one, you've effectively joined all of them.
      3. **The product engineering culture is conservative.** These companies sell to security-conscious customers. Trunk-based development with feature flags and continuous deployment is rare. Releases are scheduled, regression-tested, and signed off.

      ## What's not happening here (yet)

      A few categories the cluster is underweight in:

      - **AI-for-AI-security.** As LLM applications proliferate, the security stack for them — prompt injection defense, model supply chain, agent sandboxing — is mostly being built in the Bay Area. The Baltimore-DC cluster has the talent for this and isn't moving fast enough.
      - **Consumer-facing security AI.** Apart from password managers and a few SMB-targeted MDR products, the cluster doesn't really do consumer.

      ## What to read next

      - [AI companies in Baltimore: a 2026 field guide](/guides/ai-companies-baltimore-2026)
      - [Hopkins APL: spinouts and the unsung half of Baltimore AI](/guides/hopkins-apl-spinouts)

      ---

      *Last updated May 2026.*
    MD
  },
  {
    slug: "hopkins-apl-spinouts",
    title: "Hopkins APL: spinouts and the unsung half of Baltimore AI",
    intro: "Johns Hopkins Applied Physics Laboratory is one of the largest applied-AI research labs in the world. Most Baltimoreans don't think of it when they think of Baltimore AI.",
    meta_title: "Johns Hopkins APL: AI research and spinouts",
    meta_description: "Johns Hopkins APL employs thousands of AI researchers in Laurel, MD. Here's how it shapes Baltimore's broader AI ecosystem and what it spins out.",
    body: <<~MD
      Mention Baltimore AI and most people think of [Hopkins's medical campus](/guides/healthcare-ai-baltimore-hopkins). They should also be thinking about Laurel.

      [Johns Hopkins Applied Physics Laboratory](/resources/johns-hopkins-apl) — APL — is a federally funded research and development center about a thirty-minute drive south of Baltimore proper. It employs over 8,000 people, a meaningful fraction of whom work on AI: foundation models for science, multi-agent autonomy, computer vision for defense, ML systems research, trustworthy AI. By any reasonable count it's one of the largest applied-AI organizations in the world. And it's quietly the source of a substantial share of the people who now staff Baltimore's commercial AI cluster.

      ## What APL actually works on

      APL's portfolio is broad enough that any summary is approximate, but the AI-relevant pieces include:

      - **Autonomous systems** for naval, air, and space platforms. Multi-agent coordination, planning under uncertainty, sim-to-real transfer.
      - **AI for science.** Materials discovery, climate modeling, biomedical foundation models — APL has a growing presence here, often in partnership with the broader Hopkins research enterprise.
      - **Trustworthy ML.** Adversarial robustness, model verification, formal methods. APL ships products that need to meet defense-grade reliability bars, which forces a different relationship with ML than most commercial teams have.
      - **National security AI.** A large portfolio you can't read about in detail.

      The unifying theme: APL works on AI under constraints most commercial teams don't face — adversarial inputs, hardware-in-the-loop, lives on the line. That changes how the engineers there think.

      ## The diaspora

      APL alumni are everywhere in the Baltimore-DC cluster. You'll find them at [CyberPoint](/companies/cyberpoint), [QOMPLX](/companies/qomplx), [Blackpoint Cyber](/companies/blackpoint-cyber), and at most of the cybersecurity-AI companies in the [I-95 corridor](/guides/cybersecurity-ai-baltimore-dc-corridor). They tend to share a few traits: high comfort with adversarial threat models, lower tolerance for "ship it and iterate," strong systems-engineering instincts.

      Direct APL spinouts are rarer — APL's IP arrangements with the federal government make spinning out harder than at a typical university lab — but the talent flow is the dominant channel of impact on the commercial scene.

      ## How to engage with APL if you're outside it

      A few entry points:

      - **APL public talks and seminars.** Many AI seminars are open to outside attendees. The schedule is patchy; keep an eye on [APL's events page](https://www.jhuapl.edu).
      - **Postdoc and rotation programs.** APL has several pipelines for early-career researchers, including joint appointments with Hopkins's main campus.
      - **SBIR partnerships.** If you have a startup with a federal angle, APL's industry-engagement teams are unusually willing to talk.

      ## What it means for the rest of Baltimore AI

      The APL effect on the commercial cluster is mostly invisible from outside. It shows up as: a deeper bench of ML engineers with security clearances, a higher floor on technical rigor in cybersecurity-AI, and an unusual concentration of "applied AI" expertise — meaning AI that has to work in the real world under hostile conditions, not just produce a demo.

      ## What to read next

      - [Cybersecurity AI in the Baltimore-DC corridor](/guides/cybersecurity-ai-baltimore-dc-corridor) — where most APL alumni land.
      - [Where to learn AI in Baltimore](/guides/where-to-learn-ai-baltimore).

      ---

      *Last updated May 2026.*
    MD
  },
  {
    slug: "where-to-learn-ai-baltimore",
    title: "Where to learn AI in Baltimore",
    intro: "Universities, programs, and the free option — a practical guide to picking up AI skills in the Baltimore metro.",
    meta_title: "Where to learn AI in Baltimore (universities & programs)",
    meta_description: "An honest guide to learning AI in Baltimore — universities, accelerators, and how to start without spending a dollar.",
    body: <<~MD
      The honest version of this guide is: you can learn AI from anywhere, and the most credentialed paths in Baltimore are also the most expensive. That said, there are real reasons to learn here specifically — proximity to the people doing the work, access to research seminars, and a meaningful local job market that's hungry for talent.

      Here's how to think about your options.

      ## If you want a degree

      **[Johns Hopkins University](/resources/jhu-data-science-and-ai-institute)** is the obvious choice and the most expensive. Hopkins's CS department has multiple AI/ML faculty who are world-class; the [MINDS institute](/resources/jhu-mathematical-institute-data-science) coordinates AI research across schools; the new [DSAI institute](/resources/jhu-data-science-and-ai-institute) (2024) is the most aggressive bet on AI Hopkins has ever made. Programs to look at: the MS in Computer Science with an ML focus, the MS in Artificial Intelligence (Engineering for Professionals, online and part-time), and the Whiting School PhD if you're going the research route.

      **[University of Maryland, Baltimore County (UMBC)](/resources/umbc-ai-cybersecurity-collaboratory)** has a strong CS department with active AI research groups, especially in NLP, knowledge graphs, and ML systems. UMBC tuition is meaningfully lower than Hopkins's, the program is rigorous, and the campus sits adjacent to the [bwtech research park](/resources/bwtech-umbc) so industry exposure is built in. For most people learning AI in Baltimore, UMBC is the better value.

      **University of Maryland, College Park** is technically not Baltimore, but it's close enough that you can commute and it has one of the strongest AI/ML programs on the East Coast. If you're degree-shopping, don't ignore it.

      ## If you don't want a degree

      A few options that work:

      - **[FastForward U](/resources/fastforward-u)**, JHU's startup accelerator, runs programming aimed at student and alumni founders, but it also produces a lot of learnable content. Many of their workshops are open to non-students.
      - **APL public seminars.** [Hopkins APL](/resources/johns-hopkins-apl) runs public AI seminars throughout the year. The talks are technical but accessible, and you'll meet people you can't easily meet otherwise.
      - **TEDCO programs.** [TEDCO](/resources/tedco) runs regular events for Maryland tech founders, several of which include AI-specific programming.

      ## The free path

      You don't need any of the above to get good. The same free resources that have built a generation of AI engineers — [Karpathy's Zero-to-Hero](https://karpathy.ai), [fast.ai](https://www.fast.ai), [3Blue1Brown's neural network series](https://www.3blue1brown.com), the [original Transformer paper](https://arxiv.org/abs/1706.03762), and a steady diet of arxiv-sanity — work just as well from a Baltimore apartment as anywhere else. What being in Baltimore adds is access to a real job market and proximity to Hopkins APL / UMBC / JHU seminars — *not* a thriving public practitioner community, which the city currently lacks.

      A reasonable self-taught track for someone in Baltimore today:

      1. Three months of fundamentals (linear algebra refresher, Python, fast.ai, Karpathy's nn-zero-to-hero series).
      2. Pick a project. Ship it. Post it publicly — GitHub, Twitter, a blog. Local meetups have been thin lately, so visibility comes from online communities first.
      3. Apply to entry-level ML roles at the [companies in our directory](/companies). Many of them prefer self-taught engineers with portfolio over fresh CS grads with no project.

      ## What you can't easily get here

      Baltimore is weak on a few things:

      - **Pure ML research community at scale.** Hopkins and APL are excellent, but the conversation density is lower than Boston or the Bay Area. If you want to be deeply embedded in research, plan for travel.
      - **Generative-AI / LLM specialization.** The local cluster skews ML-on-data, not LLM-application. LLM-specific community is essentially all online; Baltimore doesn't currently have a local LLM scene worth seeking out.

      ## What to read next

      - [AI companies in Baltimore: a 2026 field guide](/guides/ai-companies-baltimore-2026) — what jobs you're aiming at.
      - [Healthcare AI in Baltimore: the Hopkins effect](/guides/healthcare-ai-baltimore-hopkins).

      ---

      *Last updated May 2026.*
    MD
  }
].freeze

GUIDES.each do |attrs|
  guide = Guide.find_or_initialize_by(slug: attrs[:slug])
  guide.assign_attributes(attrs.merge(status: "published"))
  guide.published_at ||= Time.current
  guide.save!
end

puts "  -> #{Guide.count} guides (#{Guide.published.count} published)"

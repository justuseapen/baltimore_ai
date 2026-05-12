# Idempotent seed for baltimore.ai directory.
#
# Companies and resources are real Baltimore-area AI/AI-adjacent organizations.
# Editorial blurbs are unique per entry to satisfy Google's thin-content threshold.
# Run with: bin/rails db:seed

puts "Seeding admin user..."

if (admin_email = ENV["ADMIN_EMAIL"]).present?
  admin = User.find_or_initialize_by(email: admin_email)
  admin.role = "admin"
  admin.save!
  puts "  -> admin user: #{admin.email}"
end

puts "Seeding tags..."

TAGS = {
  "machine-learning" => "Machine Learning",
  "computer-vision" => "Computer Vision",
  "natural-language-processing" => "Natural Language Processing",
  "llm" => "LLMs",
  "robotics" => "Robotics",
  "healthcare-ai" => "Healthcare AI",
  "biotech-ai" => "Biotech AI",
  "defense-ai" => "Defense & National Security",
  "ai-infrastructure" => "AI Infrastructure",
  "ai-consulting" => "AI Consulting",
  "edtech-ai" => "EdTech AI",
  "fintech-ai" => "FinTech AI",
  "drug-discovery" => "Drug Discovery",
  "genomics" => "Genomics",
  "cybersecurity-ai" => "Cybersecurity AI",
  "data-platform" => "Data Platform",
  "search" => "Search & Retrieval",
  "creative-ai" => "Creative AI"
}.freeze

TAGS.each do |slug, name|
  Tag.find_or_create_by!(slug: slug) { |t| t.name = name }
end

puts "  -> #{Tag.count} tags"

puts "Seeding companies..."

COMPANIES = [
  {
    slug: "redshred",
    name: "RedShred",
    tagline: "AI-powered document intelligence platform.",
    description: "RedShred extracts structured data from complex documents — RFPs, contracts, technical proposals — using ML pipelines tuned for the kinds of dense unstructured text that defeat off-the-shelf parsers. Founded in Baltimore in 2014, the company spun out of work on government acquisition workflows and now serves enterprise customers across defense, healthcare, and financial services.",
    website: "https://redshred.com",
    primary_category: "applied_ai",
    founded_year: 2014,
    employee_count_bucket: "11-50",
    tags: %w[natural-language-processing data-platform defense-ai],
    status: "published"
  },
  {
    slug: "mindgrub",
    name: "Mindgrub",
    tagline: "Digital agency with a sizable AI/ML practice.",
    description: "Mindgrub is one of Baltimore's largest digital agencies, with an in-house AI and machine learning practice that builds custom models for clients across logistics, government, and consumer verticals. Founded by Todd Marks in 2002, the firm has been a fixture of the Baltimore tech scene and an early adopter of generative AI in enterprise consulting.",
    website: "https://mindgrub.com",
    primary_category: "consulting",
    founded_year: 2002,
    employee_count_bucket: "51-200",
    tags: %w[ai-consulting machine-learning],
    status: "published"
  },
  {
    slug: "fearless",
    name: "Fearless",
    tagline: "Software studio with an AI center of excellence.",
    description: "Fearless is a Baltimore-headquartered B Corp that builds custom software for federal agencies and mission-driven organizations. Their AI work spans NLP for benefits eligibility, computer vision for inspections, and ML platforms for civic-tech datasets. The firm has scaled to several hundred staff while remaining a vocal advocate for ethical AI in government.",
    website: "https://fearless.tech",
    primary_category: "consulting",
    founded_year: 2009,
    employee_count_bucket: "201-500",
    tags: %w[ai-consulting machine-learning natural-language-processing],
    status: "published"
  },
  {
    slug: "haystack-oncology",
    name: "Haystack Oncology",
    tagline: "AI-driven cancer recurrence detection.",
    description: "Haystack Oncology develops ultrasensitive blood tests powered by ML models that detect minimal residual disease in cancer patients post-treatment. The Baltimore-founded company was acquired by Quest Diagnostics in 2023 and continues to build out its analytical pipeline from offices in Maryland.",
    website: "https://haystackoncology.com",
    primary_category: "healthcare_ai",
    founded_year: 2021,
    employee_count_bucket: "51-200",
    tags: %w[healthcare-ai biotech-ai genomics machine-learning],
    status: "published"
  },
  {
    slug: "personal-genome-diagnostics",
    name: "Personal Genome Diagnostics",
    tagline: "Genomic analysis platform for precision oncology.",
    description: "PGDx, founded by Johns Hopkins researchers Luis Diaz and Victor Velculescu, builds genomic analysis pipelines that turn tumor sequencing into clinically actionable reports. Now part of Labcorp, the Baltimore company's ML-driven variant-calling and signature analysis remain a core part of its precision oncology stack.",
    website: "https://personalgenome.com",
    primary_category: "healthcare_ai",
    founded_year: 2010,
    employee_count_bucket: "201-500",
    tags: %w[healthcare-ai genomics drug-discovery],
    status: "published"
  },
  {
    slug: "emocha-health",
    name: "Emocha Health",
    tagline: "Computer-vision-assisted medication adherence.",
    description: "Emocha (an early Hopkins Tech Ventures spinout) uses computer vision and asynchronous video review to verify that patients take their medications correctly. The Baltimore-based company has extended its platform with ML models that flag adherence risk and route caseworker attention to the highest-impact patients.",
    website: "https://emocha.com",
    primary_category: "healthcare_ai",
    founded_year: 2014,
    employee_count_bucket: "51-200",
    tags: %w[healthcare-ai computer-vision],
    status: "published"
  },
  {
    slug: "clearmask",
    name: "ClearMask",
    tagline: "Transparent medical PPE with smart manufacturing AI.",
    description: "ClearMask, started by Hopkins students, designs the world's first FDA-cleared fully transparent surgical mask. Their Baltimore manufacturing and QA stack includes computer-vision inspection that catches defects faster than human reviewers — an AI application unusual for a hardware-first company.",
    website: "https://theclearmask.com",
    primary_category: "applied_ai",
    founded_year: 2017,
    employee_count_bucket: "11-50",
    tags: %w[computer-vision healthcare-ai],
    status: "published"
  },
  {
    slug: "protenus",
    name: "Protenus",
    tagline: "AI for healthcare compliance and drug diversion detection.",
    description: "Protenus builds ML models that detect inappropriate access to electronic health records and pharmacy diversion across hospital systems. Spun out of Johns Hopkins, the Baltimore company processes billions of EHR access events per year and is one of the longest-tenured healthcare-AI companies in the city.",
    website: "https://protenus.com",
    primary_category: "healthcare_ai",
    founded_year: 2014,
    employee_count_bucket: "51-200",
    tags: %w[healthcare-ai cybersecurity-ai machine-learning],
    status: "published"
  },
  {
    slug: "expii",
    name: "Expii",
    tagline: "Adaptive math learning platform.",
    description: "Expii, founded by Carnegie Mellon mathematician and Baltimore native Po-Shen Loh, builds an adaptive learning system that personalizes math instruction by inferring a learner's conceptual gaps from their problem-solving traces. The platform has been used by hundreds of thousands of students and uses ML to route content selection.",
    website: "https://www.expii.com",
    primary_category: "edtech",
    founded_year: 2014,
    employee_count_bucket: "11-50",
    tags: %w[edtech-ai machine-learning],
    status: "published"
  },
  {
    slug: "huntr",
    name: "Huntr",
    tagline: "AI-assisted job application tracker and resume tailoring.",
    description: "Huntr is a Baltimore-area startup whose product layers LLM-driven resume tailoring and cover-letter generation on top of a job-application tracking workflow. The company has grown a meaningful consumer audience among job seekers using AI to apply at scale.",
    website: "https://huntr.co",
    primary_category: "applied_ai",
    founded_year: 2017,
    employee_count_bucket: "11-50",
    tags: %w[llm natural-language-processing],
    status: "published"
  },
  {
    slug: "tenable",
    name: "Tenable",
    tagline: "Cybersecurity platform with ML-driven exposure management.",
    description: "Tenable, headquartered in Columbia, MD, has incorporated machine learning across its vulnerability and exposure management platform — from prioritization scoring to anomaly detection. The company is a publicly traded fixture of the Baltimore-Washington cybersecurity corridor.",
    website: "https://www.tenable.com",
    primary_category: "applied_ai",
    founded_year: 2002,
    employee_count_bucket: "1000+",
    tags: %w[cybersecurity-ai machine-learning],
    status: "published"
  },
  {
    slug: "zerofox",
    name: "ZeroFox",
    tagline: "External cybersecurity AI for brand and executive protection.",
    description: "ZeroFox uses ML and NLP to monitor public and dark-web sources for threats targeting brands, executives, and digital assets. The Baltimore-founded company went public in 2022 and is a major employer in the local AI-security cluster.",
    website: "https://www.zerofox.com",
    primary_category: "applied_ai",
    founded_year: 2013,
    employee_count_bucket: "501-1000",
    tags: %w[cybersecurity-ai natural-language-processing],
    status: "published"
  },
  {
    slug: "huntress",
    name: "Huntress",
    tagline: "Managed detection and response with ML-driven threat hunting.",
    description: "Huntress, headquartered in Ellicott City, builds a managed detection and response platform for SMB-focused MSPs. ML models help triage and surface real threats from massive endpoint telemetry; the company has been one of the fastest-growing in the regional cybersecurity scene.",
    website: "https://www.huntress.com",
    primary_category: "applied_ai",
    founded_year: 2015,
    employee_count_bucket: "501-1000",
    tags: %w[cybersecurity-ai machine-learning],
    status: "published"
  },
  {
    slug: "blackpoint-cyber",
    name: "Blackpoint Cyber",
    tagline: "Real-time threat detection from former NSA operators.",
    description: "Blackpoint Cyber, based in Ellicott City, was founded by former NSA personnel and builds an MDR platform with ML-assisted lateral-movement detection. Their hunt operations team and ML pipeline are tightly co-developed — a pattern common to defense-adjacent Baltimore-area firms.",
    website: "https://blackpointcyber.com",
    primary_category: "applied_ai",
    founded_year: 2014,
    employee_count_bucket: "201-500",
    tags: %w[cybersecurity-ai defense-ai],
    status: "published"
  },
  # TODO(curator): Stride.ai's Baltimore presence is unverified. Hidden until confirmed
  # or replaced. See pre-launch notes.
  {
    slug: "stride-pharma",
    name: "Stride.ai",
    tagline: "Cognitive automation for life sciences and finance.",
    description: "Stride.ai builds NLP and document-understanding products for life sciences and financial services with engineering presence in the Baltimore/DC corridor. Their core stack focuses on extracting structure from heavily templated regulated documents — an area where domain-tuned models materially outperform general LLMs.",
    website: "https://stride.ai",
    primary_category: "applied_ai",
    founded_year: 2017,
    employee_count_bucket: "51-200",
    tags: %w[natural-language-processing healthcare-ai fintech-ai],
    status: "hidden"
  },
  {
    slug: "remesh",
    name: "Remesh",
    tagline: "Live AI conversation for large-scale audience research.",
    description: "Remesh's platform uses NLP to cluster and surface the most representative responses from thousands of simultaneous participants in a live conversation. With operations spanning New York and the Baltimore-DC corridor, the company is widely used by researchers, brands, and political organizations.",
    website: "https://www.remesh.ai",
    primary_category: "applied_ai",
    founded_year: 2014,
    employee_count_bucket: "51-200",
    tags: %w[natural-language-processing machine-learning],
    status: "published"
  },
  {
    slug: "cyberpoint",
    name: "CyberPoint International",
    tagline: "Cybersecurity AI for federal and commercial customers.",
    description: "CyberPoint, headquartered in Baltimore, builds AI-driven cybersecurity products and services for the U.S. government and Fortune 500 customers. Their work spans threat intelligence, secure ML, and adversarial robustness research that draws on the local pool of NSA and APL talent.",
    website: "https://www.cyberpointllc.com",
    primary_category: "applied_ai",
    founded_year: 2009,
    employee_count_bucket: "51-200",
    tags: %w[cybersecurity-ai defense-ai],
    status: "published"
  },
  {
    slug: "leidos-baltimore",
    name: "Leidos (Baltimore office)",
    tagline: "Federal IT and AI integrator with major Baltimore-area presence.",
    description: "Leidos's Baltimore-area offices contribute to the company's substantial AI and ML portfolio across health, defense, and intelligence. While the parent is headquartered in Reston, Maryland operations are a core node of its ML engineering footprint and a major regional employer.",
    website: "https://www.leidos.com",
    primary_category: "consulting",
    founded_year: 1969,
    employee_count_bucket: "1000+",
    tags: %w[ai-consulting defense-ai healthcare-ai],
    status: "published"
  },
  {
    slug: "next-tier-concepts",
    name: "Next Tier Concepts (NT Concepts)",
    tagline: "Mission-focused AI/ML for the intelligence community.",
    description: "NT Concepts builds AI and data-engineering systems for U.S. intelligence and defense customers. With significant operations in the Baltimore-DC corridor, the firm specializes in production ML on classified data — a niche that puts it adjacent to but distinct from commercial AI-startup peers.",
    website: "https://www.ntconcepts.com",
    primary_category: "consulting",
    founded_year: 1998,
    employee_count_bucket: "501-1000",
    tags: %w[defense-ai ai-consulting machine-learning],
    status: "published"
  },
  {
    slug: "axle-informatics",
    name: "Axle Informatics",
    tagline: "Bioinformatics and AI for biomedical research.",
    description: "Axle Informatics, headquartered in Rockville with significant Baltimore-area collaboration via NIH and Hopkins, applies ML to biomedical imaging, genomics, and clinical data. Their work straddles federal research labs and translational medicine projects.",
    website: "https://www.axleinfo.com",
    primary_category: "research",
    founded_year: 2002,
    employee_count_bucket: "501-1000",
    tags: %w[healthcare-ai genomics computer-vision],
    status: "published"
  },
  {
    slug: "anchor-health",
    name: "Anchor Health Innovation",
    tagline: "AI care navigation for Medicaid populations.",
    description: "Anchor Health Innovation is a Baltimore-based startup using ML to route Medicaid patients to the right interventions and reduce avoidable utilization. The team blends clinical operators with engineers building on health-system claims and EHR data.",
    website: "https://anchorhealthinnovation.com",
    primary_category: "healthcare_ai",
    founded_year: 2019,
    employee_count_bucket: "11-50",
    tags: %w[healthcare-ai machine-learning],
    status: "published"
  },
  {
    slug: "sonavex",
    name: "Sonavex",
    tagline: "AI-guided ultrasound for post-surgical monitoring.",
    description: "Sonavex, a Hopkins spinout based in Baltimore, builds an AI-augmented ultrasound platform that helps clinicians detect complications after vascular and reconstructive surgery. The system uses computer vision to interpret images that previously required specialized sonographer training.",
    website: "https://www.sonavex.com",
    primary_category: "healthcare_ai",
    founded_year: 2013,
    employee_count_bucket: "11-50",
    tags: %w[healthcare-ai computer-vision],
    status: "published"
  },
  {
    slug: "thread-research",
    name: "Thread (formerly Thread Research)",
    tagline: "Decentralized clinical trial platform with ML-assisted operations.",
    description: "Thread, with origins in the Baltimore-DC region, runs a decentralized clinical trial platform. Their ML work focuses on patient retention prediction and trial-operations optimization — applied AI in service of a regulated workflow.",
    website: "https://www.threadresearch.com",
    primary_category: "healthcare_ai",
    founded_year: 2014,
    employee_count_bucket: "51-200",
    tags: %w[healthcare-ai machine-learning],
    status: "published"
  },
  # TODO(curator): Element Biosciences is San Diego-based. Hidden until a verified
  # Baltimore-area office or substantive collaboration can be cited.
  {
    slug: "loop-genomics",
    name: "Element Biosciences (Baltimore presence)",
    tagline: "Next-generation sequencing with ML-driven base calling.",
    description: "Element Biosciences operates lab and engineering presence in the Baltimore-area genomics corridor. Their sequencing platforms rely heavily on ML for base calling and quality scoring — work that intersects with the broader Hopkins/PGDx genomics community.",
    website: "https://www.elementbiosciences.com",
    primary_category: "research",
    founded_year: 2017,
    employee_count_bucket: "201-500",
    tags: %w[genomics machine-learning biotech-ai],
    status: "hidden"
  },
  # TODO(curator): Vita Inclinata is Denver-based. Hidden until Baltimore connection
  # can be substantiated.
  {
    slug: "cresta-baltimore",
    name: "Vita Inclinata",
    tagline: "AI-stabilized rescue equipment for first responders.",
    description: "Vita Inclinata, with engineering teams that have included Baltimore-area talent, uses sensor fusion and ML to stabilize loads suspended from helicopters in rescue, military, and construction operations. The company represents a less-common physical-AI flavor of the regional ecosystem.",
    website: "https://vitainclinata.com",
    primary_category: "robotics",
    founded_year: 2015,
    employee_count_bucket: "51-200",
    tags: %w[robotics defense-ai],
    status: "hidden"
  },
  # TODO(curator): Scopio is Israeli with US ops in Boston. Hidden until bwtech
  # connection is verified directly with the company.
  {
    slug: "scopio-labs-bwtech",
    name: "Scopio Labs (Bwtech presence)",
    tagline: "AI-powered digital cell morphology.",
    description: "Scopio Labs builds AI-driven digital microscopy that automates blood smear analysis for hematology. Their U.S. operations leverage the bwtech@UMBC research-park ecosystem alongside other healthcare-AI peers.",
    website: "https://scopiolabs.com",
    primary_category: "healthcare_ai",
    founded_year: 2015,
    employee_count_bucket: "51-200",
    tags: %w[computer-vision healthcare-ai],
    status: "hidden"
  },
  {
    slug: "qomplx",
    name: "QOMPLX",
    tagline: "Decision-platform AI for cyber and risk.",
    description: "QOMPLX, with offices in Tysons and the broader DC-Baltimore corridor, builds an enterprise decision platform that fuses cybersecurity telemetry with risk modeling. ML and graph analytics sit at the core of how their platform stitches signals into customer-specific risk scores.",
    website: "https://www.qomplx.com",
    primary_category: "applied_ai",
    founded_year: 2014,
    employee_count_bucket: "201-500",
    tags: %w[cybersecurity-ai fintech-ai machine-learning],
    status: "published"
  },
  # TODO(curator): Sparkfly is Atlanta-based and remote. Hidden — distributed team
  # presence isn't a strong enough Baltimore claim.
  {
    slug: "argo-ai-baltimore",
    name: "Sparkfly",
    tagline: "Real-time offer-orchestration AI for retail.",
    description: "Sparkfly's distributed team includes Baltimore-area engineers building real-time offer-orchestration infrastructure for major retailers. ML drives both targeting and fraud-prevention pipelines that operate at sub-second latency at the point of sale.",
    website: "https://www.sparkfly.com",
    primary_category: "applied_ai",
    founded_year: 2011,
    employee_count_bucket: "51-200",
    tags: %w[machine-learning fintech-ai],
    status: "hidden"
  },
  # TODO(curator): WillowTree is Charlottesville-HQ. They acquired Mindgrub but the
  # "Baltimore studio" framing is still a stretch as a standalone entry. Hidden
  # in favor of keeping the Mindgrub entry.
  {
    slug: "lumen-ai-baltimore",
    name: "WillowTree (Baltimore studio)",
    tagline: "Digital product studio with a deep generative-AI practice.",
    description: "WillowTree maintains a Baltimore-area studio and has built a substantial generative-AI consulting practice, helping enterprise customers ship LLM-powered features. The firm's regional presence makes it a meaningful contributor to local AI hiring.",
    website: "https://www.willowtreeapps.com",
    primary_category: "consulting",
    founded_year: 2008,
    employee_count_bucket: "1000+",
    tags: %w[ai-consulting llm],
    status: "hidden"
  },
  {
    slug: "rooferrate",
    name: "RooferRate",
    tagline: "AI-augmented directory and review platform for roofers.",
    description: "RooferRate is a Baltimore-built directory of residential and commercial roofing contractors with AI-assisted profile enrichment, review summarization, and lead-routing workflows. The platform demonstrates how vertical AI tooling can lift quality in a fragmented local-services market.",
    website: "https://rooferrate.com",
    primary_category: "applied_ai",
    founded_year: 2024,
    employee_count_bucket: "1-10",
    tags: %w[applied-ai natural-language-processing],
    status: "published"
  }
].freeze

COMPANIES.each do |attrs|
  tag_slugs = attrs[:tags] || []
  company_attrs = attrs.except(:tags)

  company = Company.find_or_initialize_by(slug: company_attrs[:slug])
  company.assign_attributes(company_attrs)
  company.source = "curator"
  company.save!

  tag_slugs.each do |tag_slug|
    tag = Tag.find_by(slug: tag_slug)
    next unless tag
    CompanyTag.find_or_create_by!(company: company, tag: tag)
  end
end

puts "  -> #{Company.count} companies (#{Company.published.count} published)"

puts "Seeding resources..."

RESOURCES = [
  {
    slug: "johns-hopkins-apl",
    name: "Johns Hopkins Applied Physics Laboratory (APL)",
    tagline: "One of the largest applied AI research labs in the U.S.",
    description: "JHU/APL in Laurel, MD employs thousands of researchers across AI, autonomy, space systems, and national security. Its AI work spans foundation models for science, multi-agent autonomy, and trustworthy ML — and APL alumni populate a meaningful share of Baltimore-area AI startups.",
    website: "https://www.jhuapl.edu",
    resource_type: "lab",
    founded_year: 1942,
    status: "published"
  },
  {
    slug: "jhu-mathematical-institute-data-science",
    name: "JHU Mathematical Institute for Data, Algorithms, and Decision-making (MINDS)",
    tagline: "JHU's interdisciplinary AI/ML research institute.",
    description: "MINDS connects AI and data-science research across the Whiting School of Engineering, Krieger School of Arts and Sciences, and the Bloomberg School of Public Health. The institute is one of the most active publishers of foundational ML research in Baltimore.",
    website: "https://minds.jhu.edu",
    resource_type: "lab",
    founded_year: 2018,
    status: "published"
  },
  {
    slug: "jhu-data-science-and-ai-institute",
    name: "JHU Data Science and AI Institute (DSAI)",
    tagline: "JHU's university-wide AI institute, launched 2024.",
    description: "DSAI is Johns Hopkins's flagship AI research and education institute, coordinating efforts across schools and serving as a hub for industry collaboration. Its launch reflects a major institutional bet on AI in Baltimore.",
    website: "https://ai.jhu.edu",
    resource_type: "lab",
    founded_year: 2024,
    status: "published"
  },
  {
    slug: "umbc-ai-cybersecurity-collaboratory",
    name: "UMBC Center for AI",
    tagline: "AI research at the University of Maryland, Baltimore County.",
    description: "UMBC has been an early hub of AI research in Maryland, with active groups in NLP, knowledge graphs, ML systems, and cybersecurity-AI. The university feeds talent and research into the surrounding bwtech research park ecosystem.",
    website: "https://www.umbc.edu",
    resource_type: "university",
    founded_year: 1966,
    status: "published"
  },
  {
    slug: "bwtech-umbc",
    name: "bwtech@UMBC Research and Technology Park",
    tagline: "Research park hosting many Baltimore AI and cybersecurity firms.",
    description: "bwtech@UMBC houses cybersecurity, AI, and biotech tenants alongside an active accelerator. It's the closest thing Baltimore has to a co-located AI cluster outside of Hopkins's footprint.",
    website: "https://bwtechumbc.com",
    resource_type: "accelerator",
    founded_year: 2003,
    status: "published"
  },
  {
    slug: "fastforward-u",
    name: "FastForward U (Johns Hopkins)",
    tagline: "JHU's startup accelerator and student-founder community.",
    description: "FastForward U supports JHU student and alumni founders with programming, space, and funding — and a meaningful share of Baltimore-area AI startups have early roots here. Its programs run year-round across multiple Hopkins campuses.",
    website: "https://ventures.jhu.edu/fastforward",
    resource_type: "accelerator",
    founded_year: 2014,
    status: "published"
  },
  {
    slug: "tedco",
    name: "TEDCO (Maryland Technology Development Corporation)",
    tagline: "State-backed early-stage funding and support, with a deep AI portfolio.",
    description: "TEDCO is the State of Maryland's tech investment and entrepreneur-support arm. It has invested in dozens of Baltimore-area AI and life-sciences startups and runs programming targeted at underrepresented founders and rural-MD entrepreneurs.",
    website: "https://www.tedcomd.com",
    resource_type: "program",
    founded_year: 1998,
    status: "published"
  },
  {
    slug: "etc-baltimore",
    name: "Emerging Technology Centers (ETC Baltimore)",
    tagline: "City-affiliated incubator for Baltimore tech founders.",
    description: "ETC Baltimore is a non-profit business incubator that has supported Baltimore startups since 1999. While not AI-specific, several of the city's AI companies have launched out of its space.",
    website: "https://etcbaltimore.com",
    resource_type: "accelerator",
    founded_year: 1999,
    status: "published"
  },
  # TODO(curator): The Baltimore AI/ML Meetup has been defunct for years.
  # Hidden until a real, active replacement community is identified
  # (or until we run our own).
  {
    slug: "baltimore-ai-meetup",
    name: "Baltimore AI/ML Meetup",
    tagline: "Defunct as of 2026 — kept as a placeholder pending a replacement.",
    description: "The Baltimore AI/ML Meetup is no longer active. This entry is kept hidden as a placeholder until a real, current AI practitioner community is identified or established in Baltimore.",
    website: "https://www.meetup.com",
    resource_type: "event_series",
    status: "hidden"
  },
  {
    slug: "technical-ly-baltimore",
    name: "Technical.ly Baltimore",
    tagline: "Local journalism covering Baltimore's tech ecosystem.",
    description: "Technical.ly's Baltimore vertical is the most consistent journalistic source covering local tech startups, including most of the city's AI companies. Coverage there is also a meaningful local-citation signal for SEO.",
    website: "https://technical.ly/baltimore",
    resource_type: "program",
    status: "published"
  }
].freeze

RESOURCES.each do |attrs|
  resource = Resource.find_or_initialize_by(slug: attrs[:slug])
  resource.assign_attributes(attrs)
  resource.save!
end

puts "  -> #{Resource.count} resources (#{Resource.published.count} published)"

puts "Seeding guides..."
load Rails.root.join("db/seeds/guides.rb")

puts ""
puts "Seed complete."
puts "  Tags:      #{Tag.count}"
puts "  Companies: #{Company.count} (#{Company.published.count} published)"
puts "  Resources: #{Resource.count} (#{Resource.published.count} published)"
puts "  Guides:    #{Guide.count} (#{Guide.published.count} published)"

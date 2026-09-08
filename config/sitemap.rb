# Sitemaps are now rendered directly from published records by
# DiscoveryController at /sitemap.xml. There is no scheduled generation step.
# Keep this compatibility notice for deployments that still run sitemap:create;
# writing a file into public/ would shadow the route and become stale again.
warn "The sitemap is served dynamically at /sitemap.xml; no static file was generated."

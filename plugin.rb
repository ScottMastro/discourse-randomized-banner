# frozen_string_literal: true

# name: discourse-randomized-banner
# about: Inserts a randomized banner below the header
# version: 1.2
# authors: ScottMastro
# url: https://github.com/ScottMastro/discourse-randomized-banner
# transpile_js: true

enabled_site_setting :enable_randomized_banner

register_asset "stylesheets/common/common.scss"

# preload the banner to improve Largest Contentful Paint (LCP)
register_html_builder("server:before-head-close") do
  preload_links = []

  [SiteSetting.guest_banner, SiteSetting.override_banner].each do |url|
    if SiteSetting.optimize_lcp && url.present?
      preload_links << %Q(<link rel="preload" as="image" href="#{url}">)
    end
  end

  preload_links.join("\n")
end

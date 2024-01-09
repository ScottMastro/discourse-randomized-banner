# frozen_string_literal: true

# name: discourse-randomized-banner
# version: 1.1.0
# authors: ScottMastro
# url: https://github.com/ScottMastro/discourse-randomized-banner
# about: Inserts a randomized banner below the header
# required_version: 2.7.0
# transpile_js: true

enabled_site_setting :enable_randomized_banner

register_asset 'stylesheets/common/common.scss'
register_asset 'stylesheets/mobile/mobile.scss', :mobile

# preload the banner to improve Largest Contentful Paint (LCP) 
register_html_builder('server:before-head-close') do
  if SiteSetting.guest_banner && SiteSetting.optimize_lcp
    %Q(<link rel="preload" as="image" href="#{SiteSetting.guest_banner}">)
  else
    ''
  end
  
  if SiteSetting.override_banner && SiteSetting.optimize_lcp
    %Q(<link rel="preload" as="image" href="#{SiteSetting.override_banner}">)
  else
    ''
  end
  
end

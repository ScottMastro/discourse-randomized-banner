# frozen_string_literal: true

# name: discourse-e4-banner-plugin
# version: 1.0.0
# authors: ScottMastro
# url: https://github.com/ScottMastro/discourse-e4-banner-plugin
# required_version: 2.7.0
# transpile_js: true

enabled_site_setting :enable_banner

register_asset 'stylesheets/common/common.scss'
register_asset 'stylesheets/mobile/mobile.scss', :mobile

register_html_builder('server:before-head-close') do
  if SiteSetting.guest_banner && SiteSetting.optimize_lcp
    %Q(<link rel="preload" as="image" href="#{SiteSetting.guest_banner}">)
  else
    ''
  end
end

#register_html_builder('server:before-head-close') do
#  if SiteSetting.optimize_lcp
#    SiteSetting.banner_images.split('|').map do |url|
#      %Q(<link rel="prefetch" as="image" href="#{url}">)
#    end.join("\n")
#  else
#    ''
#  end
#end


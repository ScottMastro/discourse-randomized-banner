import { withPluginApi } from "discourse/lib/plugin-api";

export default {
  name: "randomize-banner",
  initialize(container) {
    const siteSettings = container.lookup("site-settings:main");
    if (siteSettings.enable_banner) {
      withPluginApi("0.1", (api) => randomizeBanner(api, siteSettings));
    }
  },
};

function randomizeBanner(api, siteSettings) {
  var str = siteSettings.banner_images;
  var banners = str.split('|');

  if (banners.length > 0) {
    var num = Math.floor( Math.random() * banners.length);
    var img = banners[num];

    api.registerConnectorClass('above-main-container', 'banner', {
      setupComponent(attrs, component) {
        component.setProperties({"selected-banner": img});
      }
    });
  }
}

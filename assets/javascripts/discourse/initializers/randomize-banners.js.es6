import { withPluginApi } from "discourse/lib/plugin-api";

import RandomizedBanner from "../components/randomized-banner";

export default {
  name: "randomize-banner",
  initialize(container) {
    const siteSettings = container.lookup("site-settings:main");
    if (siteSettings.enable_banner) {
      withPluginApi("0.8", (api) => {
        const banners = siteSettings.banner_images.split('|').filter(Boolean);
	let img;

	const currentUser = api.getCurrentUser();
	if (!currentUser && siteSettings.guest_banner) {
          img = siteSettings.guest_banner;
	} else if (banners) {
          const num = Math.floor(Math.random() * banners.length);
          img = banners[num];
	}

        api.renderInOutlet('above-main-container', 
          RandomizedBanner.extend({ selectedBanner: img })
        );
        
      });
    }
  },
};



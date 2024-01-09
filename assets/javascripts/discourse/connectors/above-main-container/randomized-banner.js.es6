import { withPluginApi } from "discourse/lib/plugin-api";

export default {
  setupComponent(attrs, component) {
    withPluginApi("0.8", api => {
      if (this.siteSettings.enable_randomized_banner) {
        const currentUser = api.getCurrentUser();
        let img;
        
        if (this.siteSettings.override_banner) { // use the override banner
          img = this.siteSettings.override_banner;
        } else if (!currentUser && this.siteSettings.guest_banner) { // use a guest banner
          img = this.siteSettings.guest_banner;
        } else if (banners.length > 0) { // use a random banner
          const randomBanners = this.siteSettings.banner_images.split('|').filter(Boolean);
          const num = Math.floor(Math.random() * randomBanners.length);
          img = banners[num];
        }

        component.set('bannerSrc', img);

      }
    });
  }
};


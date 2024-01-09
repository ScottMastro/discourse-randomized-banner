import { withPluginApi } from "discourse/lib/plugin-api";

export default {
  setupComponent(attrs, component) {
    withPluginApi("0.8", api => {
      try {
        if (this.siteSettings.enable_randomized_banner) {
          const currentUser = api.getCurrentUser();
          const randomBanners = this.siteSettings.banner_images.split('|').filter(Boolean);
          let img;
          
          if (this.siteSettings.override_banner) { // use the override banner
            img = this.siteSettings.override_banner;
          } else if (!currentUser && this.siteSettings.guest_banner) { // use a guest banner
            img = this.siteSettings.guest_banner;
          } else if (randomBanners) { // use a random banner
            const num = Math.floor(Math.random() * randomBanners.length);
            img = randomBanners[num];
          }

          component.set('bannerSrc', img);
        }
      } catch (error) {
        console.error("Error setting banner source: ", error);
        component.set('bannerSrc', null);
      }
    });
  }
};


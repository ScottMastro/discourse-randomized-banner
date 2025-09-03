import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { concat } from "@ember/helper";
import { service } from "@ember/service";
import { htmlSafe } from "@ember/template";

export default class RandomizedBanner extends Component {
  static shouldRender(args, context) {
    return (
      context.siteSettings.enable_randomized_banner &&
      (context.siteSettings.override_banner?.trim()?.length > 0 ||
        context.siteSettings.guest_banner?.trim()?.length > 0 ||
        context.siteSettings.banner_images?.trim()?.length > 0)
    );
  }

  @service siteSettings;
  @service currentUser;

  @tracked bannerSrc = null;

  constructor() {
    super(...arguments);

    const { override_banner, guest_banner, banner_images } = this.siteSettings;

    if (override_banner) {
      this.bannerSrc = override_banner;
    } else if (!this.currentUser && guest_banner) {
      this.bannerSrc = guest_banner;
    } else {
      const randomBanners = (banner_images || "").split("|").filter(Boolean);
      if (randomBanners.length) {
        const num = Math.floor(Math.random() * randomBanners.length);
        this.bannerSrc = randomBanners[num];
      }
    }
  }

  <template>
    <div
      id="randomized-banner-container"
      style={{htmlSafe
        (concat
          "aspect-ratio:"
          this.siteSettings.banner_aspect_ratio
          ";max-height:"
          this.siteSettings.banner_max_height
        )
      }}
    >
      {{#if this.bannerSrc}}
        <img
          id="randomized-banner"
          src={{this.bannerSrc}}
          fetchpriority="high"
          alt="forum banner"
        />
      {{/if}}
    </div>
  </template>
}

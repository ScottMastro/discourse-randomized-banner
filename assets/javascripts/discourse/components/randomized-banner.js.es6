import Component from "@ember/component";
import { computed } from "@ember/object";

export default Component.extend({
  selectedBanner: null,

  bannerSrc: computed('selectedBanner', function() {
    return this.selectedBanner;
  }),
});


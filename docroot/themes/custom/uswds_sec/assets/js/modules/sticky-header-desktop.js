//------------------------------------------------------------------------
// Sticky desktop nav that hides on scroll
//
// NOTE: We can’t import the Protocol JS since it doesn’t use ES modules:
//       import "@mozilla-protocol/core/protocol/js/protocol-supports";
//       import "@mozilla-protocol/core/protocol/js/protocol-navigation";
//------------------------------------------------------------------------
export default class StickyHeader {
  constructor() {
    // Don’t run if logged into Drupal
    if (window.drupalSettings && window.drupalSettings.user?.uid !== 0) {
      return;
    }

    this.header = document.querySelector(".header");
    this.headerWatcherEl = document.querySelector(".sticky-header-watcher");
    this.mediaQueryList = window.matchMedia("(min-width: 1024px)");
    this.className = "is-stuck";
    // Use separate var for event callback so we can remove it later
    this.animationEndCallback = this.onAnimationEnd.bind(this);

    // Exit if we can’t find the header and main elements
    if (!this.header || !this.headerWatcherEl) {
      return;
    }

    // Toggle class when header becomes sticky
    // Note: Use 120px offset so it has time to animate back to the intial
    //       state when scrolling back up. This requires observing a separate
    //       element (“.sticky-header-watcher”) right after the header since
    //       the header will be sticky and its position won’t change.
    this.headerWatcherObserver = new IntersectionObserver(
      (entry) => {
        if (entry[0].intersectionRatio === 0) {
          this.header.classList.add(this.className, "slide-down");
        } else if (this.header.classList.contains(this.className)) {
          // Comment out if using slide-up animation
          this.header.classList.remove(this.className, "slide-down");

          // Uncomment below to enable slide-up animation
          //
          // this.header.addEventListener(
          //   "animationend",
          //   this.animationEndCallback
          // );
          // this.header.classList.remove("slide-down");
          // this.header.classList.add("slide-up");
        }
      },
      {
        rootMargin: "120px 0px 0px 0px",
        threshold: 0,
      }
    );

    // Listen for breakpoint change
    this.mediaQueryList.addListener((evt) => {
      if (evt.matches) {
        this.init();
      } else {
        this.destroy();
      }
    });

    // Init on load
    if (this.mediaQueryList.matches) {
      this.init();
    }
  }

  onAnimationEnd() {
    this.header.classList.remove(this.className, "slide-up");
    this.header.removeEventListener("animationend", this.animationEndCallback);
  }

  init() {
    this.headerWatcherObserver.observe(this.headerWatcherEl);
  }

  destroy() {
    this.header.removeEventListener("animationend", this.animationEndCallback);
    this.headerWatcherObserver.unobserve(this.headerWatcherEl);
    this.header.classList.remove(this.className);
  }
}

/* eslint no-unused-vars: "off" */
const stickyHeaderDesktop = new StickyHeader(".header");

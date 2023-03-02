//------------------------------------------------------------------------
// Protocol Navigation (modified for SEC)
// https://protocol.mozilla.org/patterns/organisms/navigation.html
// https://github.com/mozilla/protocol/blob/main/assets/js/protocol/protocol-supports.js
//------------------------------------------------------------------------
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */
import Supports from "./protocol-supports";

export default class Navigation {
  constructor(el, options) {
    this._navElem = el;
    this._navItemsLists;
    this._ticking = false;
    this._lastKnownScrollPosition = 0;
    this._animationFrameID = null;
    this._stickyScrollOffset = 300;
    // this._wideBreakpoint = "0px";// always sticky
    // this._tallBreakpoint = "600px";
    this._mediaQueryList = window.matchMedia("(max-width: 1023px)");// only applies in mobile
    this._mq;
    this._viewport = document.getElementsByTagName("html")[0];
    this.navIsSticky = this._navElem && this.supportsSticky();
    this.prefersReducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches;

    // Use Object.assign() to merge options with defaults
    this._options = Object.assign(
      {},
      {
        onNavOpen: null,
        onNavClose: null,
      },
      options
    );

    this.init();
  }

  /**
   * Feature detect for sticky navigation
   * @returns {Boolean}
   */
  supportsSticky() {
    if (typeof Supports !== "undefined") {
      return (
        Supports.matchMedia &&
        Supports.classList &&
        Supports.requestAnimationFrame &&
        Supports.cssFeatureQueries &&
        CSS.supports("position", "sticky")
      );
    } else {
      return false;
    }
  }

  /**
   * Scroll event listener. No computationally expensive
   * operations such as DOM modifications should happen
   * here. Instead we throttle using `requestAnimationFrame`.
   */
  onScroll() {
    if (!this._ticking) {
      this._animationFrameID = window.requestAnimationFrame(this.checkScrollPosition.bind(this));
      this._ticking = true;
    }
  }

  /**
   * Create sticky state for the navigation.
   */
  createSticky() {
    this._viewport.classList.add("has-sticky-navigation");
    this._animationFrameID = window.requestAnimationFrame(this.checkScrollPosition.bind(this));
    this.scrollHandler = this.onScroll.bind(this);
    window.addEventListener("scroll", this.scrollHandler, false);
  }

  /**
   * Destroy sticky state for the navigation.
   */
  destroySticky() {
    this._viewport.classList.remove("has-sticky-navigation");
    this._navElem.classList.remove("is-scrolling");
    this._navElem.classList.remove("is-hidden");
    this._lastKnownScrollPosition = 0;

    if (this._animationFrameID) {
      window.cancelAnimationFrame(this._animationFrameID);
    }
    window.removeEventListener("scroll", this.scrollHandler);
  }

  /**
   * Initialize sticky state for the navigation.
   * Uses `matchMedia` to determine if conditions
   * for sticky navigation are satisfied.
   */
  initSticky() {
    this._mediaQueryList.addListener((mq) => {
      if (mq.matches) {
        this.createSticky();
      } else {
        this.destroySticky();
      }
    });

    if (this._mediaQueryList.matches) {
      this.createSticky();
    }
  }

  /**
   * Implements sticky navigation behaviour as
   * user scrolls up and down the viewport.
   */
  checkScrollPosition() {
    // add styling for when scrolling the viewport
    if (window.scrollY > 0) {
      this._navElem.classList.add("is-scrolling");
    } else {
      this._navElem.classList.remove("is-scrolling");
    }

    // scrolling down
    if (window.scrollY > this._lastKnownScrollPosition) {
      // hide the sticky nav shortly after scrolling down the viewport.
      if (window.scrollY > this._stickyScrollOffset) {
        // if there’s a menu currently open, close it.
        // if (typeof Mzp.Menu !== "undefined") {
        //   Mzp.Menu.close();
        // }

        this._navElem.classList.add("is-hidden");
      }
    }
    // scrolling up
    else {
      this._navElem.classList.remove("is-hidden");
    }

    this._lastKnownScrollPosition = window.scrollY;
    this._ticking = false;
  }

  /**
   * Initialise menu.
   * @param {Object} options - configurable options.
   */
  init(options) {
    /**
     * Init (optional) sticky navigation.
     * If there are multiple navigation organisms on a single page,
     * assume only the first (and hence top-most) instance can and
     * will be sticky.
     *
     * Do not init sticky navigation if user prefers reduced motion
     */
    const navIsSticky = this._navElem && this._navElem.classList.contains("is-sticky") && this.supportsSticky();

    if (this.prefersReducedMotion) {
      this._navElem.classList.remove("is-sticky");
    } else if (this.navIsSticky) {
      this.initSticky();
    }
  }
}

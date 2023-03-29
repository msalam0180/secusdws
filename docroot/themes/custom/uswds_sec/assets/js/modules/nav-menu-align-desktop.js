//------------------------------------------------------------------------
// Dynamically update nav menu alignment to prevent menu from being cutoff
//------------------------------------------------------------------------
export default class NavMenuAlign {
  constructor() {
    this.menus = document.querySelectorAll(
      '.usa-nav__submenu[data-level="1"]:not(.is-megamenu)'
    );
    this.mediaQueryList = window.matchMedia("(min-width: 1024px)");
    this.className = "align-right";

    // Exit if no menus
    if (!this.menus) {
      return;
    }

    // Save window resize callback to a var so we can remove it later
    this.resizeHandler = this.debounce(() => {
      // Due to debounce() it’s possible for this to run after destroy() has been called.
      // To avoid this race condition, check “this.hasInitialized” first.
      if (this.hasInitialized) {
        window.requestAnimationFrame(this.checkMenus.bind(this));
      }
    }, 250).bind(this);

    // Listen for breakpoint change
    this.mediaQueryList.addListener((evt) => {
      if (evt.matches) {
        this.init();
      } else {
        this.destroy();
      }
    });

    // Check on inital page load
    if (this.mediaQueryList.matches) {
      this.init();
    }
  }

  // Debounce function
  // Note: If this ends up being used elsewhere we should move to a separate file
  // https://www.joshwcomeau.com/snippets/javascript/debounce/
  /* eslint class-methods-use-this: "off" */
  debounce(callback, wait) {
    let timeoutId = null;

    return (...args) => {
      window.clearTimeout(timeoutId);
      timeoutId = window.setTimeout(() => {
        callback(...args);
      }, wait);
    };
  }

  checkMenus() {
    this.menus.forEach((el) => {
      // Remove previous alignment class if present
      el.classList.remove(this.className);

      // Make it so we can measure the element (doesn’t work when set to “display: none”)
      el.setAttribute("style", "display: block; visibility: hidden;");

      // Get element’s right offset
      const rightOffset = el.getBoundingClientRect().right;

      // Check if menu is cutoff and apply class
      if (rightOffset > window.innerWidth) {
        el.classList.add(this.className);
      }

      // Remove inline styles
      el.removeAttribute("style");
    });
  }

  resetMenus() {
    this.menus.forEach((el) => {
      // Remove alignment class if present
      el.classList.remove(this.className);
    });
  }

  init() {
    this.checkMenus();

    // Store state for window resize callback to avoid race condition
    // between debounce() and requestAnimationFrame().
    this.hasInitialized = true;

    // Check menus on window resize
    window.addEventListener("resize", this.resizeHandler);
  }

  destroy() {
    this.hasInitialized = false;

    this.resetMenus();

    // Remove event listener
    window.removeEventListener("resize", this.resizeHandler);
  }
}

/* eslint no-unused-vars: "off" */
const navMenuAlign = new NavMenuAlign();

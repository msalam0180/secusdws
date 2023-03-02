//------------------------------------------------------------------------
// Protocol Supports (adapted for Rally)
// https://github.com/mozilla/protocol/blob/main/src/assets/js/protocol/protocol-supports.js
//------------------------------------------------------------------------
export default {
  /**
  * matchMedia
  * @return {Boolean} boolean value for if the browser supports matchMedia
  */
  matchMedia: function() {
      return typeof window.matchMedia !== "undefined" && window.matchMedia("all").addListener;
  },

  /**
  * requestAnimationFrame
  * @return {Boolean} boolean value for if the browser supports requestAnimationFrame
  */
  requestAnimationFrame: function() {
      return "requestAnimationFrame" in window;
  },

  /**
  * cssFeatureQueries
  * @return {Boolean} boolean value for if the browser supports cssFeatureQueries
  */
  cssFeatureQueries: function() {
      return typeof CSS !== "undefined" && typeof CSS.supports !== "undefined";
  },

  /**
  * classList
  * @return {Boolean} boolean value for if the browser supports classList
  */
  classList: function() {
      return "classList" in document.createElement("div");
  },

  /**
   * details
   * @return {Boolean} boolean value for if the browser supports the details/summary elements
   * - feature detection for HTML5 detail/summary support
   * - https://mathiasbynens.be/notes/html5-details-jquery#comment-35
   */
  details: function() {
      var el = doc.createElement("details");
      var fake;
      var root;
      var diff;
      if (!("open" in el)) {
          return false;
      }
      root = doc.body || (function() {
          var de = doc.documentElement;
          fake = true;
          return de.insertBefore(doc.createElement("body"), de.firstElementChild || de.firstChild);
      }());
      el.innerHTML = "<summary>a</summary>b";
      el.style.display = "block";
      root.appendChild(el);
      diff = el.offsetHeight;
      el.open = true;
      diff = diff !== el.offsetHeight;
      root.removeChild(el);
      if (fake) {
          root.parentNode.removeChild(root);
      }
      return diff;
  }

};

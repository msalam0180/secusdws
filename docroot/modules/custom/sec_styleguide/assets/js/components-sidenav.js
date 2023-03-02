/**
 * Sidenav JS functions.
 * @file
 */
// Always use "use strict";
"use strict";

(function (Drupal, drupalSettings, once) {
  Drupal.behaviors.uswdsGenSidenav = {
    attach: function (context, settings) {
      // Define the ids for the accordion button and content.
      const accordion_button = document.getElementById('components-side-nav-button')
      const accordion_content = document.getElementById('components-side-nav')
      // We define a matchMedia media query in order to show hide
      // the accordion menu depending on the viewport width.
      const mq1024 = window.matchMedia("(min-width: 1024px)")
      // Add a Listener.
      mq1024.addListener(WidthChange1024)
      // Define the width change.
      WidthChange1024(mq1024)
      // Media query change function for width specific functions.
      function WidthChange1024(mq) {
        if (mq1024.matches) {
          // Greater than 1024px.
          // Keep the accordion open.
          accordion_button.setAttribute('aria-expanded', 'true')
          accordion_content.removeAttribute('hidden')
        }
        else {
          // Less than 1024px.
          // Close down the accordion.
          accordion_button.setAttribute('aria-expanded', 'false')
          accordion_content.setAttribute('hidden', 'hidden')
        }
      }
    },
  };
})(Drupal, drupalSettings, once);

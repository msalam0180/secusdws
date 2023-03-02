/**
 * Sidenav JS functions.
 * @file
 */
// Always use "use strict";
"use strict";

(function (Drupal, drupalSettings, once) {
  Drupal.behaviors.uswdsGenFilter = {
    attach: function (context, settings) {
      // Define the reset button and filter input functionality
      const resetButton = document.getElementById("btn-filter-reset");

      // Get component list
      const componentList = document.querySelector("[data-filter]");

      if (!componentList) {
        return false;
      }

      // Save component title element selector
      const componentTitleSelector = componentList.getAttribute("data-filter");

      // Get component list items
      const componentItems = componentList.children;

      if (!componentItems) {
        return false;
      }

      // Custom function for the filtering.
      const liveSearch = function () {
        // Define the filter text input box.
        let filterQuery = document.getElementById("filter-input").value;

        // Loop all the elements.
        for (let i = 0; i < componentItems.length; i++) {
          // Define the items to be searched within the card, in this case the title.
          let cardTitle = componentItems[i].querySelector(componentTitleSelector)?.textContent.trim();

          // If the text in the title is found in the filtering, keep the card visible.
          if (cardTitle.toLowerCase().includes(filterQuery.toLowerCase())) {
            componentItems[i].removeAttribute("hidden");
          }
          // Otherwise, hide the card.
          else {
            componentItems[i].setAttribute("hidden", true);
          }

          // Reset everything.
          resetButton.addEventListener("click", function () {
            filterQuery = "";
            componentItems[i].removeAttribute("hidden");
          });
        }
      };

      // Keyup timer for a slight delay.
      let typingTimer;
      let typeInterval = 500;
      let searchInput = document.getElementById("filter-input");

      // Invoke the function within a keyup listener.
      searchInput.addEventListener("keyup", () => {
        clearTimeout(typingTimer);
        typingTimer = setTimeout(liveSearch, typeInterval);
      });
    },
  };
})(Drupal, drupalSettings, once);

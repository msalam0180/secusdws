// Update the desktop sidenav top offset to align with the toggle button
//
// Sets inline style on “usa-modal-overlay” with “top” equal to
// the top offset of “.sidenav-toggle”, or zero if it’s negative.
//
// TODO: Determine what JS conventions we want to follow.
//       We could convert this to an ES module[1] and/or use a class[2].
//       1. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules
//       2. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes
//
// Use an IIFE for now to avoid global conflicts
// https://developer.mozilla.org/en-US/docs/Glossary/IIFE
(() => {
  const toggle = document.querySelector(".sidenav-toggle");
  const wrapper = document.querySelector(".l-show-sidenav-desktop");

  // Exit early if no sidenav toggle on page
  if (!toggle && !wrapper) {
    return false;
  }

  // Adjust the overlay top offset on click to it aligns with toggle button
  // Note: This was simpler than listening to scroll and window resize events
  //       and writing logic to disable them when in mobile view.
  toggle.addEventListener("click", () => {
    // Get modal overlay element on click since it may not exist (i.e. in mobile)
    const modalOverlay = document.querySelector(".usa-modal-overlay");
    if (!modalOverlay) {
      return false;
    }

    const wrapperTopOffset = wrapper.getBoundingClientRect().y;

    // Check if the wrapper element is above the viewport (i.e. negative)
    // and if so reset the top offset by removing the “style” attribute.
    if (wrapperTopOffset > 0) {
      modalOverlay.style.top = `${wrapperTopOffset}px`;
    } else {
      modalOverlay.removeAttribute("style");
    }
  });
})();

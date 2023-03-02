// Copy link URL to clipboard
// https://developer.mozilla.org/en-US/docs/Web/API/Clipboard/writeText
//
// TODO: Determine what JS conventions we want to follow.
//       We could convert this to an ES module[1] and/or use a class[2].
//       1. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Modules
//       2. https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes
document.querySelectorAll("[data-copy-url]").forEach((el) => {
  if (!el) {
    // console.warn(`Unable to initialize copy URL functionality, no matching element for “${this.el}”`);
    return false;
  }

  // Store original link text (or in this case, the “aria-label” text)
  const linkText = el.getAttribute("aria-label");

  // Add aria-live="assertive" so screenreaders announce immediately when the link has been copied
  el.setAttribute("aria-live", "polite");

  // Note: We could avoid the ESLint warning by abstracting to a function
  // but if we’re going to do that we should probably refactor the whole
  // thing to use a JS class or something similar to namespace it.
  /* eslint max-nested-callbacks: "off" */
  el.addEventListener("click", (evt) => {
    evt.preventDefault();

    navigator.clipboard.writeText(window.location.href).then(
      // Success
      () => {
        el.classList.add("copied");
        el.setAttribute("aria-label", "Copied.");
        // Remove class after a short delay
        setTimeout(() => {
          el.classList.remove("copied");
          el.setAttribute("aria-label", linkText);
        }, 2000);
      },
      // Fail
      () => {
        el.classList.remove("copied");
      }
    );
  });
});

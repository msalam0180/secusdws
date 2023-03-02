//------------------------------------------------------------------------
// Sticky mobile header that hides on scroll
//
// Based on Mozilla’s Protocol navigation
// https://protocol.mozilla.org/patterns/organisms/navigation.html
//
// NOTE: We can’t import the Protocol JS since it doesn’t use ES modules,
//       plus we’ve customized the functionality a bit to suit SEC’s needs.
//------------------------------------------------------------------------
import StickyHeaderMobile from "../lib/protocol-navigation";

/* eslint no-unused-vars: "off" */
const stickyHeaderMobile = new StickyHeaderMobile(
  document.querySelector(".header")
);

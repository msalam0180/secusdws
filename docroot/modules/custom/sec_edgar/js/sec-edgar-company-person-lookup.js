(function ($, Drupal) {
  Drupal.behaviors.secEdgarCompanyProfile = {
    attach: function (context, settings) {

      var form = document.querySelector("#sec-edgar-company-person-form");
      var button_expand = document.querySelector("#sec-edgar-company-person-form .expand-options");
      var button_expand_wrapper = document.querySelector(".expand-options-container");
      var button_collapse = document.querySelector("#sec-edgar-company-person-form .collapse-options");
      var collapsable_region = document.querySelector("#sec-edgar-company-person-form .expanded-options");
      var search_button = document.querySelector("#sec-edgar-company-person-form .collapsed-submit");

      button_expand.addEventListener("click", (event) => {
        button_expand_wrapper.classList.add("extended-hidden");
        collapsable_region.classList.remove("extended-hidden");
        search_button.classList.add("display-none");
        form.classList.add("opened");
        document.getElementById("edgar-company-person-match1").focus({preventScroll:true});
      });

      button_collapse.addEventListener("click", (event) => {
        button_expand_wrapper.classList.remove("extended-hidden");
        collapsable_region.classList.add("extended-hidden");
        search_button.classList.remove("display-none");
        form.classList.remove("opened");
        document.getElementById("edgar-company-person").focus({preventScroll:true});
      });
    }
  };

})(jQuery, Drupal);

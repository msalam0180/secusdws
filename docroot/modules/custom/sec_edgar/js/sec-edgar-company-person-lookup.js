(function ($, Drupal) {
  Drupal.behaviors.secEdgarCompanyProfile = {
    attach: function (context, settings) {

      function getTransitionEndEventName() {
        var transitions = {
            "transition"      : "transitionend",
            "OTransition"     : "oTransitionEnd",
            "MozTransition"   : "transitionend",
            "WebkitTransition": "webkitTransitionEnd"
         }
        let bodyStyle = document.body.style;
        for(let transition in transitions) {
            if(bodyStyle[transition] != undefined) {
                return transitions[transition];
            } 
        }
      }
      
      // using above code we can get Transition end event name
      let transitionEndEventName = getTransitionEndEventName();

      var form = document.querySelector("#sec-edgar-company-person-form");
      var button_expand = document.querySelector("#sec-edgar-company-person-form .expand-options");
      var button_expand_wrapper = document.querySelector(".expand-options-container");
      var button_collapse = document.querySelector("#sec-edgar-company-person-form .collapse-options");
      var collapsable_region = document.querySelector("#sec-edgar-company-person-form .expanded-options");
      var search_button = document.querySelector("#sec-edgar-company-person-form .collapsed-submit");

      collapsableRegionToggle();

      button_expand.addEventListener("click", (event) => {
        button_expand_wrapper.classList.add("extended-hidden");
        collapsable_region.classList.remove("extended-hidden");
        collapsable_region.addEventListener(transitionEndEventName, collapsableRegionToggle());
        search_button.classList.add("display-none");
        search_button.disabled = true;
        form.classList.add("opened");
        document.getElementById("edgar-company-person-match1").focus({preventScroll:true});
        button_expand.disabled = true;
      });

      button_collapse.addEventListener("click", (event) => {
        button_expand_wrapper.classList.remove("extended-hidden");
        collapsable_region.classList.add("extended-hidden");
        collapsable_region.addEventListener(transitionEndEventName, collapsableRegionToggle());
        search_button.classList.remove("display-none");
        search_button.disabled = false;
        form.classList.remove("opened");
        document.getElementById("edgar-company-person").focus({preventScroll:true});
        button_expand.disabled = false;
      });

      function collapsableRegionToggle(ev) {
        if (collapsable_region.classList.contains("extended-hidden")) {
          collapsable_region.style.display = "none";
        }else{
          collapsable_region.style.display = "block";
        }
      }
    }    
  };

})(jQuery, Drupal);

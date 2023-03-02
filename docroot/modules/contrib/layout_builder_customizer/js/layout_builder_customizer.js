(function ($, Drupal) {
  Drupal.behaviors.LayoutBuilderCustomizer = {
    attach: function attach() {
      $('#layout-builder .js-layout-builder-block').once().hover( function (event) {
        $(this).toggleClass('layout-builder-customizer--links');
      });
    }
  };
})(jQuery, Drupal);

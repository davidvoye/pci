(function ($, Drupal, window, document, undefined) {

  Drupal.behaviors.mainMenuOffset = {

    attach: function (context) {
      var $main_menu = $('#main-menu', context);

      $main_menu.css({
        bottom: -($main_menu.height() / 2),
      });
    }

  };

}) (jQuery, Drupal, this, this.document);

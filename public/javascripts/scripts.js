(function($) {

  if (typeof window.console == "undefined" || typeof console.log == "undefined") {
    window.console = {
      log : function() {
      }
    };
  }

  function calc() {
    var selected_count = $("li.selected").size();
    $(".selected_counter").html(selected_count);
  }

  $(function() {
    $("li.movement").click(function() {
      $(this).toggleClass('selected');
      calc();
    });

    $(".movement_tools .select_none").click(function() {
      $("li.movement.selected").removeClass('selected');
      calc();
      return false;
    });

    $(".movement_tools .select_all").click(function() {
      $("li.movement").addClass('selected');
      calc();
      return false;
    });
  });
})(jQuery);
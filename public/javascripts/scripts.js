(function($) {

    if (typeof window.console == "undefined" || typeof console.log == "undefined") {
        window.console = {
            log : function() {
            }
        };
    }

    function calc() {
        var count = $("li.selected").size();
        $(".selected_counter").html(count);
        if (count == 0)
            $("#labelize input").attr('disabled', 'disabled');
        else
            $("#labelize input").removeAttr('disabled');
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

        var form = $("form#labelize");
        form.attr('action', form.attr('action') + ".js");
        $("form#labelize").submit(function() {
            var ids = [];
            $("li.movement.selected").each(function() {
                ids.push($(this).attr('id').match(/\d+$/)[0]);
            });
            $("#bulk_action_movement_ids").attr('value', ids.join(','));
            form.fadeOut();
            form.ajaxSubmit({
                success:    function() {
                    form.fadeIn();
                }
            });
            return false;
        });

        var csrf_token = $('meta[name=csrf-token]').attr('content');
        //var csrf_param = $('meta[name=csrf-param]').attr('content');
        $("a.delete_tagging").live('click', function(e) {
            e.preventDefault();
            if (confirm($(this).attr('alt'))) {
                $.post($(this).attr('href'), {
                    '_method' : 'delete',
                    'authenticity_token' : csrf_token
                }, function(data) {
                    eval(data);
                }, 'js');
            }
            return false;
        });
        $("a.add_comment").live('click', function() {
            var text = prompt("Añade tu comentario:");
            var url = $(this).attr('href');
            $.post(url, {
                'authenticity_token' : csrf_token,
                'body' : text
            }, function(data) {
                eval(data);
            }, 'js');
            return false;
        });

    });
})(jQuery);
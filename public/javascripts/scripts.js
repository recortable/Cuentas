(function($) {

    if (typeof window.console == "undefined" || typeof console.log == "undefined") {
        window.console = {
            log : function() {
            }
        };
    }

    function id(el) {
        return $(el).attr('id').match(/\d+$/)[0];
    }

    var csrf_token = $('meta[name=csrf-token]').attr('content');
    var taggings_path = $('meta[name=taggins_path]').attr('content');
    $(function() {
        $("#account .tag").draggable({revert: 'invalid', cursor: "move", helper: "clone" });
        $("li.movement").droppable({accept: '#account .tag',hoverClass: "selected", drop: function(event, ui) {
            $(this).append("<div class='spinner'>spinner</div>");
            var movId = id(this);
            var tagId = id(ui.draggable);
            $.post(taggings_path, {
                'authenticity_token' : csrf_token,
                'tagging[tag_id]' : tagId,
                'tagging[movement_id]' : movId
            }, function(data) {
                eval(data);
            }, 'js');
        }
        });

    });


    $(function() {
        $("a.delete_tagging").live('click', function(e) {
            e.preventDefault();
            if (confirm($(this).attr('alt'))) {
                $(this).parent(".movement").append("<div class='spinner'>spinner</div>");

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
            $(this).append("<div class='spinner'>spinner</div>");
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
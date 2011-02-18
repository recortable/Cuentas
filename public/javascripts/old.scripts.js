function calc() {
    var count = $("li.selected").size();
    $(".selected_counter").html(count);
    if (count == 0)
        $("#labelize input").attr('disabled', 'disabled');
    else
        $("#labelize input").removeAttr('disabled');
}

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
    console.log("Labelize", ids);
    form.fadeOut();
    form.ajaxSubmit({
        success:    function() {
            form.fadeIn();
        }
    });
    return false;
});
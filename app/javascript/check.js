$(document).on('turbolinks:load',function() {
    $('input[name="user[habit_ids][]"]').one('click',function() {
    var i = $('<i>').addClass('fa fa-thumbs-o-up')
    $(this).before(i);
    $(this).hide();
});
});
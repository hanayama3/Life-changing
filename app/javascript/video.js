$(document).on('turbolinks:load',function() {
$('.display').click(function() {
 $(this).next(".video").toggle('slow');
});
});
$(document).on('turbolinks:load',function() {
    $('.habit-show').click(function() {
        
     var show_id = $(this).attr('data-option');
     $('.habit-id' + show_id).fadeIn(200);
  });
   
   $('.close-modal').click(function() {
       $('.habit-modal').fadeOut(200);
   });
   
});
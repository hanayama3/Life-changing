// $(function() {
//     setTimeout("$('.complete-content').fadeOut('slow')", 1000) 
// });
// 消えた！！

// $(function(){
//   $('.complete-content').click(function(){
//     $('#check').slideUp();
//   });
// });

// 無理か

// $(function() {
 
//   $('input[name="user[habit_ids][]"]').change(function() {
 
//     var habit_ids = [];
 
//     $('input[name="user[habit_ids][]"]:checked').each(function() {
 
//       habit_ids.push($(this).val());
 
//     });
 
//     $('#p01').text('達成！');
 
//   });
// });
// １つの要素だけチェックしたら達成！が現れる
// 全てにチェックって欲しいな

// $(function() {
 
//   //チェックボックスにチェックが入ったら
//   $('input[name="user[habit_ids][]"]').change(function() {
 
//     //ボタンのdisabledを解除する
//     $('.btn').prop('disabled', true);
 
//   });
// });
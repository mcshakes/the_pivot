$(document).ready(function(){
  $('.category-btn').bind('click', function(){
    var category = $(this).attr('id')
    $("div.vendor-items").hide()
    $("div." + category).toggle()
  });

  $("#show-all").bind("click", function(){
    $("div.vendor-items").show()
  });
});

$( document ).ready(function() {
  $("a[data-target='#modal']").on('click', function(ev) {
    ev.preventDefault();
    var target = $(this).attr("href");

    $("#modal .modal-body").load(target, function() { 
      $("#modal").modal("show"); 
    });
  });
});

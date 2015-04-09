$( document ).ready(function() {
   $('#modal').on('shown.bs.modal', function() {
    $('#favorite').on('click', function(e) {
      e.preventDefault();
      $.ajax({
        url: $(this).attr('favorite_path'),
        type: 'POST',
        data: {user_id: $(this).attr('user_id'), item_id: $(this).attr('item_id')},
        success: function(data, status, jq) {
          // alert('Yay!!');
          // close the modal
          // display message
        },
        error: function(xhr, status, err) { 
          // status
          // err
        }
      });
    });
   });
});

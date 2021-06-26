# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->

  $('#new_info').click () ->
    $.ajax({
      url: '/infos/ajax',
      data:{
        focus_field: 'info_create',
      },
      type: "POST",
      success: (data) ->
        console.log("Successful");
      failure: () ->
        console.log("Unsuccessful");

    })
  $('#edit_info').click () ->
    $('#info-edit-modal').modal('show')

  $(document).bind('ajaxError', 'form#new_info', (event, jqxhr, settings, exception) ->
    $(event.data).render_form_errors( $.parseJSON(jqxhr.responseText) );
  )

  $.fn.render_form_errors = (errors) ->
    $form = this;
    this.clear_previous_errors();
    model = this.data('model');


    $.each(errors, (field, messages) ->
      $input = $('input[name="' + model + '[' + field + ']"]');
      $input.closest('.form-group').addClass('has-error').find('.help-block').html( messages.join(' & ') );
    );


  $.fn.clear_previous_errors = () ->
    $('.form-group.has-error', this).each( () ->
      $('.help-block', $(this)).html('');
      $(this).removeClass('has-error');
    );

  $(document).on('click', '.destroy-info', (e) ->
    info_id = $(this).attr('id')
    $.ajax({
      url: '/infos/ajax',
      data:{
        focus_field: 'info_削除する',
        info_id: info_id
      },
      type: "POST",
      success: (data) ->
#        swal("削除されました!", "", "success");
        $('#info'+info_id).remove();
      failure: () ->
        console.log("info_削除する keydown Unsuccessful")
    })

  )

  $(document).on('click', '.destroy-info-forbackup', (e) ->
    info_id = $(this).attr('id')
    swal({
      title: $('#message_confirm_delete').text(),
      text: "",
      type: "warning",
#      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "OK",
#      cancelButtonText: "キャンセル",
#      closeOnConfirm: false,
#      closeOnCancel: false
    }).then(
      () ->
        $.ajax({
          url: '/infos/ajax',
          data:{
            focus_field: 'info_削除する',
            info_id: info_id
          },
          type: "POST",
          success: (data) ->
            swal("削除されました!", "", "success");
            $('#info'+info_id).remove();
          failure: () ->
            console.log("info_削除する keydown Unsuccessful")
        })
    )
  )

  $(document).on('click', '.change-status', (e) ->

    info_id = $(this).attr('info-id')

    $.ajax({
      url: '/infos/ajax',
      data:{
        focus_field: 'change_status',
        info_id: info_id
      },

      type: "POST",

      success: (data) ->
        console.log("Successful")
      failure: () ->
        console.log("Unsuccessful")

    })

  )

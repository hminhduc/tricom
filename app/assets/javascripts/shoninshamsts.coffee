# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $.fn.dataTable.ext.buttons.import =
  className: 'buttons-import'
  action: (e, dt, node, config) ->
    $('#import-csv-modal').modal('show')
  oTable = $('.shonin-table').DataTable({
    "dom": "<'row'<'col-md-6'l><'col-md-6'f>><'row'<'col-md-7'B><'col-md-5'p>><'row'<'col-md-12'tr>><'row'<'col-md-12'i>>",
    "fnDrawCallback": (oSettings) ->
      $('.new-btn').appendTo($('.dt-buttons'));
      $('.edit-btn').appendTo($('.dt-buttons'));
      $('.delete-btn').appendTo($('.dt-buttons'));
    "pagingType": "full_numbers",
    "oLanguage":{
      "sUrl": "../../assets/resource/dataTable_"+$('#language').text()+".txt"
    },
    "columnDefs": [{
                "targets": [ 0 ],
                "visible": false,
                "searchable": false
    }]
    ,"oSearch": {"sSearch": queryParameters().search},
    "buttons": [{
                "extend":    'copyHtml5',
                "text":      '<i class="fa fa-files-o"></i>',
                "titleAttr": 'Copy'
            },
            {
                "extend":    'excelHtml5',
                "text":      '<i class="fa fa-file-excel-o"></i>',
                "titleAttr": 'Excel'
            },
            {
                "extend":    'csvHtml5',
                "text":      '<i class="fa fa-file-text-o"></i>',
                "titleAttr": 'CSV'
            },
            {
                "extend":    'import',
                "text":      '<i class="glyphicon glyphicon-import"></i>',
                "titleAttr": 'Import'
            },
            {
              "extend": 'selectAll',
              "action": ( e, dt, node, config ) ->
                oTable.$('tr').addClass('selected')
                oTable.$('tr').addClass('success')
                selects = oTable.rows('tr.selected').data()
                if selects.length == 0
                  $("#edit_shonin").addClass("disabled");
                  $("#destroy_shonin").addClass("disabled");
                else
                  $("#destroy_shonin").removeClass("disabled");
                  if selects.length == 1
                    $("#edit_shonin").removeClass("disabled");
                  else
                    $("#edit_shonin").addClass("disabled");
                $(".buttons-select-none").removeClass('disabled')




            },
            {
              "extend": 'selectNone',
              "action": ( e, dt, node, config ) ->
                oTable.$('tr').removeClass('selected')
                oTable.$('tr').removeClass('success')
                selects = oTable.rows('tr.selected').data()
                if selects.length == 0
                  $("#edit_shonin").addClass("disabled");
                  $("#destroy_shonin").addClass("disabled");
                else
                  $("#destroy_shonin").removeClass("disabled");
                  if selects.length == 1
                    $("#edit_shonin").removeClass("disabled");
                  else
                    $("#edit_shonin").addClass("disabled");
                $(".buttons-select-none").addClass('disabled')
            }
            ]
  })

  $("#edit_shonin").addClass("disabled");
  $("#destroy_shonin").addClass("disabled");

  $(document).bind('ajaxError', 'form#new_shoninshamst', (event, jqxhr, settings, exception) ->
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
  $('.shonin-table').on( 'click', 'tr',  () ->
    d = oTable.row(this).data()
    if d != undefined
      if $(this).hasClass('selected')
        $(this).removeClass('selected')
        $(this).removeClass('success')
        # $("#edit_shonin").addClass("disabled");
        # $("#destroy_shonin").addClass("disabled");
      else
        # oTable.$('tr.selected').removeClass('selected')
        # oTable.$('tr.success').removeClass('success')
        $(this).addClass('selected')
        $(this).addClass('success')
        # $("#edit_shonin").removeClass("disabled");
        # $("#destroy_shonin").removeClass("disabled");
    selects = oTable.rows('tr.selected').data()
    if selects.length == 0
      $("#edit_shonin").addClass("disabled");
      $("#destroy_shonin").addClass("disabled");
      $(".buttons-select-none").addClass('disabled')
    else
      $("#destroy_shonin").removeClass("disabled");
      $(".buttons-select-none").removeClass('disabled')
      if selects.length == 1
        $("#edit_shonin").removeClass("disabled");
      else
        $("#edit_shonin").addClass("disabled");
  )

  $('#destroy_shonin').click () ->
    shonins = oTable.rows('tr.selected').data()
    shoninIds = new Array();
    if shonins.length == 0
      swal($('#message_confirm_select').text())
    else

      swal({
        title: $('#message_confirm_delete').text(),
        text: "",
        type: "warning",
        showCancelButton: true,
        confirmButtonColor: "#DD6B55",
        confirmButtonText: "OK",
        cancelButtonText: "キャンセル",
        closeOnConfirm: false,
        closeOnCancel: false
      }).then(() ->
        len = shonins.length
        for i in [0...len]
          shoninIds[i] = shonins[i][0]

        $.ajax({
          url: '/shoninshamsts/ajax',
          data:{
            focus_field: 'shonin_削除する',
            shonins: shoninIds
          },

          type: "POST",

          success: (data) ->
            swal("削除されました!", "", "success");
            if data.destroy_success != null
              console.log("getAjax destroy_success:"+ data.destroy_success)
              oTable.rows('tr.selected').remove().draw()

            else
              console.log("getAjax destroy_success:"+ data.destroy_success)


          failure: () ->
            console.log("shonin_削除する keydown Unsuccessful")

        })
        $("#edit_shonin").addClass("disabled");
        $("#destroy_shonin").addClass("disabled");

      ,(dismiss) ->
        if dismiss == 'cancel'

          selects = oTable.rows('tr.selected').data()
          if selects.length == 0
            $("#edit_shonin").addClass("disabled");
            $("#destroy_shonin").addClass("disabled");
          else
            $("#destroy_shonin").removeClass("disabled");
            if selects.length == 1
              $("#edit_shonin").removeClass("disabled");
            else
              $("#edit_shonin").addClass("disabled");
      );

  $('#new_shonin').click () ->
    $('#shoninsha-new-modal').modal('show')
    $('#shoninshamst_申請者').val('')
    $('#shoninshamst_承認者').val('')
    $('#shoninshamst_順番').val('')
    $('.form-group.has-error').each( () ->
      $('.help-block', $(this)).html('');
      $(this).removeClass('has-error');
    );

  $('#edit_shonin').click () ->
    shonin_id = oTable.row('tr.selected').data()
    window.location = '/shoninshamsts/' + shonin_id[0] + '/edit?'

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->

  $.fn.dataTable.ext.buttons.import =
  className: 'buttons-import'
  action: (e, dt, node, config) ->
    $('#import-csv-modal').modal('show')
    
  oEkiTable = $('.ekitable').DataTable({
    "dom": "<'row'<'col-md-6'l><'col-md-6'f>><'row'<'col-md-7'B><'col-md-5'p>><'row'<'col-md-12'tr>><'row'<'col-md-12'i>>",
    "fnDrawCallback": (oSettings) ->
      $('.new-btn').appendTo($('.dt-buttons'));
      $('.edit-btn').appendTo($('.dt-buttons'));
      $('.delete-btn').appendTo($('.dt-buttons'));
    "pagingType": "simple_numbers"
    ,"oLanguage":{
      "sUrl": "../../assets/resource/dataTable_"+$('#language').text()+".txt"
    }
    ,
    "columnDefs": [ {
      "targets"  : 'no-sort',
      "orderable": false
    }],
    "oSearch": {"sSearch": queryParameters().search},

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
                oEkiTable.$('tr').addClass('selected')
                oEkiTable.$('tr').addClass('success')
                selects = oEkiTable.rows('tr.selected').data()
                if selects.length == 0
                  $("#edit_eki").addClass("disabled");
                  $("#destroy_eki").addClass("disabled");
                else
                  $("#destroy_eki").removeClass("disabled");
                  if selects.length == 1
                    $("#edit_eki").removeClass("disabled");
                  else
                    $("#edit_eki").addClass("disabled");
                $(".buttons-select-none").removeClass('disabled')




            },
            {
              "extend": 'selectNone',
              "action": ( e, dt, node, config ) ->
                oEkiTable.$('tr').removeClass('selected')
                oEkiTable.$('tr').removeClass('success')
                selects = oEkiTable.rows('tr.selected').data()
                if selects.length == 0
                  $("#edit_eki").addClass("disabled");
                  $("#destroy_eki").addClass("disabled");
                else
                  $("#destroy_eki").removeClass("disabled");
                  if selects.length == 1
                    $("#edit_eki").removeClass("disabled");
                  else
                    $("#edit_eki").addClass("disabled");
                $(".buttons-select-none").addClass('disabled')
            }

            ]
  })

  $("#edit_eki").addClass("disabled");
  $("#destroy_eki").addClass("disabled");


  $(document).bind('ajaxError', 'form#new_eki', (event, jqxhr, settings, exception) ->
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


  $('.ekitable').on( 'click', 'tr',  () ->
    d = oEkiTable.row(this).data()
    if d != undefined
      if $(this).hasClass('selected')
        $(this).removeClass('selected')
        $(this).removeClass('success')
        # $("#edit_eki").addClass("disabled");
        # $("#destroy_eki").addClass("disabled");
      else
        # oEkiTable.$('tr.selected').removeClass('selected')
        # oEkiTable.$('tr.success').removeClass('success')
        $(this).addClass('selected')
        $(this).addClass('success')
        # $("#edit_eki").removeClass("disabled");
        # $("#destroy_eki").removeClass("disabled");
    selects = oEkiTable.rows('tr.selected').data()
    if selects.length == 0
      $("#edit_eki").addClass("disabled");
      $("#destroy_eki").addClass("disabled");
      $(".buttons-select-none").addClass('disabled')
    else
      $("#destroy_eki").removeClass("disabled");
      $(".buttons-select-none").removeClass('disabled')
      if selects.length == 1
        $("#edit_eki").removeClass("disabled");
      else
        $("#edit_eki").addClass("disabled");

  )

  $('#destroy_eki').click () ->
    ekis = oEkiTable.rows('tr.selected').data()
    ekiIds = new Array();
    if ekis.length == 0
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
        len = ekis.length
        for i in [0...len]
          ekiIds[i] = ekis[i][0]

        $.ajax({
          url: '/ekis/ajax',
          data:{
            focus_field: 'eki_削除する',
            ekis: ekiIds
          },

          type: "POST",

          success: (data) ->
            swal("削除されました!", "", "success");
            if data.destroy_success != null
              console.log("getAjax destroy_success:"+ data.destroy_success)
              oEkiTable.rows('tr.selected').remove().draw()
            else
              console.log("getAjax destroy_success:"+ data.destroy_success)


          failure: () ->
            console.log("eki_削除する keydown Unsuccessful")

        })
        $("#edit_eki").addClass("disabled");
        $("#destroy_eki").addClass("disabled");

      ,(dismiss) ->
        if dismiss == 'cancel'

          selects = oEkiTable.rows('tr.selected').data()
          if selects.length == 0
            $("#edit_eki").addClass("disabled");
            $("#destroy_eki").addClass("disabled");
          else
            $("#destroy_eki").removeClass("disabled");
            if selects.length == 1
              $("#edit_eki").removeClass("disabled");
            else
              $("#edit_eki").addClass("disabled");
      );
  $('#new_eki').click () ->
    $('#eki-new-modal').modal('show')
    $('#eki_駅コード').val('')
    $('#eki_駅名').val('')
    $('#eki_駅名カナ').val('')
    $('.form-group.has-error').each( () ->
      $('.help-block', $(this)).html('');
      $(this).removeClass('has-error');
    );

  $('#edit_eki').click () ->
    eki_id = oEkiTable.row('tr.selected').data()
    $('.form-group.has-error').each( () ->
      $('.help-block', $(this)).html('');
      $(this).removeClass('has-error');
    );
    if eki_id == undefined
      swal("行を選択してください。")
    else
      $('#eki-edit-modal').modal('show')
      $('#eki_駅コード').val(eki_id[0])
      $('#eki_駅名').val(eki_id[1])
      $('#eki_駅名カナ').val(eki_id[2])

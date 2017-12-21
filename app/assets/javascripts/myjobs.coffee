jQuery ->
  $.fn.dataTable.ext.buttons.import =
  className: 'buttons-import'
  action: (e, dt, node, config) ->
    $('#import-csv-modal').modal('show')
  oTable = $('#myjobmaster').DataTable({
    "dom": "<'row'<'col-md-6'l><'col-md-6'f>><'row'<'col-md-7'B><'col-md-5'p>><'row'<'col-md-12'tr>><'row'<'col-md-12'i>>",
    "scrollX": true,
    "fnDrawCallback": (oSettings) ->
      $('.new-btn').appendTo($('.dt-buttons'));
      $('.edit-btn').appendTo($('.dt-buttons'));
      $('.delete-btn').appendTo($('.dt-buttons'));
#    'scrollY': "300px",
    "pagingType": "full_numbers",
    "oLanguage": {
      "sUrl": "../../assets/resource/dataTable_"+$('#language').text()+".txt"
    },
    "aoColumnDefs": [
      { "bSortable": false, "aTargets": [ 12,13]},
      {
        "targets": [12,13],
        "width": '5%'
      },
      {"aTargets": [3,4], "mRender":  (data, type, full) ->
        time_format = moment(data, 'YYYY/MM/DD').format('YYYY/MM/DD')
        if  time_format != 'Invalid date'
          return time_format;
        else
          return '';
      },
      {"aTargets": [11], "mRender":  (data, type, full) ->
        time_format = moment(data, 'YYYY/MM/DD HH:mm:ss').format('YYYY/MM/DD HH:mm:ss')
        if  time_format != 'Invalid date'
          return time_format;
        else
          return '';
      }
    ],
    "columnDefs": [{
      "targets"  : 'no-sort',
      "orderable": false
    }],
    'scrollCollapse': true,
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
                  $("#edit_myjob").addClass("disabled");
                  $("#destroy_myjob").addClass("disabled");
                else
                  $("#destroy_myjob").removeClass("disabled");
                  if selects.length == 1
                    $("#edit_myjob").removeClass("disabled");
                  else
                    $("#edit_myjob").addClass("disabled");
                $(".buttons-select-none").removeClass('disabled')




            },
            {
              "extend": 'selectNone',
              "action": ( e, dt, node, config ) ->
                oTable.$('tr').removeClass('selected')
                oTable.$('tr').removeClass('success')
                selects = oTable.rows('tr.selected').data()
                if selects.length == 0
                  $("#edit_myjob").addClass("disabled");
                  $("#destroy_myjob").addClass("disabled");
                else
                  $("#destroy_myjob").removeClass("disabled");
                  if selects.length == 1
                    $("#edit_myjob").removeClass("disabled");
                  else
                    $("#edit_myjob").addClass("disabled");
                $(".buttons-select-none").addClass('disabled')
            }
            ]
#    'fixedColumns': {
#      'leftColumns': 0,
#      'rightColumns': 2,
#      'heightMatch': 'none'
#    }
  })

  oKaisha_modal = $('#kaisha-table-modal').DataTable({
    "pagingType": "full_numbers"
    , "oLanguage": {
      "sUrl": "../../assets/resource/dataTable_"+$('#language').text()+".txt"
    }
  })

  oShain_modal = $('#user_table').DataTable({
    "pagingType": "full_numbers"
    , "oLanguage": {
      "sUrl": "../../assets/resource/dataTable_"+$('#language').text()+".txt"
    }
  })

  oJob_modal = $('#job_table').DataTable({
    "pagingType": "full_numbers"
    , "oLanguage": {
      "sUrl": "../../assets/resource/dataTable_"+$('#language').text()+".txt"
    }
  })

  oBunrui_modal = $('.bunrui-table').DataTable({
    "pagingType": "full_numbers"
    , "oLanguage": {
      "sUrl": "../../assets/resource/dataTable_"+$('#language').text()+".txt"
    }
  })

  $('#kaisha-table-modal tbody').on( 'click', 'tr',  () ->

    if $(this).hasClass('selected')
      $(this).removeClass('selected')
      $(this).removeClass('success')
    else
      oKaisha_modal.$('tr.selected').removeClass('selected')
      oKaisha_modal.$('tr.success').removeClass('success')
      $(this).addClass('selected')
      $(this).addClass('success')
   )

  $('#user_table tbody').on( 'click', 'tr',  () ->

    if $(this).hasClass('selected')
      $(this).removeClass('selected')
      $(this).removeClass('success')
    else
      oShain_modal.$('tr.selected').removeClass('selected')
      oShain_modal.$('tr.success').removeClass('success')
      $(this).addClass('selected')
      $(this).addClass('success')
  )

  $('#job_table tbody').on( 'click', 'tr',  () ->

    if $(this).hasClass('selected')
      $(this).removeClass('selected')
      $(this).removeClass('success')
    else
      oJob_modal.$('tr.selected').removeClass('selected')
      oJob_modal.$('tr.success').removeClass('success')
      $(this).addClass('selected')
      $(this).addClass('success')
  )

  $('.bunrui-table tbody').on( 'click', 'tr',  () ->
    d = oBunrui_modal.row(this).data()
    $('#myjobmaster_分類コード').val(d[0])
    $('#myjobmaster_分類名').val(d[1])

    #    remove error if has
    $('#myjobmaster_分類コード').closest('.form-group').find('span.help-block').remove()
    $('#myjobmaster_分類コード').closest('.form-group').removeClass('has-error')

    if $(this).hasClass('selected')
      $(this).removeClass('selected')
      $(this).removeClass('success')
    else
      oBunrui_modal.$('tr.selected').removeClass('selected')
      oBunrui_modal.$('tr.success').removeClass('success')
      $(this).addClass('selected')
      $(this).addClass('success')
  )


#  $('.start-date').click( () ->
#    $('#myjobmaster_開始日').data("DateTimePicker").toggle()
#  )
#
#  $('.end-date').click( () ->
#    $('#myjobmaster_終了日').data("DateTimePicker").toggle()
#  )

#  $('.calendar-span').click( () ->
#    $('#myjobmaster_開始日').data("DateTimePicker").toggle()
##    element1 = $('.date').find($('#myjobmaster_開始日'))
##    element2 = $('.date').find($('#myjobmaster_終了日'))
##
##    if $(this).prev().is(element1)
##      $('#myjobmaster_開始日').data("DateTimePicker").toggle()
##
##    if $(this).prev().is(element2)
##      $('#myjobmaster_終了日').data("DateTimePicker").toggle()
#  )

  $('.date').datetimepicker({
    format: 'YYYY/MM/DD',
    widgetPositioning: {
      horizontal: 'left',
      vertical: 'bottom'
    }
    showTodayButton: true,
    showClear: true,
#    //,daysOfWeekDisabled:[0,6]
#    calendarWeeks: true,
    keyBinds: false,
    focusOnShow: false
  })

#  $('#myjobmaster_開始日').datetimepicker({
#    format: 'YYYY/MM/DD',
#    widgetPositioning: {
#      horizontal: 'left',
#      vertical: 'bottom'
#    }
#    showTodayButton: true,
#    showClear: true,
##    //,daysOfWeekDisabled:[0,6]
#    calendarWeeks: true,
#    keyBinds: false,
#    focusOnShow: false
#  })
#
#  $('#myjobmaster_終了日').datetimepicker({
#    format: 'YYYY/MM/DD',
#    widgetPositioning: {
#      horizontal: 'left',
#      vertical: 'bottom'
#    }
#    showTodayButton: true,
#    showClear: true,
##    //,daysOfWeekDisabled:[0,6]
#    calendarWeeks: true,
#    keyBinds: false,
#    focusOnShow: false
#  })
#
#  $("#myjobmaster_開始日").on("dp.change", (e) ->
#    $('#myjobmaster_終了日').data("DateTimePicker").minDate(e.date)
#    e.preventDefault()
#  )
#
#  $("#myjobmaster_終了日").on("dp.change", (e) ->
#    $('#myjobmaster_開始日').data("DateTimePicker").maxDate(e.date);
#    e.preventDefault()
#  )

  $('.search-field').click( () ->
    element1 = $('.search-group').find('#myjobmaster_ユーザ番号')
    element2 = $('.search-group').find('#myjobmaster_入力社員番号')
    element3 = $('.search-group').find('#myjobmaster_関連Job番号')

    if $(this).prev().is(element1)
      $('#kaisha-search-modal').modal('show')

    if $(this).prev().is(element2)
      $('#select_user_modal_refer').modal('show')

    if $(this).prev().is(element3)
      $('#job_search_modal').modal('show')
  )

#  $('.refer-kaisha').click( () ->
#    $('#kaisha-search-modal').modal('show')
#  )
#
#  $('.refer-shain').click( () ->
#    $('#select_user_modal').modal('show')
#  )
#
#  $('.refer-job').click( () ->
#    $('#job_search_modal').modal('show')
#  )

#  $('.refer-bunrui').click( () ->
#    $('#bunrui_search_modal').modal('show')
#  )

  $('#myjobmaster_ユーザ番号').keydown( (e) ->
    if (e.keyCode == 9 && !e.shiftKey)
      kaisha_code = $('#myjobmaster_ユーザ番号').val()
      jQuery.ajax({
        url: '/myjobmasters/ajax',
        data: {focus_field: 'myjobmaster_ユーザ番号', kaisha_code: kaisha_code},
        type: "POST",
      success: (data) ->
#        $('#kaisha-name').text(data.kaisha_name)
        $('#myjobmaster_ユーザ名').val(data.kaisha_name)
        console.log("getAjax myjobmaster_ユーザ番号:"+ data.kaisha_name)
      ,
      failure: () ->
        console.log("myjobmaster_ユーザ番号 keydown Unsuccessful")
      })
  )

  $(document).bind('ajaxError', 'form#new_myjobmaster', (event, jqxhr, settings, exception) ->
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
  $("#edit_myjob").addClass("disabled");
  $("#destroy_myjob").addClass("disabled");
  $('#myjobmaster').on( 'click', 'tr',  () ->
    d = oTable.row(this).data()
    if d != undefined
      if $(this).hasClass('selected')
        $(this).removeClass('selected')
        $(this).removeClass('success')
        # $("#edit_myjob").addClass("disabled");
        # $("#destroy_myjob").addClass("disabled");
      else
        # oTable.$('tr.selected').removeClass('selected')
        # oTable.$('tr.success').removeClass('success')
        $(this).addClass('selected')
        $(this).addClass('success')
        # $("#edit_myjob").removeClass("disabled");
        # $("#destroy_myjob").removeClass("disabled");
    selects = oTable.rows('tr.selected').data()
    if selects.length == 0
      $("#edit_myjob").addClass("disabled");
      $("#destroy_myjob").addClass("disabled");
      $(".buttons-select-none").addClass('disabled')
    else
      $("#destroy_myjob").removeClass("disabled");
      $(".buttons-select-none").removeClass('disabled')
      if selects.length == 1
        $("#edit_myjob").removeClass("disabled");
      else
        $("#edit_myjob").addClass("disabled");
  )

#  $('#myjobmaster_分類コード').on('change', () ->
#    switch $(this).val()
#      when '1'
#        $('#myjobmaster_分類名').val('営業活動')
#      when '2'
#        $('#myjobmaster_分類名').val('開発マスタ')
#      when '3'
#        $('#myjobmaster_分類名').val('保守')
#      when '4'
#        $('#myjobmaster_分類名').val('社内業務')
#  )

  $('#job_sentaku_ok').click ->
    d = oJob_modal.row('tr.selected').data()
    if d != undefined
      $('#myjobmaster_関連Job番号').val(d[0])
      $('.hint-job-refer').text(d[1])
      $('#myjobmaster_関連Job番号').closest('.form-group').find('span.help-block').remove()
      $('#myjobmaster_関連Job番号').closest('.form-group').removeClass('has-error')

  $('#user_refer_sentaku_ok').click ->
    d = oShain_modal.row('tr.selected').data()
    if d != undefined
      $('#myjobmaster_入力社員番号').val(d[0])
      $('.hint-shain-refer').text(d[1])
      $('#myjobmaster_入力社員番号').closest('.form-group').find('span.help-block').remove()
      $('#myjobmaster_入力社員番号').closest('.form-group').removeClass('has-error')



  $('#kaisha_sentaku_ok').click ->
    d = oKaisha_modal.row('tr.selected').data()
    if d != undefined
      $('#myjobmaster_ユーザ番号').val(d[0])
      $('#myjobmaster_ユーザ名').val(d[1])
      $('#myjobmaster_ユーザ番号').closest('.form-group').find('span.help-block').remove()
      $('#myjobmaster_ユーザ番号').closest('.form-group').removeClass('has-error')

  $('#kaisha-table-modal tbody').on( 'dblclick', 'tr',  () ->
    $(this).addClass('selected')
    $(this).addClass('success')
    d = oKaisha_modal.row('tr.selected').data()
    if d != undefined
      $('#myjobmaster_ユーザ番号').val(d[0])
      $('#myjobmaster_ユーザ名').val(d[1])
      $('#myjobmaster_ユーザ番号').closest('.form-group').find('span.help-block').remove()
      $('#myjobmaster_ユーザ番号').closest('.form-group').removeClass('has-error')
    $('#kaisha-search-modal').modal('hide')
  )

  $('#user_table tbody').on( 'dblclick', 'tr',  () ->
    $(this).addClass('selected')
    $(this).addClass('success')
    d = oShain_modal.row('tr.selected').data()
    if d != undefined
      $('#myjobmaster_入力社員番号').val(d[0])
      $('.hint-shain-refer').text(d[1])
      $('#myjobmaster_入力社員番号').closest('.form-group').find('span.help-block').remove()
      $('#myjobmaster_入力社員番号').closest('.form-group').removeClass('has-error')
    $('#select_user_modal_refer').modal('hide')
  )

  $('#job_table tbody').on( 'dblclick', 'tr',  () ->
    $(this).addClass('selected')
    $(this).addClass('success')
    d = oJob_modal.row('tr.selected').data()
    if d != undefined
      $('#myjobmaster_関連Job番号').val(d[0])
      $('.hint-job-refer').text(d[1])
      $('#myjobmaster_関連Job番号').closest('.form-group').find('span.help-block').remove()
      $('#myjobmaster_関連Job番号').closest('.form-group').removeClass('has-error')
    $('#job_search_modal').modal('hide')
  )  

  $('#destroy_myjob').click () ->
    myjobs = oTable.rows('tr.selected').data()
    myjobIds = new Array();
    if myjobs.length == 0
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
        len = myjobs.length
        for i in [0...len]
          myjobIds[i] = myjobs[i][12].split('/')[2]

        $.ajax({
          url: '/myjobmasters/ajax',
          data:{
            focus_field: 'myjob_削除する',
            myjobs: myjobIds
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
            console.log("myjob_削除する keydown Unsuccessful")

        })
        $("#edit_myjob").addClass("disabled");
        $("#destroy_myjob").addClass("disabled");

      ,(dismiss) ->
        if dismiss == 'cancel'

          selects = oTable.rows('tr.selected').data()
          if selects.length == 0
            $("#edit_myjob").addClass("disabled");
            $("#destroy_myjob").addClass("disabled");
          else
            $("#destroy_myjob").removeClass("disabled");
            if selects.length == 1
              $("#edit_myjob").removeClass("disabled");
            else
              $("#edit_myjob").addClass("disabled");
      );
  $('#edit_myjob').click ->
    new_address = oTable.row('tr.selected').data()[12].split("\"")[1]
    if new_address == undefined
      swal("行を選択してください。")
    else
      window.location = new_address

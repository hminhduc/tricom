jQuery ->
  create_datatable
    table_id: '#jobuchiwakemaster'
    new_modal_id: '#jobuchiwake-new-modal'
    edit_modal_id: '#jobuchiwake-edit-modal'
    delete_path: '/jobuchiwakes/id'
    search_params: queryParameters().search
    invisible_columns: 0
    no_search_columns: [0, 6]
    no_sort_columns: 6
    order_columns: ['1', 'asc']
    get_id_from_row_data: (data)->
      return data[0]

  $('#jobuchiwake-new-modal').on 'show', ()->
    $(this).modal('show')
    $('#jobuchiwake_ジョブ番号').val('')
    $('#jobuchiwake_ジョブ内訳番号').val('')
    $('#jobuchiwake_受付日時').val('')
    $('#jobuchiwake_件名').val('')
    $('#jobuchiwake_受付種別').val('')
    $('.form-group.has-error').each ()->
      $('.help-block', $(this)).html('')
      $(this).removeClass('has-error')

  $('#jobuchiwake-edit-modal').on 'show', (e, selected_row_data)->
    $(this).modal('show')
    $('#jobuchiwake_ジョブ番号').val(selected_row_data[1])
    $('#jobuchiwake_ジョブ内訳番号').val(selected_row_data[2])
    $('#jobuchiwake_受付日時').val(selected_row_data[3])
    $('#jobuchiwake_件名').val(selected_row_data[4])
    $('#jobuchiwake_受付種別').val(selected_row_data[5].split(' : ')[0])
    $('.form-group.has-error').each ()->
      $('.help-block', $(this)).html('')
      $(this).removeClass('has-error')

  $('.datetime').datetimepicker
    format: 'YYYY/MM/DD HH:mm'
    showTodayButton: true
    showClear: true
    sideBySide: true
    toolbarPlacement: 'top'
    keyBinds: false
    focusOnShow: false
  $('#jobuchiwake-new-modal #jobuchiwake_受付日時').click ()->
    $('#jobuchiwake-new-modal .datetime').data('DateTimePicker').toggle()
  $('#jobuchiwake-edit-modal #jobuchiwake_受付日時').click ()->
    $('#jobuchiwake-edit-modal .datetime').data('DateTimePicker').toggle()

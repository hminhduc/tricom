jQuery ->
  create_datatable
    table_id: '#yakushokumaster'
    new_modal_id: '#yakushokumaster-new-modal'
    edit_modal_id: '#yakushokumaster-edit-modal'
    delete_path: '/yakushokumasters/id'
    no_sort_columns: [2]
    search_params: queryParameters().search
    get_id_from_row_data: (data)->
      return data[0]

  $('#yakushokumaster-new-modal').on 'show', ()->
    $(this).modal('show')
    $('#yakushokumaster_役職コード').val('')
    $('#yakushokumaster_役職名').val('')
    $('.form-group.has-error').each ()->
      $('.help-block', $(this)).html('')
      $(this).removeClass('has-error')

  $('#yakushokumaster-edit-modal').on 'show', (e, selected_row_data)->
    $(this).modal('show')
    $('#yakushokumaster_役職コード').val(selected_row_data[0])
    $('#yakushokumaster_役職名').val(selected_row_data[1])
    $('.form-group.has-error').each ()->
      $('.help-block', $(this)).html('')
      $(this).removeClass('has-error')

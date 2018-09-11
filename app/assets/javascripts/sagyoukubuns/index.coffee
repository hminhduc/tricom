jQuery ->
  create_datatable
    table_id: '#sagyoukubun'
    new_modal_id: '#sagyoukubun-new-modal'
    edit_modal_id: '#sagyoukubun-edit-modal'
    delete_path: '/sagyoukubuns/id'
    search_params: queryParameters().search
    invisible_columns: 0
    no_search_columns: [0, 3]
    no_sort_columns: [3, 4]
    get_id_from_row_data: (data)->
      return data[0]

  $('#sagyoukubun-new-modal').on 'show', ()->
    $(this).modal('show')
    $('#sagyoukubun_作業区分').val('')
    $('#sagyoukubun_作業区分名称').val('')
    $('.form-group.has-error').each ()->
      $('.help-block', $(this)).html('')
      $(this).removeClass('has-error')

  $('#sagyoukubun-edit-modal').on 'show', (e, selected_row_data)->
    $(this).modal('show')
    $('#sagyoukubun_作業区分').val(selected_row_data[1])
    $('#sagyoukubun_作業区分名称').val(selected_row_data[2])
    $('.form-group.has-error').each ()->
      $('.help-block', $(this)).html('')
      $(this).removeClass('has-error')

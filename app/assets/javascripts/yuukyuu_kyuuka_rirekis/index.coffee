jQuery ->
  create_datatable
    table_id: '#yuukyuu_kyuuka_rireki'
    new_path: 'yuukyuu_kyuuka_rirekis/new'
    edit_path: 'yuukyuu_kyuuka_rirekis/id/edit'
    delete_path: '/yuukyuu_kyuuka_rirekis/id'
    invisible_columns: [0]
    no_search_columns: [0]
    no_sort_columns: [6, 7]
    page_length: 100
    search_params: queryParameters().search
    get_id_from_row_data: (data)->
      return data[0]

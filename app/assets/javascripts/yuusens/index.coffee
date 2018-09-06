jQuery ->
  create_datatable
    table_id: '#yuusen'
    new_path: 'yuusens/new'
    edit_path: 'yuusens/id/edit'
    delete_path: '/yuusens/id'
    no_sort_columns: [3]
    search_params: queryParameters().search
    get_id_from_row_data: (data)->
      return data[0]

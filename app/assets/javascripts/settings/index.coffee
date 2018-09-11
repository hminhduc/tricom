jQuery ->
  create_datatable
    table_id: '#setting'
    new_path: 'settings/new'
    edit_path: 'settings/id/edit'
    delete_path: '/settings/id'
    no_sort_columns: [5, 6]
    search_params: queryParameters().search
    get_id_from_row_data: (data)->
      return data[0]

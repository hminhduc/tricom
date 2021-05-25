jQuery ->
  create_datatable
    table_id: '#hikiaijobmaster'
    new_path: 'hikiaijobmasters/new'
    edit_path: 'hikiaijobmasters/id/edit'
    delete_path: '/hikiaijobmasters/id'
    no_sort_columns: [9, 10]
    search_params: queryParameters().search
    get_id_from_row_data: (data)->
      return data[0]

jQuery ->
  create_sentaku_modal
    modal: $('#myjob_search_modal')
    table: $('#myjob_table')
    ok_button: $('#myjob_sentaku_ok')
    clear_button: $('#clear_myjob')
    trigger_name: 'choose_myjob'
    order_columns: [0, 'asc']
    invisible_columns: [4,6]
    no_search_columns: [4,6]
    page_length: 50

jQuery ->
  create_sentaku_modal
    modal: $('#job_search_modal')
    table: $('#job_table')
    ok_button: $('#job_sentaku_ok')
    clear_button: $('#clear_job')
    trigger_name: 'choose_job'
    invisible_columns: [4,5]
    no_search_columns: [4,5]
    page_length: 50

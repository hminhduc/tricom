jQuery ->  
  $('.date').datetimepicker
    format: 'YYYY/MM/DD'
    widgetPositioning:
      horizontal: 'left'
    showTodayButton: true
    showClear: true
    keyBinds: false
    focusOnShow: false

  $('#hikiaijobmaster_開始日').click () ->
    $('.hikiaijobmaster_開始日 > .form-inline > .date').data("DateTimePicker").toggle()

  $('#hikiaijobmaster_終了日').click ()->
    $('.hikiaijobmaster_終了日 > .form-inline > .date').data("DateTimePicker").toggle()
  
  $('.search-field').click ()->
    input = $(this).prev()
    switch input.attr('id')
      when 'hikiaijobmaster_ユーザ番号' then $('#kaisha-search-modal').trigger('show', [input.val()])
      when 'hikiaijobmaster_入力社員番号' then $('#select_user_modal_refer').trigger('show', [input.val()])

  setup_tab_render_name
    input: $('#hikiaijobmaster_ユーザ番号')
    output: $('#hikiaijobmaster_ユーザ名')
    table: $('#kaisha-table-modal')

  setup_tab_render_name
    input: $('#hikiaijobmaster_入力社員番号')
    output: $('.hint-shain-refer')
    table: $('#user_table')

  $('#kaisha-table-modal').on 'choose_kaisha', (e, selected_data)->
    if selected_data != undefined
      $('#hikiaijobmaster_ユーザ番号').val(selected_data[0])
      $('#hikiaijobmaster_ユーザ名').val(selected_data[1])
      $('#hikiaijobmaster_ユーザ番号').closest('.form-group').find('span.help-block').remove()
      $('#hikiaijobmaster_ユーザ番号').closest('.form-group').removeClass('has-error')

  $('#user_table').on 'choose_shain', (e, selected_data)->
    if selected_data != undefined
      $('#hikiaijobmaster_入力社員番号').val(selected_data[0])
      $('.hint-shain-refer').text(selected_data[1])
      $('#hikiaijobmaster_入力社員番号').closest('.form-group').find('span.help-block').remove()
      $('#hikiaijobmaster_入力社員番号').closest('.form-group').removeClass('has-error')

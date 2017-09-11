jQuery ->
  kousu = []
  countup = 0
  until countup > 1000
    kousu.push(countup)
    countup += 0.25

  $('#koushuu').click (event) ->
    start_time = $('#event_開始').val()
    end_time = $('#event_終了').val()
    #diff = moment(end_time,'YYYY/MM/DD HH:mm').diff(moment(start_time,'YYYY/MM/DD HH:mm'),'hours', true)
    #for num in kousu
    #  if num > diff && num > 0
    #    $('#event_工数').val(num-0.25)
    #    break
    if start_time!= '' && end_time!= ''
      jQuery.ajax({
        url: '/events/ajax',
        data: {id: 'get_kousuu', start_time: start_time, end_time: end_time},
        type: "POST",
        success: (data) ->
          if data.kousuu != ''
            $('#event_工数').val(data.kousuu)
        failure: () ->
          console.log("save-kinmu-type field")
      })
#  保留中 →
  $('.add-row').click () ->
    val = []
    val.push($('#basho-code').val())
    val.push($('#basho-name').val())

    jQuery.ajax({
      url: '/events/event_basho_add',
      data: {id: 'event_basho_add', data: val},
      type: "POST",
#    // processData: false,
#    // contentType: 'application/json',
      success: (data) ->
        oBashoTable.row.add(val).draw(false)
      ,failure: () ->
        console.log("場所 追加 失敗")
    })

#  $('#save_kinmu_type').click () ->
  $('#shainmaster_勤務タイプ').on('change', () ->
#    val = $('#shainmaster_勤務タイプ').val()
    val = $(this).val()
    jQuery.ajax({
      url: '/events/ajax',
      data: {id: 'save_kinmu_type', data: val},
      type: "POST",
      success: (data) ->
#        swal('勤務タイプ保存！')
      failure: () ->
        console.log("save-kinmu-type field")
    }))

  $('#shainmaster_所在コード').on('change', () ->
    val = $(this).val()
    jQuery.ajax({
      url: '/events/ajax',
      data: {id: 'change_shozai', data: val},
      type: "POST",
      success: (data) ->
        #location.reload()
      failure: () ->
        console.log("change_shozai field")
    }))

  $('#timeline_所在コード').on('change', () ->
    val = $(this).val()
    jQuery.ajax({
      url: '/events/ajax',
      data: {id: 'change_shozai_timeline', data: val},
      type: "POST",
      success: (data) ->
        $('.fc-resource-area tr[data-resource-id="'+data.resourceID+'"] td:nth-child(3) .fc-cell-content').css('color',data.color).css('background-color',data.bgColor);
        $('.fc-resource-area tr[data-resource-id="'+data.resourceID+'"] td:nth-child(3) .fc-cell-content>span').text(data.joutai);
      failure: () ->
        console.log("change_shozai field")
    }))

  $('#basho-new').click () ->
    $('#mybasho-new-modal').modal('show')

  $('#kaisha-new').click () ->
    $('#kaisha-new-modal').modal('show')

  $('.refer-kaisha').click () ->
    $('#kaisha-search-modal').modal('show')

  $('.datetime').datetimepicker({
    format: 'YYYY/MM/DD HH:mm',
    showTodayButton: true,
    showClear: true,
    sideBySide: true,
    calendarWeeks: true,
    toolbarPlacement: 'top',
    keyBinds: false,
    focusOnShow: false
#    defaultDate: '2016/03/14 09:00'
  })
  $("#999").appendTo(".form-group.search_history.optional.event_場所コード .form-inline");
  $('.search-field').click( () ->
    element1 = $('.search-group').find('#event_状態コード')
    element2 = $('.search-group').find('#event_場所コード')
    element3 = $('.search-group').find('#event_JOB')
    element4 = $('.search-group').find('#event_工程コード')
    element5 = $('.search-group').find('#mybashomaster_会社コード')

    if $(this).prev().is(element1)
      $('#joutai_search_modal').modal('show')
      if $('#event_状態コード').val() != ''
        oJoutaiTable.rows().every( ( rowIdx, tableLoop, rowLoop ) ->
          data = this.data();
          if data[0] == $('#event_状態コード').val()
            oJoutaiTable.$('tr.selected').removeClass('selected');
            oJoutaiTable.$('tr.success').removeClass('success');
            this.nodes().to$().addClass('selected')
            this.nodes().to$().addClass('success')
        );
        check_select = oJoutaiTable.rows('tr.selected').data();
        if check_select == undefined
          $("#edit_joutaimaster").addClass("disabled");
          $("#destroy_joutaimaster").addClass("disabled");
        else
          $("#edit_joutaimaster").removeClass("disabled");
          $("#destroy_joutaimaster").removeClass("disabled");
        oJoutaiTable.page.jumpToData($('#event_状態コード').val(), 0);

    if $(this).prev().is(element2)&&!$(element2).is(':disabled')
      $('#basho_search_modal').modal('show')
      if $('#event_場所コード').val() != ''
        oBashoTable.rows().every( ( rowIdx, tableLoop, rowLoop ) ->
          data = this.data();
          if data[0] == $('#event_場所コード').val()
            oBashoTable.$('tr.selected').removeClass('selected');
            oBashoTable.$('tr.success').removeClass('success');
            this.nodes().to$().addClass('selected')
            this.nodes().to$().addClass('success')
        );
        check_select = oBashoTable.rows('tr.selected').data();
        if check_select == undefined
          $("#edit_basho").addClass("disabled");
          $("#destroy_basho").addClass("disabled");
        else
          $("#edit_basho").removeClass("disabled");
          $("#destroy_basho").removeClass("disabled");
        oBashoTable.page.jumpToData($('#event_場所コード').val(), 0);

    if $(this).prev().is(element3)&&!$(element3).is(':disabled')
      $('#job_search_modal').modal('show')
      if $('#event_JOB').val() != ''
        oJobTable.rows().every( ( rowIdx, tableLoop, rowLoop ) ->
          data = this.data();
          if data[0] == $('#event_JOB').val()
            oJobTable.$('tr.selected').removeClass('selected');
            oJobTable.$('tr.success').removeClass('success');
            this.nodes().to$().addClass('selected')
            this.nodes().to$().addClass('success')
        );
        check_select = oJobTable.rows('tr.selected').data();
        if check_select == undefined
          $("#edit_jobmaster").addClass("disabled");
          $("#destroy_jobmaster").addClass("disabled");
        else
          $("#edit_jobmaster").removeClass("disabled");
          $("#destroy_jobmaster").removeClass("disabled");
        oJobTable.page.jumpToData($('#event_JOB').val(), 0);

    if $(this).prev().is(element4)
      $('#koutei_search_modal').modal('show')

    if $(this).prev().is(element5)
      $('#kaisha-search-modal').modal('show')
  )

  $('.search-history').click( () ->
    element1 = $('.search-group').find('#event_場所コード')
    element2 = $('.search-group').find('#event_JOB')
    if $(this).prev().prev().is(element1)&&!$(element1).is(':disabled')
      $('#mybasho_search_modal').modal('show')
      mybasho = oMybashoTable.row('tr.selected').data();
      if mybasho == undefined
        $("#mybasho_destroy").addClass("disabled");
      else
        $("#mybasho_destroy").removeClass("disabled");
    if $(this).prev().prev().is(element2)&&!$(element2).is(':disabled')
      $('#myjob_search_modal').modal('show')
      myjob = oMyjobTable.row('tr.selected').data();
      if myjob == undefined
        $("#myjob_destroy").addClass("disabled");
      else
        $("#myjob_destroy").removeClass("disabled");
  )

  $('#basho-new-ok').click( () ->
    basho_code = $('#mybashomaster_場所コード').val()
    if basho_code
      $('#event_場所コード').val(basho_code)
      $('.hint-basho-refer').text($('#mybashomaster_場所名').val())
  )
  currentDate = new Date();
  startOfWeek = moment().startOf('isoweek').format('YYYY/MM/DD');
  endOfWeek   = moment().endOf('isoweek').format('YYYY/MM/DD');
  $("#modal_date_start_input").val(startOfWeek);
  $("#modal_date_end_input").val(endOfWeek);
  $('.modal_date_start_select').datetimepicker({
    format: 'YYYY/MM/DD'
  });
  $('.modal_date_end_select').datetimepicker({
    format: 'YYYY/MM/DD'
  });
  $('#modal_print_event').click( () ->
    $('#print_modal').modal('show')
  )
  $('#modal_shousai_event').click( () ->
    $('#shousai_modal').modal('show')
  )
  $('#modal_pdf_event').click( () ->
    if !$(this).hasClass('active')
      $(this).addClass('active');
      $('#modal_pdf_event_job').removeClass('active');
      $('#modal_pdf_event_koutei').removeClass('active');
      $("#modal_print_pdf_event").css('display', '');
      $("#modal_print_pdf_job").css('display', 'none');
      $("#modal_print_pdf_koutei").css('display', 'none');
      currentDate = new Date();
      startOfWeek = moment().startOf('isoweek').format('YYYY/MM/DD');
      endOfWeek   = moment().endOf('isoweek').format('YYYY/MM/DD');
      $("#modal_date_start_input").val(startOfWeek);
      $("#modal_date_end_input").val(endOfWeek);
  );

  $('#modal_pdf_event_job').click( () ->
    if !$(this).hasClass('active')
      $(this).addClass('active');
      $('#modal_pdf_event').removeClass('active');
      $('#modal_pdf_event_koutei').removeClass('active');
      $("#modal_print_pdf_event").css('display', 'none');
      $("#modal_print_pdf_job").css('display', '');
      $("#modal_print_pdf_koutei").css('display', 'none');
      currentDate = new Date();
      startOfWeek = moment().startOf('isoweek').format('YYYY/MM/DD');
      endOfWeek   = moment().endOf('isoweek').format('YYYY/MM/DD');
      $("#modal_date_start_input").val(startOfWeek);
      $("#modal_date_end_input").val(endOfWeek);
  );

  $('#modal_pdf_event_koutei').click( () ->
    if !$(this).hasClass('active')
      $(this).addClass('active');
      $('#modal_pdf_event').removeClass('active');
      $('#modal_pdf_event_job').removeClass('active');
      $("#modal_print_pdf_event").css('display', 'none');
      $("#modal_print_pdf_job").css('display', 'none');
      $("#modal_print_pdf_koutei").css('display', '');
      currentDate = new Date();
      startOfWeek = moment().startOf('isoweek').format('YYYY/MM/DD');
      endOfWeek   = moment().endOf('isoweek').format('YYYY/MM/DD');
      $("#modal_date_start_input").val(startOfWeek);
      $("#modal_date_end_input").val(endOfWeek);
  );
  $('#modal_print_pdf_event').click( () ->
    window.open('/events/pdf_event_show.pdf?locale=ja&date_start='+$("#modal_date_start_input").val()+'&date_end='+$("#modal_date_end_input").val());
  );
  $('#modal_print_pdf_job').click( () ->
    window.open('/events/pdf_job_show.pdf?locale=ja&date_start='+$("#modal_date_start_input").val()+'&date_end='+$("#modal_date_end_input").val());
  );
  $('#modal_print_pdf_koutei').click( () ->
    window.open('/events/pdf_koutei_show.pdf?locale=ja&date_start='+$("#modal_date_start_input").val()+'&date_end='+$("#modal_date_end_input").val());
  );
  $('#modal_date_start_input').click( () ->
    $('.modal_date_start_select').data("DateTimePicker").toggle();
  );
  $('#modal_date_end_input').click( () ->
    $('.modal_date_end_select').data("DateTimePicker").toggle();
  );

  oDaikyuTable = $('.daikyutable').DataTable({
    "pagingType": "simple_numbers"
    ,"oLanguage":{
      "sUrl": "../../assets/resource/dataTable_"+$('#language').text()+".txt"
    }
  })

  $('.daikyutable tbody').on 'click', 'tr', (event) ->
    d = oDaikyuTable.row(this).data()

    if ( $(this).hasClass('selected') )
      $(this).removeClass('selected')
      $(this).removeClass('success')
    else
      oDaikyuTable.$('tr.selected').removeClass('selected')
      oDaikyuTable.$('tr.success').removeClass('success')
      $(this).addClass('selected')
      $(this).addClass('success')

  $('#daikyu_sentaku_ok').click () ->
    d = oDaikyuTable.row('tr.selected').data()
    if d != undefined
      $('#kintai_daikyu').val(d[0])

  $('.daikyutable tbody').on( 'dblclick', 'tr', () ->
    $(this).addClass('selected');
    d = oDaikyuTable.row('tr.selected').data()
    if d != undefined
      $('#kintai_daikyu').val(d[0])
    $('#daikyu_search_modal').modal('hide')
  )
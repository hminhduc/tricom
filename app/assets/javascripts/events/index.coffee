parseDateValue = (rawDate) ->
  dateArray = rawDate.substring(0, 10).split('/')
  parsedDate = dateArray[0] + dateArray[1] + dateArray[2]
  parsedDate

isNum = (c) ->
  c >= '0' and c <= '9'

getStartCalendarMonthbegin = (dateString) ->
  #console.log(dateString.length);
  res = dateString.substring(0, 4)
  if dateString.charAt(5) == ' '
    if isNum(dateString.charAt(6)) and isNum(dateString.charAt(7))
      res += dateString.substring(6, 8)
    else
      res += '0' + dateString.substring(6, 7)
    res += '01'
  else
    if isNum(dateString.charAt(5)) and isNum(dateString.charAt(6))
      res += dateString.substring(5, 7)
      if isNum(dateString.charAt(8)) and isNum(dateString.charAt(9))
        res += dateString.substring(8, 10)
      else
        res += '0' + dateString.substring(8, 9)
    else
      res += '0' + dateString.substring(5, 6)
      if isNum(dateString.charAt(7)) and isNum(dateString.charAt(8))
        res += dateString.substring(7, 9)
      else
        res += '0' + dateString.substring(7, 8)
  res
$ ->
  dataTableExt = $.fn.dataTableExt.afnFiltering.push((oSettings, aData, iDataIndex) ->
    dateStart = getStartCalendarMonthbegin($('.fc-left').text())
    # var dateStart = parseDateValue($("#dateStart").val());
    # var dateEnd = parseDateValue($("#dateEnd").val());
    # aData represents the table structure as an array of columns, so the script access the date value
    # in the first column of the table via aData[0]
    evalDate = parseDateValue(aData[1])
    #show only this month
    if !moment(aData[1].substr(0, 10), 'YYYY/MM/DD', true).isValid()
      #check to inogle date coloumn
      return true
    else if evalDate.substr(0, 6) == dateStart.substr(0, 6)
      return true
    false
  )

updateEvent = (the_event) ->
  $.post
    url: '/events/ajax'
    data:
      id: 'event_drag_update'
      shainId: the_event.resourceId
      eventId: the_event.id
      event_start: the_event.start.format('YYYY/MM/DD HH:mm')
      event_end: the_event.end.format('YYYY/MM/DD HH:mm')
    success: (data) ->
      console.log 'Update success'
    failure: ->
      console.log 'Update unsuccessful'
  $('#calendar-month-view').fullCalendar 'updateEvent', the_event

create_calendar = (data) ->
  myEventSourses = ''
  if data.setting.select_holiday_vn == '1'
    myEventSourses = [
      {
        googleCalendarId: 'en.japanese#holiday@group.v.calendar.google.com'
        color: 'green'
      }
      {
        googleCalendarId: 'en.vietnamese#holiday@group.v.calendar.google.com'
        color: 'blue'
      }
    ]
  else
    myEventSourses = [ {
      googleCalendarId: 'en.japanese#holiday@group.v.calendar.google.com'
      color: 'green'
    } ]
  $('#calendar-month-view').fullCalendar
    schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives'
    firstDay: 1
    timeFormat: 'H:mm'
    slotLabelFormat: [ 'HH : mm' ]
    nowIndicator: true
    googleCalendarApiKey: 'AIzaSyDOeA5aJ29drd5dSAqv1TW8Dvy2zkYdsdk'
    eventSources: myEventSourses
    schedulerLicenseKey: 'GPL-My-Project-Is-Open-Source'
    events: data.events
    header:
      left: 'title'
      center: 'month,agendaWeek,agendaDay today prev,next'
      right: ''
    dragOpacity: '0.5'
    editable: true
    defaultDate: moment($('#goto_date').val())
    viewRender: (view, element) ->
      $.post
        url: '/events/ajax'
        data:
          id: 'kintai_getData'
          selected_user: $('#selected_user').val()
          date_kintai: $('#calendar-month-view').fullCalendar('getDate').format('YYYY-MM-DD')
        success: (data) ->
          jQuery.each data, (key, val) ->
            cell = element.find('.fc-bg td.fc-day[data-date=' + key + ']')
            if cell.length > 0
              style = if val == 1 then '' else 'background-color: ' + cell.css('background-color')              
              klass = if val == 1 then 'btn btn-hoshu' else 'btn btn-text'
              cell.append "<button id='bt-hoshu' class='" + klass + "' date='" + key + "' value='" + (val || 0) + "' type='button' style='" + style + "'>携帯</button>"
        failure: ->
          console.log 'kintai_保守携帯回数 keydown Unsuccessful'
    dayClick: (date, jsEvent, view) ->
      calendar = document.getElementById('calendar-month-view')
      calendar.ondblclick = ->
        location.href = '/events/new?start_at=' + date.format('YYYY/MM/DD')
        return
    eventRender: (event, element, view) ->
      if view.name == 'agendaDay' or view.name == 'agendaWeek'
        if event.job != undefined or event.comment != undefined
          element.find('.fc-title').replaceWith '<div>' + event.job + '</div>' + '<div>' + event.comment + '</div>'
      return
    eventDrop: (event, dayDelta, minuteDelta, allDay, revertFunc) ->
      # alert(event.title + " was dropped on " + event.start.format());
      updateEvent event
      return
    eventResize: (event, dayDelta, minuteDelta, revertFunc) ->
      updateEvent event
      return
    eventMouseover: (event, jsEvent, view) ->
      end_time = if event.end != null then event.end.format('YYYY/MM/DD HH:mm') else ''
      tooltip = '<div class="tooltipevent hover-end">' + '<div>' + event.start.format('YYYY/MM/DD HH:mm') + '</div>' + '<div>' + end_time + '</div>'
      tooltip += '<div>' + event.title
      tooltip += (if event.job != undefined then ' ' + event.bashomei else '') + '</div>'
      if event.job != undefined
        tooltip = tooltip + '<div>' + event.job + '</div>'
      if event.comment != undefined
        tooltip = tooltip + '<div>' + event.comment + '</div>'
      tooltip = tooltip + '</div>'
      $('body').append tooltip
      $(this).mouseover((e) ->
        $(this).css 'z-index', 10000
        $('.tooltipevent').fadeIn '500'
        $('.tooltipevent').fadeTo '10', 1.9
        return
      ).mousemove (e) ->
        $('.tooltipevent').css 'top', e.pageY + 10
        $('.tooltipevent').css 'left', e.pageX + 20
        return
      return
    eventMouseout: (event, jsEvent, view) ->
      $(this).css 'z-index', 8
      $('.tooltipevent').remove()
      return
  # end of $('#calendar-month-view').fullCalendar(
  #Hander calendar header button click
  $('#month-view').find('#goto-date-button, .fc-today-button,.fc-prev-button,.fc-next-button').click ->
    #redraw dataTable after filter
    oTable = $('#event_table').DataTable()
    oTable.draw()
    #set current date to hidden field to goback, post it to session
    $.post '/settings/ajax',
      setting: 'setting_date'
      selected_date: $('#calendar-month-view').fullCalendar('getDate').format('YYYY/MM/DD')
  #add jpt holiday
  $('#calendar-month-view').fullCalendar 'addEventSource', data.holidays

jQuery ->
  $('#calendar-month-view').on 'click', 'td.fc-day #bt-hoshu', ->
    if $('#selected_user').val() == $('#current_user').val()
      val = $(this).attr('value')
      if val == '0'
        style = ''
        klass = 'btn btn-hoshu'
        val = '1'
      else
        style = 'background-color: ' + $(this).parent().css('background-color')
        klass = 'btn btn-text'
        val = '0'
      $(this).attr('class', klass)
      $(this).attr('style', style)
      $(this).attr('value', val)

      $.post
        url: '/events/ajax'
        data:
          id: 'kintai_保守携帯回数'
          hoshukeitai: val
          date_kintai: $(this).attr('date')
          selected_user: $('#selected_user').val()
        success: (data) ->
          if data.kintai_id != null
            console.log 'getAjax kintai_id:' + data.kintai_id
          else
            console.log 'getAjax kintai_id:' + data.kintai_id

        failure: ->
          console.log 'kintai_保守携帯回数 keydown Unsuccessful'
    else
      console.log('Not you')

  $('#shainmaster_kinmutype').on 'change', ()->
    $.post
      url: '/events/ajax'
      data:
        id: 'save_kinmu_type'
        data:$(this).val()
      success: (data) ->
#        swal('勤務タイプ保存！')
      failure: () ->
        console.log("save-kinmu-type field")

  $('#goto-date-input').val(moment().format('YYYY/MM/DD'))
  $('.datetime_search').datetimepicker
    format: 'YYYY/MM/DD'
    widgetPositioning:
      horizontal: 'left'
    showTodayButton: true
    showClear: true
    sideBySide: true
    keyBinds: false
    focusOnShow: false
  $('#goto-date-input').click ->
    $('.datetime_search').data("DateTimePicker").toggle()
  
  $('#goto-date-button').click ->
    date_input = $('#goto-date-input').val()
    date = moment(date_input)
    $('#calendar-month-view').fullCalendar 'gotoDate', date
    $('#calendar-timeline').fullCalendar 'gotoDate', date

  $('#search_user').click ()->
    $('#select_user_modal').trigger('show', [''])

  $('#user_table').on 'choose_shain', (e, selected_data)->
    if selected_data != undefined
      $('#selected_user').val(selected_data[0])
      $('#selected_user_name').val(selected_data[1])
      $('#selected_user').closest('form').submit()

  $('#event_button').click ()->
    $('#after_div').toggle()

  $('#after_div').hide()  

  create_calendar(event_data)

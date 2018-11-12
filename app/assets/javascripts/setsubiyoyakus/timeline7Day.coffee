$ ->
  $('#setsubicode').on 'change', ()->
    $(this).closest('form').submit()
  calendar = $('#setsubiyoyaku-timeline7Day').fullCalendar(
    customButtons:
      next10Days:
        text: '>+10'
        click: ->
          currentDate = $('#setsubiyoyaku-timeline7Day').fullCalendar('getDate')
          next10Days = currentDate.add(10, 'days')
          $('#setsubiyoyaku-timeline7Day').fullCalendar 'gotoDate', next10Days
        icon: 'right-double-arrow'
      prev10Days:
        text: '<-10'
        click: ->
          currentDate = $('#setsubiyoyaku-timeline7Day').fullCalendar('getDate')
          prev10Days = currentDate.add(-10, 'days')
          $('#setsubiyoyaku-timeline7Day').fullCalendar 'gotoDate', prev10Days
        icon: 'left-double-arrow'
    views:
      timeline7Day:
        type: 'timelineWeek'
        buttonText: '週'
        slotDuration: moment.duration(1, 'day')
        slotLabelFormat: [ 'M/D ddd' ]
        titleFormat: 'YYYY年M月D日 dd'
        timeFormat: 'HH'
      timelineDay: titleFormat: 'YYYY年M月D日 [(]dd[)]'
    schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives'
    lang: 'ja'
    businessHours:
      start: '09:00:00'
      end: '18:00:00'
      dow: [
        0
        1
        2
        3
        4
        5
        6
      ]
    firstDay: 1
    nowIndicator: true
    aspectRatio: 1.5
    resourceAreaWidth: '15%'
    slotLabelFormat: [ 'HH : mm' ]
    scrollTime: setsubi_data.setting.scrolltime
    eventOverlap: false
    defaultView: 'timeline7Day'
    dragOpacity: '0.5'
    editable: true
    events: setsubi_data.setsubiyoyakus
    defaultDate: moment($('#selected_date').val())
    height:'auto'
    eventMouseover: (event, jsEvent, view) ->
      tooltip = '<div class="tooltipevent hover-end">'
      tooltip += '<div>' + event.start.format('YYYY/MM/DD HH:mm') + '</div>'
      tooltip += '<div>' + event.end.format('YYYY/MM/DD HH:mm') + '</div>'
      tooltip += '<div>' + event.shain + '</div>'
      tooltip += '<div>' + event.yoken + '</div>'
      tooltip += '<div>' + event.description + '</div>'
      tooltip += '</div>'
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
    resourceColumns: [
      {
        labelText: '設備名'
        field: 'name'
      }
      {
        labelText: ''
        field: 'shinki'
        width: 30
        render: (resources, el) ->
          el.html '<a href="/setsubiyoyakus/new?setsubi_code=' + resources.id + '" class="glyphicon glyphicon-edit" aria-hidden="true" style="font-size:12px;"></a>'
      }
    ]
    resources: setsubi_data.setsubis)
  calendar.find('.fc-today-button,.fc-prev-button,.fc-next-button').click ->
    $.post '/settings/ajax',
      setting: 'setting_date'
      selected_date: $('#setsubiyoyaku-timeline7Day').fullCalendar('getDate').format()

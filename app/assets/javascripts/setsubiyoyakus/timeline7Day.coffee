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
    resourceAreaWidth: '30%'
    slotLabelFormat: [ 'HH : mm' ]
    scrollTime: setsubi_data.setting.scrolltime
    eventOverlap: false
    defaultView: 'timeline7Day'
    dragOpacity: '0.5'
    editable: true
    events: setsubi_data.setsubiyoyakus
    defaultDate: moment($('#goto_date').val())
    height:'auto'
    resourceColumns: [
      {
        labelText: '設備名'
        field: 'name'
      }
    ]
    resources: setsubi_data.setsubis)

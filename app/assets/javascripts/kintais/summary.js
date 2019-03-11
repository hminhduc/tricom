$(function () {
    now = new Date()
    current = new Date(now.getFullYear(), now.getMonth() + 1, 1)

    $('.date-search').datetimepicker({
        format: 'YYYY/MM',
        viewMode: 'months',
        keyBinds: false,
        focusOnShow: false,
        maxDate: moment(current).format('YYYY/MM/DD')
    });
    $('.date-search').on('dp.show', function () {
        $('.date-search').data("DateTimePicker").viewMode("months");
    })

    $('#search').click(function () {
        $('.date-search').data("DateTimePicker").viewMode("months").toggle();
    });
// add for datatable
    $('#kintaisummary').DataTable({
        "dom": "<'row'<'col-md-6'l><'col-md-6'f>><'row'<'col-md-7'B><'col-md-5'p>><'row'<'col-md-12'tr>><'row'<'col-md-12'i>>",
        "pagingType": "full_numbers",
        "oLanguage": {
            "sUrl": $path
        },
        "buttons": [
            {
                "extend":    'excelHtml5',
                "text":      '<i class="fa fa-file-excel-o"></i>',
                "titleAttr": 'Excel'
            },
            {
                "extend":    'csvHtml5',
                "text":      '<i class="fa fa-file-text-o"></i>',
                "titleAttr": 'CSV'
            }
        ],
        pageLength: 100
    });
});
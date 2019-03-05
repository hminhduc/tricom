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
        "pagingType": "full_numbers",
        "oLanguage": {
            "sUrl": $path
        },
        pageLength: 100
    });
});
$(function () {
    data_table = $('#shainsentaku_table').DataTable({
        retrieve: true,
        pagingType: "simple_numbers",
        oLanguage: {
            "sUrl": "../../assets/resource/dataTable_" + $('#language').text() + ".txt"
        },
        order: [1, 'asc'],
        pageLength: 10,
        columnDefs: [{
            orderable: false,
            className: 'select-checkbox',
            targets: 0
        }],
        select: {
            style: 'multi'
        },
        dom: 'Bfrtip',
        buttons: [
            'selectAll',
            'selectNone'
        ]
    });
});
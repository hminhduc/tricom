$(function () {
    $('#shainsentaku').click(function () {
        $('#shainsentaku_modal').modal('show');
        var table = $('#shainsentaku_table').DataTable();

        var indexes = table
            .rows()
            .indexes()
            .filter( function ( value, index ) {
                // return '81000' === table.row(value).data()[1];
                return _.contains($('#event_shain_ids').val().split(','),table.row(value).data()[1]);
            } );

        // table.row(':eq(1)').select();
        table.rows( indexes ).select();
    });
    $('#multishain_sentaku_ok').click(function () {
        var shainNo = [];
        var selected_rows = $('#shainsentaku_table').DataTable().rows({selected: true}).data();
        for (var i = 0; i < selected_rows.length; i++) {
            shainNo.push(selected_rows[i][1]);
        }
        $('#event_shain_ids').val(shainNo.toString());
    });
});
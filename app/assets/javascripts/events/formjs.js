$(function () {
    $('#shainsentaku').click(function () {
        $('#shainsentaku_modal').modal('show');
    });
    $('#multishain_sentaku_ok').click(function () {
        var shainNo = [];
        var selected_rows = $('#shainsentaku_table').DataTable().rows({selected: true}).data();
        for (var i = 0; i < selected_rows.length; i++) {
            shainNo.push(selected_rows[i][1]);
        }
        $('#shain_ids').val(shainNo.toString());
    });
});
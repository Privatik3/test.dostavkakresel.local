$(document).ready(function () {
    // All product filter name
    $('input[name=\'product-point-search\']').on('keyup', function () {
        var string = $(this).val();
        if (!string) {
            $('#product-all-product-points div').show();
        } else {
            var reg = new RegExp(string, 'i');
            $('#product-all-product-points div').each(function () {

                if ($(this).text().search(reg) != -1) {
                    $(this).show();
                } else {
                    $(this).hide();
                }
            });
        }
    });

    $('#product-points').delegate('.fa-minus-circle', 'click', function () {
        $(this).parent().remove();
    });

    $('#product-all-product-points').delegate('.fa-plus-circle', 'click', function () {

        var item = {
            'value': $(this).parent().find('input').val(),
            'label': $(this).parent().text()
        };
        $('#product-points').append('<div id="product_point_' + item['value'] + '"><i class="fa fa-minus-circle"></i>' + item['label'] + '<input class="point-checkbox" type="checkbox"><input type="hidden" name="point[id][]" value="' + item['value'] + '"/><input type="hidden" name="point[x][]" value="0"/><input type="hidden" name="point[y][]" value="0"/></div>');
        $(this).parent().remove();
    });


    let thumbnail = $('div.thumbnail');

    $('#product-points').delegate('.point-checkbox', 'change', function () {
        let id = $(this).parent().find("input[name='id']").val();
        if (this.checked) {
            let newPoint = $('<span class="point" data-item="' + id +'" style="background-color: red"></span>');
            thumbnail.append(newPoint);
            newPoint.draggable({
                stop: function() {
                    $( this ).css('background-color', 'green');
                    let top = $( this ).position()['top'];
                    let left = $( this ).position()['left'];

                    $ ( 'div#product_point_' + id ).find("input[name='x']").val(left);
                    $ ( 'div#product_point_' + id ).find("input[name='y']").val(top);
                }
            });
        } else {
            thumbnail.find('span[data-item="' + id + '"]').remove();
            $(this).parent().find("input[name='x']").val(0);
            $(this).parent().find("input[name='y']").val(0);
        }
    });
});
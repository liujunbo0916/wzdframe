/**
 * Created by zhangleyu on 2017/8/31.
 */
$(function () {
    var personQuantitiy = 0;
    var childQuantitiy = 0;
    $('.person-quantity-right-plus').click(function (e) {
        e.preventDefault();
        var personQuantitiy = parseInt($('#person-quantity').val());
        $('#person-quantity').val(personQuantitiy + 1);

    });

    $('.person-quantity-left-minus').click(function (e) {
        e.preventDefault();
        var personQuantitiy = parseInt($('#person-quantity').val());
        if (personQuantitiy > 0) {
            $('#person-quantity').val(personQuantitiy - 1);
        }
    });
    $('.child-quantity-right-plus').click(function (e) {
        e.preventDefault();
        var childQuantitiy = parseInt($('#child-quantity').val());
        $('#child-quantity').val(childQuantitiy + 1);

    });

    $('.child-quantity-left-minus').click(function (e) {
        e.preventDefault();
        var childQuantitiy = parseInt($('#child-quantity').val());
        if (childQuantitiy > 0) {
            $('#child-quantity').val(childQuantitiy - 1);
        }
    });

})
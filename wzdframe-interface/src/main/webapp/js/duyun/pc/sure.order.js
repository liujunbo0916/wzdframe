/**
 * Created by zhangleyu on 2017/9/10.
 */
$(function () {
    // $('.zhifubao-icon').show();
    $('.zhifubao-none-icon').hide();
    // $('.weixin-none-icon').show();
    $('.weixin-icon').hide();
    selectChoice = function (item) {
        if (item === 'zhifubao') {
            $('.sub-order').attr('data-target', '#zhifubaoModal');
            $('.weixin-icon').hide();
            $('.weixin-none-icon').show();
            $('.zhifubao-icon').show();
            $('.zhifubao-none-icon').hide();
        } else if (item === 'weixin') {
            $('.sub-order').attr('data-target', '#weixinModal');
            $('.weixin-icon').show();
            $('.weixin-none-icon').hide();
            $('.zhifubao-icon').hide();
            $('.zhifubao-none-icon').show();
        }

    };
    $('.sub-order').click(function () {
    	    $('#zhifubaoModal').modal('show');
            setTimeout(function () {
            	$('#zhifubaoModal').modal('hide');
            	$("#weixinModal").modal('show');
            }, 2000)
    })
})
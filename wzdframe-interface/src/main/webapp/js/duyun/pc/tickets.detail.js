/**
 * Created by zhangleyu on 2017/8/29.
 */
$(function () {
    onBook=function (data) {
        var bookList=[0,1,2];
        for (var i=0;i<bookList.length;i++){
            if(data===bookList[i]){
                $('.service-'+bookList[i]).addClass('active');
            }else{
                $('.service-'+bookList[i]).removeClass('active');
            }

        }

    }
})
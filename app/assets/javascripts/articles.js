$(window).on('load', function() {

    // 自動保存機能
    $('#ajax-form > .form-group').on('change',function() {
       $('#ajax-form').submit();
    });

});
$(window).on('load', function() {

    // 保存機能
    function ajaxAutoSave() {
         $('#ajax-form').submit();
    }

    // 5秒後に自動保存
    var timer_id = setTimeout(ajaxAutoSave, 5000);
    clearTimeout(timer_id);
    
    //保存、プレビューボタン押下時保存
    $('#article_save > .form-group').on('click',function() {
      ajaxAutoSave();
    })

    // 記事を編集するごとにsetTimeoutをリセット
    $('#ajax-form > .form-group').on('change',function() {
       ajaxAutoSave();
    });
    
    $('#ajax-form > .form-group').on('keyup',function() {
      clearTimeout(timer_id);
      timer_id = setTimeout(ajaxAutoSave, 5000);
    });

});
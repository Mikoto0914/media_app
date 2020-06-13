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

//出力文字数を制限する
$(function() {
   var count = 150;
   var insertText;
   var showText;
 $('.text_limit').each(function() {
     var thisText = $(this).text();
      var textLength = thisText.length;
       if (textLength > count) {
          showText = thisText.substring(0, count);
          insertText = showText += '…';
          $(this).html(insertText);
      } else {
        showText = thisText.substring(0, thisText.length);
        $(this).html(showText);
      };
  });
});
$(window).on("load", function() {

  // 保存機能
  function ajaxAutoSave() {
     $("#ajax-form").submit();
  }
  
  // 5秒後に自動保存
  var timer_id = setTimeout(ajaxAutoSave, 5000);
  clearTimeout(timer_id);
  
  //保存、プレビューボタン押下時保存
  $("#article_save").on("click",function() {
    ajaxAutoSave();
  })
  
  // 記事を編集するごとにsetTimeoutをリセット
  $("#ajax-form > .article_frame").on("change",function() {
     ajaxAutoSave();
  });
  
  $("#ajax-form > .article_frame").on("keyup",function() {
    clearTimeout(timer_id);
    timer_id = setTimeout(ajaxAutoSave, 5000);
  });
  
  // プレビュー機能
  function buildPreview() {
    $.ajax({
      url: "/posts/markdown",
      type: "post",
      data: {body: $("#ajax-form > .article_frame > .middle-wrapper > .body").val()},
      dataType: "json"
    }).done(function(json){
      $("#ajax-form > .article_frame > .middle-wrapper > #preview").empty();
      $("#ajax-form > .article_frame > .middle-wrapper > #preview").append(json.body);
    })
  }
  buildPreview();
  
  $("#ajax-form > .article_frame > .middle-wrapper > .body").on("keyup", function() {
    buildPreview();
  })
  
  // 選択されたサムネ画像を読み込み表示させる
  $("#post_thumbnail_image").on("change", function(e){
    $(".thumbnail").css("background-image",`url(${window.URL.createObjectURL(e.target.files[0])})`);
  })
    
});

//出力文字数を制限する
$(function() {
   var count = 150;
   var insertText;
   var showText;
 $(".text_limit").each(function() {
     var thisText = $(this).text();
      var textLength = thisText.length;
       if (textLength > count) {
          showText = thisText.substring(0, count);
          insertText = showText += "…";
          $(this).html(insertText);
      } else {
        showText = thisText.substring(0, thisText.length);
        $(this).html(showText);
      };
  });
});
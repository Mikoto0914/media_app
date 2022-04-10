$(window).on("load", function() {

  // 保存機能
  function ajaxAutoSave() {

    const target = document.getElementById('input-file');
    const file = target.files[0]

    if(file != undefined){
      console.log(file);

      $.ajax({
        url: "/api/presigned_url",
        type: "get",
        dataType: "json"
      }).done(function(presignedObject){

        const formData = new FormData()
        for (const key in presignedObject.fields) {
            formData.append(key, presignedObject.fields[key])
        }
        formData.append('file', file)

        const ret = fetch(presignedObject.url, {
          method: 'POST',
          headers: { Accept: 'multipart/form-data' },
          body: formData,
        })

        // $.ajax({
        //   url: presignedObject.url,
        //   type: "post",
        //   headers: { Accept: 'multipart/form-data' },
        //   processData: false,
        //   dataType: 'XML',
        //   data: formData
        // })

        console.log(presignedObject);
        console.log(ret);
      });
    }
    $("#ajax-form").submit();
  }
  
  // 5秒後に自動保存
  // var timer_id = setTimeout(ajaxAutoSave, 5000);
  // clearTimeout(timer_id);
  
  //保存、プレビューボタン押下時保存
  $("#article_save").on("click",function() {
    ajaxAutoSave();
  })
  
  // 記事を編集するごとにsetTimeoutをリセット
  $("#ajax-form > .article_frame").on("change",function() {
     ajaxAutoSave();
  });
  
  // $("#ajax-form > .article_frame").on("keyup",function() {
  //   clearTimeout(timer_id);
  //   timer_id = setTimeout(ajaxAutoSave, 5000);
  // });
  
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
  
  // 編集ページに遷移したときにサムネ画像を読み込み表示させる
  if($("#header").attr("action") == "posts#edit"){
    $(".thumbnail").css("background-image",`url(${$("#header").attr("thumbnail_image")})`);
  }
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

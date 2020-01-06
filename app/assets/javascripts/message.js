$(function(){

  var buildHTML = function(message) {
    var html = `<div class="message" data-message-id=${message.id}>
                  <div class="upper-message">
                    <div class="upper-message__user-name">
                    ${message.user_name}
                    </div>
                    <div class="upper-message__date">
                    ${message.created_at}
                      <div class="upper-message__date__delete">
                        <a class="message-delete" rel="nofollow" data-method="delete" href=${message.id}>削除</a>
                      </div>
                    </div>
                  </div>
                  <div class="lower-message">
                    <p class="lower-message__content">
                    ${message.content}
                    </p>
                  </div>
               </div>`
               return html;  //これがないと表示されないぞ
  }

  $("#new_message").on("submit", function(e){
    e.preventDefault()
    var formData = new FormData(this);
    var url = $(this).attr('action')   //action属性はデータの送信先を指定する属性
    $.ajax({                           //リクエストを決めている
      url: url,                        //リクエストのパス
      type: "POST",                    //リクエストのHTTPメソッド
      data: formData,
      dataType: 'json',
      processData: false,              //FormDataをつかってフォームの情報を取得した時には必ずfalseにするという認識
      contentType: false,              //FormDataをつかってフォームの情報を取得した時には必ずfalseにするという認識
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.messages').append(html);
      $('#message_content').val('');
      $('.main__box__chat').animate({ scrollTop: $('.main__box__chat')[0].scrollHeight});
      $('.form__submit').prop('disabled', false);
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
    });
  });

    var reloadMessages = function() {
      last_message_id = $(".message:last").data("message-id");  //$('.message:last')jQueryのオブジェクトの指定方法の1つに、:lastがあります。今回の場合は.messageというクラスがつけられた全てのノードのうち一番最後のノード、という意味になる
      $.ajax ({
        url: "api/messages",          //ルーティングで設定した通り/groups/id番号/api/messagesとなるよう文字列を書く
        type: "get",                  //ルーティングで設定した通りhttpメソッドをgetに指定
        dataType: "json",
        data: {id: last_message_id}   //dataオプションでリクエストに値を含める
      })
      .done(function(messages) {
        if (messages.length !== 0) {
        var insertHTML = "";           //追加するHTMLの入れ物を作る
        $.each(messages, function(i, message) {     //配列messagesの中身を一つ一つ取り出し、HTMLに変換したものを入れ物に足し合わせる
          insertHTML += buildHTML(message)
        });
        $(".messages").append(insertHTML);          //メッセージが入ったHTMLに入れ物毎追加
        $('.main__box__chat').animate({ scrollTop: $('.messages')[0].scrollHeight});
        $("#message_content").val('');
        $(".form__submit").prop("disabled", false);
      }
      })
      .fail(function() {
        console.log('error');
      })
    }

    //メッセージ削除機能
    // $(".message-delete").on("click", function(e) {
    //   e.preventDefault();
    //   // e.stopPropagation();
    //   var url = $(this).attr("html");
    //   var delete_message_id = $(this)[0].dataset["deleteMessageId"];
    //   $.ajax ({
    //     url: url,
    //     type: "DELETE",
    //     dataType: "json",
    //     data: {delete_message_id: delete_message_id},
    //   })
    //   .done(function(message){
    //     ("message.id").remove();
    //   })
    // })


    if (document.location.href.match(/\/lessons\/\d+\/messages/)) {
      setInterval(reloadMessages, 7000);                              //setInterval(定期的動かしたい関数, ミリ秒単位で動かす感覚);
    }
});

//matchメソッドの引数として書いている/\/lessons\/\d+\/messages/の部分が正規表現です。正規表現は基本的には/と/で囲んだ部分になりますが、/自体も正規表現に含めたい場合、直前に\(バックスラッシュ)を付けます。
//また、\+d\の部分は、「桁無制限の数値」という意味になります。具体的には、dが0 ~ 9までの数字のどれかを表し、+は+のついた文字が何文字でもマッチする、という特殊な意味を持ちます。
//これで、URLにgroups/数字/messagesという部分があるページでない限り、reloadMessagesメソッドが動くことはありません。
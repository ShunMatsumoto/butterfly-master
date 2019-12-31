$(function(){

  function buildHTML(message){
    var html = `<div class="message" data-message-id=${message.id}>
                  <div class="upper-message">
                    <div class="upper-message__user-name">
                    ${message.user_name}
                    </div>
                    <div class="upper-message__date">
                    ${message.date}
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
      $('.form__message').val('');
      $('.main__box__chat').animate({ scrollTop: $('.main__box__chat')[0].scrollHeight});
      $('.form__submit').prop('disabled', false);
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
    });
  })
});
$(function(){

  function addUser(user) {
    var html = `
      <div class="chat-group-user clearfix">
        <p class="chat-group-user__name">${user.name}</p>
        <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</div>
      </div>
    `;
    $("#user-search-result").append(html);
  }

  function addNoUser() {
    var html = `
      <div class="chat-group-user clearfix">
        <p class="chat-group-user__name">ユーザーが見つかりません</p>
      </div>
    `;
    $("#user-search-result").append(html);
  }

  function addDeleteUser(name, id) {
    let html = `
    <div class="chat-group-user clearfix" id="${id}">
      <p class="chat-group-user__name">${name}</p>
      <div class="user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn" data-user-id="${id}" data-user-name="${name}">削除</div>
    </div>`;
    $(".js-add-user").append(html);
  }

  function addMember(userId) {
    let html = `<input value="${userId}" name="group[user_ids][]" type="hidden" id="group_user_ids_${userId}" />`;   //idsはテーブルの主キーを使用するリレーションのIDをすべて取り出すのに使用できます
    $(`#${userId}`).append(html);
  }


  $("#user-search-field").on("keyup", function(){
    var input = $("#user-search-field").val();
    $.ajax({
      type: "GET",                           //HTTPメソッド
      url: "/users",                         //送信先のurl コントローラーのことだね
      data: { keyword: input },              //送信するデータ。上記でval()で取得した値が代入されたinputを送信する
      dataType: "json"
    })
    .done(function(users){
      $("#user-search-result").empty();      //emptyメソッドで一度検索結果を空にする
      if (users.length !== 0) {              //usersが空かどうかを条件分岐で記述
        users.forEach(function(user) {       //配列.forEach( 処理 )のように配列データに対してforEachを実行します。forEach文は、配列データの値1つずつに対してコールバック関数に記述した処理を実行できます。
          addUser(user);
        });
      } else if (input.length == 0) {
        return false;
      } else {
        addNoUser();
      }
    })
    .fail(function(){
      alert("通信エラーです。ユーザーが表示できません。");
    });
  });
  $(document).on('click', ".chat-group-user__btn--add", function(){
    console.log
    const userName = $(this).attr("data-user-name");      //constとは値書き換えを禁止した変数を宣言する方法
    const userId = $(this).attr("data-user-id");
    $(this)
      .parent()                                           //一つ上の親要素を取得する
      .remove();                                          //対象となる要素を削除する
    addDeleteUser(userName, userId);
    addMember(userId);
  })
  $(document).on("click", ".chat-group-user__btn--remove", function() {
    $(this)
      .parent()
      .remove();
  });
});
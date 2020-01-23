$(function() {
  // チャットメンバーを追加の欄で検索候補に表示
  function addUser(user) {
    let html = `
      <div class="chat-group-user clearfix">
        <p class="chat-group-user__name">${user.name}</p>
        <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</div>
      </div>
    `;
    $("#user-search-result").append(html);
  }
      
      // チャットメンバーを追加の欄で検索候補がない場合に表示
      function addNoUser() {
        let html = `
          <div class="chat-group-user clearfix">
            <p class="chat-group-user__name">ユーザーが見つかりません</p>
          </div>
        `;
        $("#user-search-result").append(html);
      }
      
    // チャットメンバーの欄で検索候補に追加されているユーザを表示
    function addDeleteUser(name, id) {
      let html = `
        <div class="chat-group-user clearfix" id="${id}">
          <p class="chat-group-user__name">${name}</p>
          <div class="user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn" data-user-id="${id}" data-user-name="${name}">削除</div>
        </div>
      `;
      $(".js-add-user").append(html);
    }
    
  // 既に参加しているユーザをチャットメンバーに表示
  function addMember(userId) {
    let html = `<input value="${userId}" name="group[user_ids][]" type="hidden" id="group_user_ids_${userId}" />`;
    $(`#${userId}`).append(html);
  }

  $("#user-search-field").on("keyup", function() {
    let input = $("#user-search-field").val();
    $.ajax({
      type: "GET",
      url: "/users",
      data: { keyword: input },
      dataType: "json"
    })
      .done(function(users) {
        $("#user-search-result").empty();
        // $('chat-group-form__input').val('');  枠ごと事消える。
        if (users.length !== 0) {
          users.forEach(function(user) {
            addUser(user);
          });
        } else if (input.length == 0) {
          return false;
        } else {
          addNoUser();
        }
      })
      .fail(function() {
        alert("通信エラーです。ユーザーが表示できません。");
      });
  });
  $(document).on("click", ".chat-group-user__btn--add", function() {
    console.log
    const userName = $(this).attr("data-user-name");
    const userId = $(this).attr("data-user-id");
    $(this)
      .parent()
      .remove();
    addDeleteUser(userName, userId);
    addMember(userId);
  });
  $(document).on("click", ".chat-group-user__btn--remove", function() {
    $(this)
      .parent()
      .remove();
  });
});
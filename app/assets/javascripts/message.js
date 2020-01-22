$(function(){
  function buildHTML(message){
    if ( message.image ) {
      var html = 
            `<div class="main-chat__message-list__unit">
              <div class="main-chat__message-list__unit__data">
                <div class="main-chat__message-list__unit__data--name">
                  ${message.user_name}
                </div>
                <div class="main-chat__message-list__unit__data--date">
                  ${message.date}
                </div>
              </div>
              <div class="main-chat__message-list__unit__comment--cont">
                ${message.content}
              </div>
              <img src=${message.image} >
            </div>`
      return html;
    } else {
      var html =
            `<div class="main-chat__message-list__unit">
              <div class="main-chat__message-list__unit__data">
                <div class="main-chat__message-list__unit__data--name">
                  ${message.user_name}
                </div>
                <div class="main-chat__message-list__unit__data--date">
                  ${message.date}
                </div>
              </div>
              <div class="main-chat__message-list__unit__comment--cont">
                ${message.content}
              </div>
            </div>`
      return html;
    };
  }


  $("#new_message").on("submit", function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,  //同期通信でいう『パス』
      type: 'POST',  //同期通信でいう『HTTPメソッド』
      data: formData,  
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $(".main-chat__message-list").append(html);
      $(".main-chat__message-list").animate({ scrollTop: $('.main-chat__message-list')[0].scrollHeight});
      $(".new_message")[0].reset();
      $(".submit-btn").prop("disabled",false);
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
    });
  })
});
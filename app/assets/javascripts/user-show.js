$(function(){
  $(document).on('turbolinks:load', function() {
    function photo(imageUrl){
      var inputhtml = `<img class="user_picture--image--photo" src="${imageUrl}">`
      return inputhtml;
    }
    function d_image(imageId){
      var inputhtml =  `<i class="fas fa-trash-alt" style="margin: 6px 12px 0 0"></i>
                        <a id="delete-btn" rel="nofollow" data-method="delete" href="/pictures/${imageId}">Delete</a>`
      return inputhtml;
    }
    $('.user_show__contents--photo--box--image').off('click');
    $('.user_show__contents--photo--box--image').click('', function() {
      var left_positon = ($("body").width()/2)-($(".user_picture").width()/2)
      $("body").css("overflow", "hidden");
      $( "#gray_panel" ).fadeIn("slow");
      $( ".user_picture" )
      .css("z-index","51")
      .css("position", "fixed")
      .css("top", 100)
      .css("left", left_positon)
      .fadeIn(400);
      var imageUrl = $(this).attr('src');
      var imageId = $(this).attr('id');
      var imageText = $(this).parent().children("#text-none").text().trim();
      var imgDate = $(this).parent().children("#date-none").text().trim();
      var beforeDate = moment(imgDate, "YYYY-MM-DD-HH:mm"); // 第一引数：日時、第二引数：フォーマット形式
      var imageDate = beforeDate.format('YYYY年MM月DD日 HH:mm');
      //イメージ更新
      $('.user_picture--image').empty();
      var inputhtml = photo(imageUrl);
      $('.user_picture--image').append(inputhtml);
      //削除ボタン作成
      $('#p_delete').empty();
      var inputhtml = d_image(imageId);
      $('#p_delete').append(inputhtml);
      //テキスト更新
      $('.user_picture--text').empty();
      $('.user_picture--text').text(imageText);
      $('.user_picture--date').text(imageDate);
      $('.user_picture').css('visibility', 'visible');
    });
    $(document).off('click', "#p_return");
    $(document).on("click", "#p_return", function () {
      $( "#gray_panel" ).fadeOut("slow");
      $( ".user_picture" ).fadeOut("slow");
      $("body").css("overflow", "scroll");
    });

    $('#user_edit_btn').off('click');
    $('#user_edit_btn').on('click', function(){
      var left_positon = ($("body").width()/3)-($(".user_edit__form").width()/3)
      $("body").css("overflow", "hidden");
      $( "#gray_panel" ).fadeIn("slow");
      $( ".user_edit__form" )
      .css("z-index","51")
      .css("position", "fixed")
      .css("top", 90)
      .css("left", left_positon)
      .fadeIn(600);
      $(document).on("click", ".cancel", function () {
        $( "#gray_panel" ).fadeOut("slow");
        $( ".user_edit__form" ).fadeOut("slow");
        $("body").css("overflow", "scroll");
      });
    });

  });
});
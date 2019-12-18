$(function(){
  $(document).on('turbolinks:load', function() {
    function mainImage(picture){
      var imghtml = `<img class="image-show" src="${picture.image}">`
      return imghtml;
    }
    function info(picture){
      var image = picture.user_avatar ? `<img class="avatar" src="${picture.user_avatar}">`: `<img class="avatar" src="/assets/avatar-c973c17f3678d843a989182c2e5537d69b7aaf8cdb2427daad0fcf2b89d2073a.png">`;
      var formhtml = `<a class="picture-show__right__form__user" href="/users/${picture.user_id}">
                        <div class="picture-show__right__form__user--avatar">
                          ${image}
                        </div>
                        <div class="picture-show__right__form__user--name">
                          ${picture.user_name}
                        </div>
                      </a>
                      <div class="picture-show__right__form__comment">
                        <div class="picture-show__right__form__comment--text">
                          ${picture.title}
                        </div>
                        <div class="picture-show__right__form__comment--date">
                          ${picture.date}
                        </div>
                      </div>`
      return formhtml;
    }
    $('.picture-image').off('click');
    $('.picture-image').click('', function() {
      $('.picture-show__right--detail--text').css('visibility', 'hidden');
      $('.picture-show__right__form').css('visibility', 'visible');
      $(".picture-image.select").removeClass("select");
      $(this).addClass("select");
      var imageId = $(this).attr('id');
      $.ajax({
        url: "main_image",
        type: 'GET',
        data: { image_id: imageId },
        dataType: 'json'
      })
      .done(function(picture){
        $('#main-image').empty();
        $('.picture-show__right__form').empty();
        var imghtml = mainImage(picture);
        var formhtml = info(picture);
        $('#main-image').append(imghtml);
        $('.picture-show__right__form').append(formhtml);
      })
      .fail(function(){
        alert('イメージ表示に失敗');
      })
    });
  });
});
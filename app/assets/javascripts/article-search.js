$(function(){
  $(document).on('turbolinks:load', function() {
    function article(article){
      var articleHtml =  `<a class="col-md-4 article-card" href="/articles/${article.id}">
                            <div class="card mb-4 shadow-sm">
                              <img class="image" src="${article.image}">
                              <div class="card-body">
                                <div class="card-body__info">
                                  <div class="card-body__info--title">
                                    ${article.title}
                                  </div>
                                  <div class="card-body__info--prefecture">
                                    ${article.prefecture}
                                  </div>
                                </div>
                                <div class="card-body--detail">
                                  <div class="card-body--detail--text">
                                    ${article.detail}
                                  </div>
                                </div>
                              </div>
                            </div>
                          </a>`
      return articleHtml;
    }
    $('.dropdown').off('click');
    $('.dropdown').click(function () {
      $(this).attr('tabindex', 1).focus();
      $(this).toggleClass('active');
      $(this).find('.dropdown-menu').slideToggle(300);
    });
    $('.dropdown').focusout(function () {
        $(this).removeClass('active');
        $(this).find('.dropdown-menu').slideUp(300);
    });
    $('.select-menu').off('click');
    $('.select-menu').click(function () {
      $(this).parents('.dropdown').find('span').text($(this).text());
      $(this).parents('.dropdown').find('input').attr('value', $(this).attr('id'));
      var spotId = $(this).attr('id');
      var spotName = $(this).text()
      $('.article-list--title').empty();
      var spotHtml =`<h1>${spotName}の記事一覧</h1>`;
      $('.article-list--title').append(spotHtml);
      if (spotId == 1 || spotId == 47 ){
        $('.article-list__choice__form2').css('visibility', 'hidden');
      } else {
        $('.article-list__choice__form2').css('visibility', 'visible');
      }
      var spots = ""
          tohoku = [{id: 2, name: '青森県'}, {id: 3, name: '岩手県'},{id: 4, name: '宮城県'}, {id: 5, name: '秋田県'}, {id: 6, name: '山形県'},{id: 7, name: '福島県'}],
          kanto = [{id: 8, name: '茨城県'}, {id: 9, name: '栃木県'},{id: 10, name: '群馬県'}, {id: 11, name: '埼玉県'}, {id: 12, name: '千葉県'},{id: 13, name: '東京都'},{id: 14, name: '神奈川県'}],
          hokuriku = [{id: 15, name: '新潟県'},{id: 16, name: '富山県'}, {id: 17, name: '石川県'}, {id: 18, name: '福井県'}],
          chubu = [{id: 19, name: '山梨県'}, {id: 20, name: '長野県'}, {id: 21, name: '岐阜県'},{id: 22, name: '静岡県'}, {id: 23, name: '愛知県'}],
          kinki = [{id: 24, name: '三重県'},{id: 25, name: '滋賀県'}, {id: 26, name: '京都府'}, {id: 27, name: '大阪府'},{id: 28, name: '兵庫県'}, {id: 29, name: '奈良県'}, {id: 30, name: '和歌山県'}],
          chugoku = [{id: 31, name: '鳥取県'}, {id: 32, name: '島根県'}, {id: 33, name: '岡山県'},{id: 34, name: '広島県'}, {id: 35, name: '山口県'}],
          shikoku = [{id: 36, name: '徳島県'},{id: 37, name: '香川県'}, {id: 38, name: '愛媛県'}, {id: 39, name: '高知県'}],
          kyusyu = [{id: 42, name: '長崎県'},{id: 43, name: '熊本県'}, {id: 44, name: '大分県'}, {id: 45, name: '宮崎県'},{id: 46, name: '鹿児島県'}];
      if ( spotId == 48 ){
        spots = tohoku;
      } else if ( spotId == 49 ) {
        spots = kanto;
      } else if ( spotId == 50 ) {
        spots = hokuriku;
      } else if ( spotId == 51 ) {
        spots = chubu;
      } else if ( spotId == 52 ) {
        spots = kinki;
      } else if ( spotId == 53 ) {
        spots = chugoku;
      } else if ( spotId == 54 ) {
        spots = shikoku;
      } else {
        spots = kyusyu;
      }
      $('#prefecture_list').empty();
      $(spots).each(function(index, element){
        var sHtml =`<li class="prefecture-menu" id="${element.id}">${element.name}</li>`;
        $('#prefecture_list').append(sHtml);
      })
      $.ajax({
        url: "list_search",
        type: 'GET',
        data: { spot_id: spotId },
        dataType: 'json'
      })
      .done(function(articles){
        var num = 0
        $('.article-list--detail').empty();
        $('.article-list__contents').empty();
        $('#prefecture-name').text("Select Prefecture");
        $(articles).each(function(index, element){
          var articleHtml = article(element);
          $('.article-list__contents').append(articleHtml);
          num += 1
        })
        var pHtml =`<p>関連する記事は${num}件あります。</p>`;
        $('.article-list--detail').append(pHtml);
      })
      .fail(function(){
        alert('記事表示に失敗しました');
      })
    });

    $(document).off('click', '.prefecture-menu');
    $(document).on('click', '.prefecture-menu', function(){
      $(this).parents('.dropdown').find('input').attr('value', $(this).attr('id'));
      $('#prefecture-name').text($(this).text());
      var prefectureId = $(this).attr('id');
      var prefectureName = $(this).text()
      $('.article-list--title').empty();
      var pnHtml =`<h1>${prefectureName}の記事一覧</h1>`;
      $('.article-list--title').append(pnHtml);
      $.ajax({
        url: "list_search",
        type: 'GET',
        data: { spot_id: prefectureId },
        dataType: 'json'
      })
      .done(function(prefectures){
        var num = 0
        $('.article-list--detail').empty();
        $('.article-list__contents').empty();
        $(prefectures).each(function(index, element){
          var prefectureHtml = article(element);
          $('.article-list__contents').append(prefectureHtml);
          num += 1
        })
        var pHtml =`<p>関連する記事は${num}件あります。</p>`;
        $('.article-list--detail').append(pHtml);
      })
      .fail(function(){
        alert('記事表示に失敗しました');
      })
    });

  });
});
$(function(){
  $(document).on('turbolinks:load', function() {
    $('#myfile').change(function(e){
      var file = e.target.files[0];
      var reader = new FileReader();
  
      if(file.type.indexOf("image") < 0){
        alert("画像ファイルを指定してください。");
        return false;
      }
  
      reader.onload = (function(file){
        return function(e){
          $('#img').css('visibility', 'visible');
          $('.change_btn').css('visibility', 'visible');
          $('.image-icon').css('visibility', 'hidden');
          $('.picture-body__left--error').css('visibility', 'hidden');
          $('#myfile').css('visibility', 'hidden');
          $("#img").attr("src", e.target.result);
          $("#img").attr("title", file.name);
        };
      })(file);
      reader.readAsDataURL(file);
    });

    $('#post-btn').on('click', function(){
      var left_positon = ($("body").width()/2)-($(".picture-body").width()/2)
      $("body").css("overflow", "hidden");
      $( "#gray_panel" ).fadeIn("slow");
      $( ".picture-body" )
      .css("z-index","51")
      .css("position", "fixed")
      .css("top", 100)
      .css("left", left_positon)
      .fadeIn(600);
      $(document).on("click", ".picture-body__right--btn--cancel", function () {
        $( "#gray_panel" ).fadeOut("slow");
        $( ".picture-body" ).fadeOut("slow");
        $("body").css("overflow", "scroll");
      });
    });

    $(document).on('click','.picture-body__right--btn--send',function(){
      var picture = $('#myfile').val()
      if (picture == ""){
        $('.picture-body__left--error').css('visibility', 'visible');
        return false;
      } else{
        return true;
      }
    });
  });
});
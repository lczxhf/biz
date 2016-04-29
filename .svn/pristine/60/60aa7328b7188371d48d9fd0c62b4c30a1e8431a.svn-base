Dropzone.autoDiscover = false;

try{
  var myDropzone = new Dropzone("#dropzone" , {
  paramName: "file", // The name that will be used to transfer the file
  maxFilesize: 1.5, // MB
  uploadMultiple: false,
  addRemoveLinks : true,
  dictDefaultMessage :
  '<span class="bigger-150 bolder"><i class="ace-icon fa fa-caret-right red"></i> 选择图片文件</span> 上传 \
  <span class="smaller-80 grey">(or 点击)</span> <br /> \
  <i class="upload-icon ace-icon fa fa-cloud-upload blue fa-3x"></i>'
  ,
  dictResponseError: 'Error while uploading file!',

  //change the previewTemplate to use Bootstrap progress bars
  previewTemplate: "<div class=\"dz-preview dz-file-preview\">\n  <div class=\"dz-details\">\n    <div class=\"dz-filename\"><span data-dz-name></span></div>\n    <div class=\"dz-size\" data-dz-size></div>\n    <img data-dz-thumbnail />\n  </div>\n  <div class=\"progress progress-small progress-striped active\"><div class=\"progress-bar progress-bar-success\" data-dz-uploadprogress></div></div>\n  <div class=\"dz-success-mark\"><span></span></div>\n  <div class=\"dz-error-mark\"><span></span></div>\n  <div class=\"dz-error-message\"><span data-dz-errormessage></span></div>\n</div>"
  });


  myDropzone.on("removedfile", function(file) {
      // actions...
      // console.log("removedfile" + file.name);

      $.ajax({
        url: "/admin/photo/" + $(file.previewTemplate).attr("photo-id"),
        type: 'DELETE',
        success: function(result) {
            // Do something with the result
          if(result["result_code"] == 1){
            // location.reload();
          }else{
            console.log("error");
          }
        }
    });

  });

  myDropzone.on("success", function(file, responseText) {
    // Handle the responseText here. For example, add the text to the preview element:
    // console.log("post ok" + responseText["url"]);

    // file.previewTemplate.appendChild(document.createTextNode(responseText));
    $(file.previewTemplate).attr("photo-id", responseText["id"]);
    // console.log($("a.dz-remove").parent("form").attr("action"));
  });


  var $overflow = '';
  var colorbox_params = {
    rel: 'colorbox',
    reposition:true,
    scalePhotos:true,
    scrolling:false,
    previous:'<i class="ace-icon fa fa-arrow-left"></i>',
    next:'<i class="ace-icon fa fa-arrow-right"></i>',
    close:'&times;',
    current:'{current} of {total}',
    maxWidth:'100%',
    maxHeight:'100%',
    onOpen:function(){
      $overflow = document.body.style.overflow;
      document.body.style.overflow = 'hidden';
    },
    onClosed:function(){
      document.body.style.overflow = $overflow;
    },
    onComplete:function(){
      $.colorbox.resize();
    }
  };

  $('.ace-thumbnails [data-rel="colorbox"]').colorbox(colorbox_params);
  $("#cboxLoadingGraphic").html("<i class='ace-icon fa fa-spinner orange fa-spin'></i>"); //let's add a custom loading icon
  
  window.delPhoto = function(src){
    var photoId = $(src).parents('li').attr('data-id');
    // console.log(photoId);
    $.ajax({
            url: "/admin/photo/" + photoId,
            type: 'DELETE',
            success: function(result) {
              if(result["result_code"] == 1){
                $(src).parents('li').hide();
              }else{
                console.log("error");
              }
            }
        });
  };


 $(document).one('ajaxloadstart.page', function(e) {
  try {
    myDropzone.destroy();
    $('#colorbox, #cboxOverlay').remove();
  } catch(e) {}
 });

} catch(e) {
  alert('Dropzone.js does not support older browsers!');
}

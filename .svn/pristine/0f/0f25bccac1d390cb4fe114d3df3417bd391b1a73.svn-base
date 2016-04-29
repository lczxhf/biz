// = require upload




$(function () {
        initUploader();
        initUploadedImages();
    });

function delete_pic(delete_id) {
    console.log("delete pic");
    
    if (confirm("确定要删除图片吗?") != true){
      return;
    }

    var ids = $('#upload-pics-input').val().split(',');
    for (var i = 0; i < ids.length; i++) {
        if (ids[i] == delete_id) break;
    }
    ids.splice(i, 1);
    $.ajax({
        type: 'POST',
        url: "/upload_pic/delete",
        data: {id: delete_id, all_id: ids},
        success: function (data) {
            $('#upload-pics-input').val(ids);
            $('#pic-' + delete_id).remove();
        },
        dataType: "html"
    });
}

function initUploader() {
    var uploader = new qq.FileUploader({
            debug: true,
            allowedExtensions: ['jpg', 'jpeg', 'png', 'gif'],
            sizeLimit: 1048576, // max size: 1MB
            minSizeLimit: 0, // min size
            multiple: true,
            element: document.getElementById('file-uploader'),
            action: "/upload_pic",
            onComplete: function (id, fileName, responseJSON) {
                var ids = $('#upload-pics-input').val().split(',');
                ids.push(responseJSON.id);
                pic_url = responseJSON.url
                var ids_string = ids.join(',');
                $('#upload-pics-input').val(ids_string);
                $.getScript("/upload_pic?ids=" + ids_string);
            },
            onSubmit: function (id, fileName) {
                uploader.setParams({
                    xx: "xx",
                    yy: 'yy',
                    zz: 'zz',
                    authenticity_token: "#{form_authenticity_token.to_s}"
                });
            }
        });
}

function initUploadedImages() {
    var ids = $('#upload-pics-input').val();
    if (ids) {
        $.getScript("/upload_pic?ids=" + ids);
    };
}
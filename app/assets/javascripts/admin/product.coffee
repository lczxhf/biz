 # Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#=rquire ../rich_editor

$( document ).ready () ->

  getUrlParam = (name) ->
      reg = new RegExp( "(^|&)" + name + "=([^&]*)(&|$)");  
      r = window.location.search.substr(1).match(reg)
      if r!= null 
        return unescape(r[2])

      return null

  $("li.tab-header").removeClass('active')
  $(".tab-pane").removeClass('active')

  tabName = getUrlParam('r')

  if tabName == null
    $("li.basic").addClass('active')
    $("#basic").addClass('active')
  else 
    $("li." + tabName).addClass('active')
    $("#" + tabName).addClass('active')


  $("#product_has_assemble_fee").on "change", (e) ->    
    if($(this).val() == 'true')
      $(".toogle-hide").fadeIn();
    else
      $(".toogle-hide").fadeOut();

  $("input.ace.ace-switch.ace-switch-5").on "click", (e) ->
      console.log(e.target.getAttribute("checked"));


  $("a.delete-variant").click (e) ->     

    $.ajax 
      url: "/admin/variant/" + e.target.getAttribute("variant"),
      type: 'DELETE',
      success: (result) ->

        if result["result_code"] == 1          
          $(e.target).parents(".show-row").remove()
        else
          console.log("error");

    
  $(".gallery-button-submit").click (e) ->
    $("#photo-form").submit()

    bootbox.dialog
      message: '<img src="/assets/images/loading.gif" width="32px"/><br/> 上传中... <b></b>'

  #   $("#modal-form").modal('hide')
  #   $("#photo-form").submit()    


  $("#photo-form").submit (e) ->
    $("#modal-form").modal('hide')

    formObj = $(this)
    formURL = formObj.attr "action"
    formData = new FormData(this)
    file    = $(this).find('[name="file"]')[0].files[0];
    formData.append('file', file);

    $.ajax
      url: formURL,
      type: 'POST',
      data:  formData,
      mimeType: "multipart/form-data",
      contentType: false,
      cache: false
      processData:false,

      success: (result) ->
        bootbox.hideAll()
        # console.log(result)
        eval result
        # window.location.href = '?r=gallery'

      error: (result) ->
        bootbox.hideAll()
        console.log(result)        

    e.preventDefault();     

  # $("#photo-form").submit()



# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

doSubmit = () ->
  $.post '/api/sign_in', {
    mobile: $('input[name="mobile"]').val(),
    password: $('input[name="password"]').val()
  },
  (data) ->
    if data.result_code == 1
      # console.log 'ok'
      window.location.href = '/wap/user'
    else
      # console.log data
      hd_alert(data.error_message);

$("#login_btn").on 'click', doSubmit
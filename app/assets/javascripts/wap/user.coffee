# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

checkMobile = (mob) ->
  re = /^1\d{10}$/;
  return re.test(mob)
          
canGetting = true

func_get_sms = (mob, sms_type)->
  if canGetting
    $.post '/api/get_sms', 
      {
        mobile: mob,
        template_type: sms_type
      },

      (data) ->
        $(".msgs").attr("onclick", "")
        time = 61
        code = $(".msgs")

        if data.result_code == 1

          if canGetting 
            canGetting = false

            code.addClass "msgs1"

            t = setInterval () ->
              time--
              code.html(time + "秒");

              if time == 0
                clearInterval(t)
                code.html("重新获取")
                canGetting = true
                code.removeClass("msgs1")
              
             ,1000

        else
          hd_alert(data.error_message);


$("#sms_get").on 'click', (e) ->
  mob = $('input[name="mobile"]').val()

  if checkMobile(mob) == false
    alert('手机号码不正确')
    return
  
  func_get_sms(mob, 'reg')
  

$("#reg_btn").on 'click', (e) ->
  mob = $('input[name="mobile"]').val()
  if checkMobile(mob) == false
    alert('手机号码不正确')
    return

  pwd = $('input[name="password"]').val()
  pwd2 = $('input[name="password2"]').val()

  if pwd.valueOf() != pwd2.valueOf()
    alert('两次密码不同')
    return

  vcode = $("input[name='code']").val()
  if vcode.length != 4
    alert('验证码错误')
    return

  $.post '/api/sign_up' ,{
    mobile: mob,
    password: pwd,
    code: vcode
    }, (data) ->
      if data.result_code == 1
        hd_alert("success")
      else
        hd_alert(data.error_message)



$("#login_sms_get").on 'click', (e) ->
  mob = $('input[name="mobile"]').val()

  if checkMobile(mob) == false
    alert('手机号码不正确')
    return
  
  func_get_sms(mob, 'login')


$("#code_login_btn").on 'click', (e) ->
  mob = $('input[name="mobile"]').val()
  if checkMobile(mob) == false
    alert('手机号码不正确')
    return

  vcode = $("input[name='code']").val()
  if vcode.length != 4
    alert('验证码错误')
    return  


  $.post '/api/sign_in', {
    mobile: mob,
    code: vcode
    }, (data) ->
      if data.result_code == 1
        hd_alert('success')
        window.location.href = '/wap/user'
      else
        hd_alert(data.error_message)





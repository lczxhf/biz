window.goLotteryCart = (id) ->
  $.post  '/wap/lottery_cart', 
          prize_activity_id:id, 
          (resp)->
            # console.log resp
            location.reload()

window.goBuyLottery = (id) ->
  $.post  '/wap/lottery_cart.json', 
        prize_activity_id:id, 
        (resp)->
          # console.log resp
          location.href = '/wap/lottery_cart'
window.goEvaluate = (id) ->
  location.href = '/wap/prize_activity/'+id+'/evaluate_page'
$ ->
  arr = new Array
  $(".luckyNum").click () ->
    window.location.href = "/wap/prize_activity/"+$(this).attr("target")+"/count_result"
  $(".addPhoto").change (e) ->
    ul = $('.addPhoto').parents('ul')
    if ul.children().size() < 4
      file = e.target.files[0]
      arr.push file
      reader = new FileReader
      reader.onload=() ->
        ul.append '<li><img class="upload_img" src="'+reader.result+'"></li>'
      reader.readAsDataURL file
    else
      alert '最多只能添加三张图片'

  $('.publish').click () ->
    is_publish = if $(".eval-share .selected").html() == '匿名发表' then false else true
    content = $("#content").val()
    form = new FormData
    for a in arr
      form.append('file[]',a)
    form.append('content',content)
    form.append('is_publish',is_publish)
    xhr = new XMLHttpRequest()
    
    xhr.open("post",'evaluate', true)
    xhr.setRequestHeader('X-CSRF-Token',$('meta[name="csrf-token"]').attr('content'))
    xhr.onload = () ->
        result = JSON.parse xhr.responseText
        switch result['resultCode']
          when 1 then window.location.href = "/wap/prize_activity/"+result['resultMsg']+"/award_share"
          when 0 then alert '创建失败'
          when 2 then alert '您不是获奖者!不能评论'
          when 3 then alert '您已评论'
    xhr.send(form);

App.prize_notify = App.cable.subscriptions.create "PrizeChannel",
  connected: (data) ->
    console.log 'conneted'

  received: (data) ->
    console.log data.message.id
    $("div[item-id='#{data.message.id}'] .prize_progress").attr('style', "width: #{data.message.progress}%")
    $("div[item-id='#{data.message.id}'] em.prize_remain").text( data.message.remain)

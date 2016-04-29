window.goBuyLottery = (id) ->
  # location.href = '/wap/lottery_cart'
  console.log id

  #create cart item
  $.post  '/wap/lottery_cart', 
          prize_activity_id:id, 
          (resp)->
            console.log resp

window.goLotteryCart = (id) ->
  $.post  '/wap/lottery_cart.json', 
        prize_activity_id:id, 
        (resp)->
          console.log resp
          location.href = '/wap/lottery_cart'
$ ->
  $(".luckyNum").click () ->
    window.location.href = "/wap/prize_activity/"+$(this).attr("target")+"/count_result"


App.prize_notify = App.cable.subscriptions.create "PrizeChannel",
  connected: (data) ->
    console.log 'conneted'

  received: (data) ->
    console.log data.message.id
    $("div[item-id='#{data.message.id}'] .prize_progress").attr('style', "width: #{data.message.progress}%")
    $("div[item-id='#{data.message.id}'] em.prize_remain").text( data.message.remain)

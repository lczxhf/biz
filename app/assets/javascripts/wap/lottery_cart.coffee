

window.iptNotify = (id) ->
  t = setInterval((->
    sum = 0
    $.each $('input.sdddq'), (index, elem) ->
      sum += parseInt($(elem).val())
      return
    $('span.txt-red').text sum
    clearInterval t
    return
  ), 350)
  return

window.delLotteryCartItem = (id) ->
  hd_alert '确定删除此商品？', 2000, 'confirm', ->
    $.ajax
      url: '/wap/lottery_cart/' + id
      type: 'delete'
      success: (e) ->
        # location.reload();
        $('#item' + id).remove()
        window.iptNotify id
        return
    return
  return

window.submitLottery = ()->
  items = []
  $.each $('input.sdddq'), (index, elem) ->
      item = cart_id:$(elem).parents('li').attr('item-id'), num:parseInt($(elem).val())
      items.push item

  console.log items
  $.post '/wap/lottery_order', 
          {lottery_order: JSON.stringify items}, 
          (resp)->
            console.log resp
            if resp.result_code == '3'
              window.location.href = "/wap/session/new"
            else
              window.location.href = "/wap/lottery_order/" + resp.result_msg + "/pay"
          'json'

getRandom = (n) ->
  Math.floor Math.random() * n + 1


window.inputp =
  indexInput: 0
  addNew: (obj, stepNum) ->
    @initNew obj, stepNum
    @indexInput++
    return
  getDigit: (val, num) ->
    digitNum = 0
    if num.toString().split('.')[1]
      digitNum = num.toString().split('.')[1].length
    if digitNum > 0
      val = val.toFixed(digitNum)
    val
  initNew: (obj, stepNum) ->
    width = obj.width()
    height = obj.height()
    height1 = height
    _root = this
    width += 3
    #height+=0; 
    $('#' + obj.attr('id') + 'l').click ->
      _root.leftDo obj, stepNum
      return
    $('#' + obj.attr('id') + 'r').click ->
      _root.rightDos obj, stepNum
      return
    return
  leftDo: (obj, stepNum) ->
    val = @formatNum(obj.val())
    val = Math.abs(val)
    val -= stepNum
    val = @getDigit(val, stepNum)
    if val < 0
      val = 0
      obj.val 0
    else
      @moveDo obj, val, true, stepNum
    iptNotify obj.attr('id')
    return
  rightDos: (obj, stepNum) ->
    val = @formatNum(obj.val())
    val = Math.abs(val)
    val += stepNum
    val = @getDigit(val, stepNum)
    @moveDo obj, val, false, stepNum
    iptNotify obj.attr('id')
    return
  moveDo: (obj, num, isup, stepNum) ->
    `var isDecimal`
    `var s`
    `var s1`
    `var s1num`
    startTop = 0
    endTop = 0
    if stepNum >= 1
      if num.toString().split('.')[1]
        num = num.toString().split('.')[0]
        obj.val num
    num1 = num
    lens1 = num.toString().length
    divwidth = parseFloat(obj.css('font-size')) / 2
    if isup
      obj.val num1
      isDecimal = false
      i = lens1 - 1
      while i >= 0
        s = num.toString()
        s1 = s.substr(i, 1)
        s1num = parseFloat(s1)
        if s1num != 9 or isNaN(s1num)
          if isNaN(s1num)
            #num=parseFloat(s.substr(i-1,lens1-i));
            #              num++;
            #              num=this.getDigit(num,stepNum);
          else
            num = parseFloat(s.substr(i, lens1 - i))
            num++
            break
        i--
      #num=this.getDigit(num,stepNum)
      startTop = 0
      endTop = -40
    else
      isDecimal = false
      i = lens1 - 1
      while i >= 0
        s = num.toString()
        s1 = s.substr(i, 1)
        s1num = parseFloat(s1)
        if s1num != 0 or isNaN(s1num)
          if isNaN(s1num)
            #num=parseFloat(s.substr(i-1,lens1-i));
            #              num=this.getDigit(num,stepNum);
            isDecimal = true
          else
            num = parseFloat(s.substr(i, lens1 - i))
            break
        i--
      if isDecimal
        num = @getDigit(num, stepNum)
      startTop = 40
      endTop = 0
    if $('#' + obj.attr('id') + 'Num').length < 1
      #background-color:#fff;
      numstr = num.toString()
      widths = divwidth * numstr.length
      stri = '<div id=\'' + obj.attr('id') + 'sy\' style=\'position:relative;width:0px;height:0px\'><div id=\'' + obj.attr('id') + 'Num\' style=\'width:' + widths + 'px;z-index:100;position:absolute;height:' + obj.height() + 'px;top:' + startTop + 'px; line-height:' + obj.height() + 'px;font-family: ' + obj.css('font-family') + ';font-size:' + obj.css('font-size') + ';\'>'
      i = 0
      while i < numstr.length
        nums = numstr.substr(i, 1)
        if nums == '.'
          stri += '<div style=\'float:left;width:' + divwidth + 'px;\'>&nbsp;'
        else
          stri += '<div style=\'float:left;width:' + divwidth + 'px;background-color:#fff\'>'
          stri += nums
        stri += '</div>'
        i++
      stri += '</div></div>'
      $('#' + obj.attr('id') + 'T').prepend stri
      leftOff = 0
      if num1.toString().length - (num.toString().length) > 0
        leftOff = divwidth * (num1.toString().length - (num.toString().length)) / 2
      pz = 0
      if /msie/.test(navigator.userAgent.toLowerCase())
        pz = 1
      if /firefox/.test(navigator.userAgent.toLowerCase())
        pz = 1
      if /webkit/.test(navigator.userAgent.toLowerCase())
      else
      if /opera/.test(navigator.userAgent.toLowerCase())
        pz = 1
      leftpx = obj.width() / 2 + obj.height() - ($('#' + obj.attr('id') + 'Num').width() / 2) + 1 + leftOff + pz
      $('#' + obj.attr('id') + 'Num').css 'left', leftpx
      $('#' + obj.attr('id') + 'Num').animate { top: endTop + 'px' }, 300, ->
        $('#' + obj.attr('id') + 'sy').remove()
        if isup
        else
          obj.val num1
        return
    return
  formatNum: (val) ->
    `var val`
    val = parseFloat(val)
    if isNaN(val)
      val = 0
    val
return




# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

specs_array = []
variant = {}
productId = $(".phtt").attr('data-id')

$(".goods_specs_col a").on 'click', (e)->
  if $(this).hasClass 'disabled'
    return

  $(this).siblings('a').removeClass("selected")
  $(this).toggleClass 'selected'

  optionOk = true
  specs_array = []

  $('.goods_specs_col').each ()->
    id = $(this).find('a.selected').attr('data-id')

    specs_array.push id

    if id == undefined
      optionOk = false
      updateBuyBtn false, '请选择规格'
      return

  if optionOk
    # console.log specs_array
    $.get '/api/product/' + productId + '/get_variant',
          {ids: specs_array}
          (data)->
            if data.result_code == 1
              
              variant = data.variant
              # console.log variant
              $("#sale_price").text variant.price

              updateBuyBtn true
            else
              updateBuyBtn false, '商品库存缺货'
            

updateBuyBtn = (value, info)->
  if value
    $("#btn_cart").removeClass 'disabled'
    $("#btn_cart").text  '加入购物车'
  else
    $("#btn_cart").addClass 'disabled'
    $("#btn_cart").text  info 


$("#btn_cart").on 'click', (e)->
  if $(this).hasClass 'disabled'
    return
  
  $.post '/api/cart',
    {variant_id: variant._id, num: 1, product_id: productId},
    (data)->
      # console.log data
      if data.result_code == 1
        hd_alert '加入购物车成功'
        updateCartBadge data.cart.list.length
      else
        hd_alert data.error_message

updateCartBadge = (num) ->
  if num > 0
    $("#cart_total").show()
    $("#cart_total").text num
  else
    $("#cart_total").hide()

$("#favorite").on 'click', (e)->
    ids = []
    ids.push productId
    $.post '/api/favorite_product',
      {ids: ids},
      (data)->
        if data.result_code == 1
          hd_alert '收藏成功'
          $("#favorite span").text '取消收藏'
        else
          hd_alert data.error_message

#index page

unless gon?
  return

$('#container').waterfall
  debug: false, 
  dataType: 'json',
  path: "/api/product",
  params:  gon.params,

  callbacks:  
    loadingFinished: ($loading, isBeyondMaxPage, data) ->
      cbProduct($loading, isBeyondMaxPage, data)

cbProduct = ($loading, isBeyondMaxPage, data)->
  if  !isBeyondMaxPage
    $loading.fadeOut()
  else 
    $loading.hide()

  _html = ''

  if  !data.list && $('#container').html().length == 0
    $("#waterfall-content").hide()
    $("#waterfall-empty").show()
    return false

  $.each data.list, (items, item) ->
    _html += renderProduct item

  $('#container').append(_html)

  if $('#container').html().length == 0
    $("#waterfall-content").hide()
    $("#waterfall-empty").show()

renderProduct = (item) ->
  _html = ''
  if item.shop_price == undefined
    item.shop_price = "暂无"
  
  if item.price == undefined
    item.price = "暂无"
  
  _html += "<li><a class='goods_list_link' href='/wap/product/#{item._id}'><img src="

  if item.thumb
    _html += "'#{item.thumb}'"     
  else 
    _html += "'/assets/images/nopic.jpg'"

  _html += "class='goods_list_link_img' /></a><p class='wfinfo'><a href='/wap/product/#{item._id}'> #{item.name} </a></p>"
  _html += "<div class='price_con'><span class='products_prices fl'><font>￥#{item.price} </font></span><span class= 'market_prices fl'><font>￥#{item.price} </font></span></div></li>"

  return _html

$('#screening').bind 'click', () ->
  $('#form').submit();

$('.tab_sort').bind 'click', () ->
  key = $(this).attr('key')
  sort = $(this).attr('sort')  

  url = "/wap/product?key=#{key}&sort=#{sort}&category=#{gon.params.category}"
  location.href = url
  

$(".goods_list_link img").lazyload { effect: "fadeIn" }

if gon?
  key =  gon.params.key || 'u_at' 
  $("a.tab_sort[key='" + key + "'] ").addClass('hover')




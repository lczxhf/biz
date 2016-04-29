# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(".btnF span").click (e)->
    if $(this).hasClass 'hover'
      $(this).removeClass 'hover'
      $(".shop em").removeClass("hover")
      $("dl.shop").removeClass('selected')
    else
      $(this).addClass 'hover'
      $(".shop em").addClass("hover")
      $("dl.shop").addClass('selected')

    if ($(".shop em.hover").length == $(".shop em").length) 
      $(".btnF span").addClass("hover");   

    updateCart()           

$(".shop em").click (e)->
    if $(this).hasClass 'hover'
      $(this).removeClass 'hover'
      $(this).parents("dl.shop").removeClass('selected')
      $(".btnF span").removeClass("hover")
    else
      $(this).addClass 'hover'    
      $(this).parents("dl.shop").addClass('selected')

    if ($(".shop em.hover").length == $(".shop em").length) 
      $(".btnF span").addClass("hover");    

    updateCart()

carts = []

updateCart = ()->
  carts = []
  nums = total = 0

  $("dl.shop.selected").each (i, item)->
      num = parseInt($(this).attr('data-num'))
      price = parseFloat($(this).attr('data-price'))
      total += num * price
      nums = nums +  num;

      cartLine = { num: num, variant_id: $(this).attr('data-id')}
      carts.push cartLine

  $("#total").text(total);
  $("#nums").text(nums);

  if(nums < 1) 
    $("#btn_buy").removeClass('hover').addClass('disabled');
  else 
    $("#btn_buy").removeClass('disabled').addClass('hover');

  console.log carts  


$('input.goods_num[type=number]').blur (e)->
  if ($(this).val().length < 1) 
    hd_alert('请输入购买数量');
    $(this).focus();
    return;

  num = parseInt($(this).val());
  if (num < 1) 
    num = 1;

  $(this).val(num)
  $(this).parents('dl.shop').attr('data-num', num)
  updateCart()
  

$(".delCart").on 'click', (e)->
  data_id = $(this).parents("dl.shop").attr('data-id')

  hd_alert '确定删除此商品？',2000,'confirm', ()->
      $.ajax (
        url: '/api/cart/dft',
        type: 'delete',
        data: {variant_id: data_id},
        success: (e)->
          location.reload()
        )

updateCart()

$("#btn_buy").on 'click', (e)->
  $.post '/api/temp_order',
      temp_order: carts,

      (data)->
        location.href = '/wap/order/new'    


  # storage.carts = JSON.stringify carts


  



# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$("#btn_order").on 'click', ()->

  address_id = $("#default_address").attr 'data-address_id'
  if address_id == undefined
    hd_alert '没有收货地址'
    return

  $.post '/api/order',
    { remark: $("input[name='remark']").val(), address_id: address_id, shipping_type: $("select.shipping").val()},
    (data)->
      console.log data
      location.href = '/wap/order/' + data.order._id + "/pay"

$("select.shipping").on 'change', ()->
  $.post '/api/temp_order',
    {shipping_type: $(this).val(), type: 'put'},
    (e)->
      location.href = '/wap/order/new' 
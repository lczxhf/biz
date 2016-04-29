# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$("#province").on 'change', (e)->
  $('#city').html('<option value="-1">选择城市</option>');
  $('#district').html('<option value="-1">选择地区</option>');

  code = this.options[this.selectedIndex].value
  $.get '/china_city/list?code=' + code, (data)->
    data.forEach (item)->
      $('#city').append('<option value="'+item.code+'">'+item.name+'</option>')


$("#city").on 'change', (e)->
  $('#district').html('<option value="-1">选择地区</option>');

  code = this.options[this.selectedIndex].value
  $.get '/china_city/list?code=' + code, (data)->
    data.forEach (item)->
      $('#district').append('<option value="'+item.code+'">'+item.name+'</option>')

$(".select_goods_address").on 'click', (e)->
  address_id =  $(this).attr("data-id")
  $.post '/api/temp_order',
    {address_id: address_id, type: 'put'},
    (e)->
      location.href = '/wap/order/new'      

  
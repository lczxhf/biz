 //= require address_select

$(function(){
  $('.otp-button-remove').click(function(){
    removeSearch($(this));
  });
  $('.otp-button-add').click(function(){
    addSearch($(this));
  });

  $('.search_list ul li:first a.otp-button-remove').hide(); // 隐藏第一个减号按钮
});

function autoSearch(element, type) {
  var value = $.trim($(element).val());
  if(value.length == 0)
    return;

  setSelectedValue(element, ''); // 先清除设置的ID
  var className = $(element).attr('model-class');
  var url = "/site/search.json?type=" + type + "&class=" + className;
  $(element).autocomplete({
    source:url,
    select:function(event, ui) {
      alert(ui.item.value);
      $(element).val(ui.item.label);
      setSelectedValue(element, ui.item.value);
      setSelectedAttributes(ui.item.item, className);
      return false;
    }
  });
}

function multiSearch(element, type) {
  var value = $.trim($(element).val());
  if(value.length == 0)
    return;

  var className = $(element).attr('model-class');
  var url = "/site/search.json?type=" + type + "&class=" + className;
  $(element).autocomplete({
    source:url,
    select:function(event, ui) {
      $(element).val(ui.item.label);
      $(element).attr('selected-value', ui.item.value);
      var idsStr = makeMutiSearchValue(element);
      setSelectedValue(element, idsStr);
      return false;
    }
  });
}

function removeSearch(element) {
  var input = $(element).prev().prev();
  var value = $(input).attr('selected-value');
  if (value) {
    $(input).attr('selected-value', '');
  };
  setSelectedValue(input, makeMutiSearchValue(input));
  $(element).parent().remove();
}

function addSearch(element) {
  var li = $(element).parent();
  var html = $(li).html();
  $(li).after('<li>' + html + '</li>');
  var new_li = $(li).next();
  $(new_li).children('.otp-button-remove').click(function(){ removeSearch($(this)); });
  $(new_li).children('.otp-button-add').click(function(){ addSearch($(this)); });
  $(new_li).children('.otp-button-remove').show();
}

function setSelectedValue(source_element, value) {
  var id = $(source_element).attr('id') + '_hidden';
  $("#" + id).val(value);
}

function getCurrentValue(source_element) {
  var id = $(source_element).attr('id') + '_hidden';
  return $("#" + id).val();
}

function makeMutiSearchValue(input) {
  var ul = $(input).parent().parent();
  ret = [];
  $(ul).children().each(function(index, item) {
    var inputItem = $(item).children()[0];
    var value = $(inputItem).attr('selected-value');
    if (value) { ret.push(value); }
  });
  return ret.join(',');
}

function setSelectedAttributes(obj, className) {
  if (className == 'Product') {
    selectProduct(obj);
  }
  if (className == "SaleProduct") {
    selectSaleProduct(obj);
  };
}

function test(element) {
    var value = $.trim($(element).val());
    alert(value);
}

function selectProduct(product) {
  $('#sale_product_name').val(product.name);
  $('#sale_product_price').val(product.price);
  $('#sale_product_ori_price').val(product.price);
  $('#sale_product_score').val(0);
  $('#sale_product_bean').val(0);
  $('#sale_product_gift_score').val(0);
  $('#sale_product_gift_cash').val(0);
}

function selectSaleProduct(sale_product) {
  $('#weixin_product_name').val(sale_product.name);
  $('#weixin_product_price').val(sale_product.price);
  $('#weixin_product_score').val(sale_product.score);
}


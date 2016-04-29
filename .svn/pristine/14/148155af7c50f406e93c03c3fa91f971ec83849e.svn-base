(function() {

  var ajaxFormAct;

  ajaxFormAct = function(e) {
    e.preventDefault();

    var form, formData, uri;
    form = $(".form-horizontal");

    if (form == undefined) return;
    var chosen_result = $("ul.chosen-choices li.search-choice span");

    var chosen_name = [];
    chosen_result.map(function(index){
      // console.log(selected[index]);
      // console.log(chosen_result[index].innerText);

      chosen_name.push(chosen_result[index].innerText);
    });

    console.log(chosen_name);
    _input = document.createElement("input");
    _input.setAttribute("name", "product[brands]");
    _input.setAttribute("value", chosen_name);


    $(".form-horizontal").appendChild(_input);
    
    return;

    uri = form.attr("action");
    formData = form.serializeArray();
    $.post(uri, formData, function(data, status) {
      // $('.alert-success').removeClass('hidden');
      // $(".alert-tips").text("发送成功");
      // return setTimeout(function() {
      //   return $('button.close').click();
      // }, 3000);
    });
  };

  var _init = function() {
    $("#button-submit").on("click", function(e) {
        ajaxFormAct(e);
    });

  };
  
  $(document).ready(function() {
    return _init();
  });

}).call(this);



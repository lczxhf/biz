$(document).ready(function($) {
  $('#unity_scan_product').autocomplete({
    serviceUrl: '/site/search',

    onSelect: function (suggestion) {    
      var form = $(".simple_form");
      if (form == undefined) return;
      _input = document.createElement("input");
      _input.setAttribute("name", "unity_scan[product_id]");
      _input.setAttribute("value", suggestion.data);
      _input.setAttribute("class", "hide");
      form.append(_input);
    },

    paramName: 'term',
    params: {"class": "product"},
    dataType: "json",

    transformResult: function(response) {      
        return {          
            suggestions: $.map(response, function(dataItem) {
                return { value: dataItem.name, data: dataItem._id };
            })
        };
    }
  });  
});


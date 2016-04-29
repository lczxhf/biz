

function selectChanged(code, element) {
    if (!code) {
        $(element).nextAll().remove();
        return;
    }
    var cityListUrl = '/china_city/list';
    $.get(cityListUrl, {code:code}, function(result, status){
        if (result.length == 0) {
            return;
        };
        $(element).nextAll().remove();
        $(element).nextAll().remove();
        html = makeNextSelect(element, result);
        $(element).after(html);
        $(element).next().change(selectChangeHandler);
    }, 'json');
}

function makeNextSelect(element, list) {
    var html = '<select id="' + makeNextID(element) + '"';
    html += ' class="' + makeNextClass(element) + '"';
    html += ' name="' + makeNextName(element) + '"';
    html += '>';
    html += makeSelectOptions(getNextType(element), list, null);
    html += "</select>";
    return html;
}


function makeSelectOptions(type, list, defaultCode) {
    html = '<option value="">' + makePrompt(type) + '</option>';
    $.each(list, function(index, item){
        html += '<option value="' + item.name + '"';
        if (defaultCode == item.code) {
            html += ' selected="selected"'
        }
        html += ' code="' + item.code + '">';
        html += item.name;
        html += '</option>'
    });
    return html;
}

function makePrompt(type) {
    if (type == 'province') {
        return '--省/市--';
    }
    else if(type == 'city') {
        return '--城市--';
    }
    else if(type == 'dist') {
        return '--区/县--';
    }
    return '--请选择--';
}

function getCurrentType(element) {
    var items = $(element).attr('id').split('_');
    var type = '';
    return items[items.length - 1];
}

function getNextType(element) {
    var type = '';
    var lastName = getCurrentType(element);
    if (lastName == 'province') {
        if (needSliceToDistrict()) {
            type = 'dist';
        }
        else {
            type = 'city';
        }
    }
    else if(lastName == 'city') {
        type = 'dist';
    }
    return type;
}


function makeNextID(element) {
    var items = $(element).attr('id').split('_');
    var type = getNextType(element);
    return items.slice(0, items.length - 1).join('_') + '_' + type;
}

function makeNextClass(element) {
    var type = getNextType(element);
    return 'city-select city-' + type;
}

function makeNextName(element) {
    var type = getNextType(element);
    var name = $(element).attr('name');
    return name.replace(getCurrentType(element), type);
}

function initArress() {
    if ($('.city-select').length == 0)
        return;

    $('.city-select').each(function(index, element){
       
        var type = getCurrentType(element);
        var defaultValue = $('#' + type + '_default').val();
        if (defaultValue) {
            initSelectByName(element, defaultValue, '/china_city/neighbourList');
        }
        else if (type == 'province') {
            initSelectByCode(element, null, '/china_city/list');
        }
        else {
            var name = $(element).prev().val();
            if (!name) {
                return;
            };
            initSelectByName(element, name, '/china_city/list');
        }
    });
}

function initSelectByName(element, name, url) {
    var getItemUrl = '/china_city/get_item_by_name';
    $.get(getItemUrl, {name:name}, function(result, status){
        if (result) {
            initSelectByCode(element, result.code, url)
        }
    }, 'json');
    
}

function initSelectByCode(element, code, url) {
    var params = {};
    if (code) {
        params['code'] = code;
    };
    $.get(url, params, function(result, status){
        html = makeSelectOptions(getCurrentType(element), result, code);
        $(element).html(html);
    }, 'json');
}

function selectChangeHandler(event){
    var element = event.target;
    var code = getSelectedCode(element);
    selectChanged(code, element);
}

function getSelectedCode(element) {
    var value = $(element).val();
    var option = $(element).children("[value='" + value + "']:first");
    return $(option).attr('code');
}

function needSliceToDistrict() {
    var code = getSelectedCode($('.city-province'));
    return ['110000', '120000', '310000', '500000'].indexOf(code) >= 0;
}

$(function(){

    $('.city-group').children('select').each(function(index, element){
        var type = getCurrentType(element);
        $(element).addClass('city-select');
        $(element).addClass('city-'+type);
    });

    initArress();

    $('.city-select').change(selectChangeHandler);
});

var current_level = 0;

$(".select-items").change(function(e) {
  // console.log(".select-items:" + e.target.id);
  trigger(e);
});

function trigger(e){
 var query_str = "#"+ e.target.id + " option:selected";
    // console.log($(query_str).text());
    var pid = $(query_str).val();
    remote_fetch(pid);
}

function remote_fetch(pid){
  $.get("/api/category?pid="+ pid,
    function(json) {   

      if(json["result_code"] != 1){
        console.log("return by result code");
        return;
      }

      if(json["list"].length == 0){
        current_level = json["level"];
        // console.log("no child data, level " + current_level);
        remove_child_gte_level(current_level + 1);

        insert_category_id();
        return;
      }

      items = [];
      json["list"].map (function(item){
        // console.log(item.name);
        current_level = item.level;
        items.push({"name": item.name, "value": item._id});
      });    

      create_child(current_level, items);
      insert_category_id();
    }
  );  
}

function remove_child_gte_level(level){
  var to_remove_level = parseInt(level);
  var to_remove_node = document.getElementById("select-level-" + level);

  while (to_remove_node != undefined){

    document.getElementById("select-children").removeChild(to_remove_node);
    // console.log("removed level " + to_remove_level);
    to_remove_level++;
    to_remove_node = document.getElementById("select-level-" + to_remove_level);
  }
}

function create_child(level, items){  
  var next_selector = document.createElement("select");

  remove_child_gte_level(level);

  next_selector.id = "select-level-" + level;
  // next_selector.className += "cat-select";
  next_selector.setAttribute("level", level);
  // next_selector.setAttribute("multiple":"multiple");

  remote_fetch(items[0]["value"]);

  items.map(function(item){
    // console.log(item["value"]);
    next_selector.add(new Option(item["name"], item["value"]));  
    document.getElementById("select-children").appendChild(next_selector);  

    $("#"+next_selector.id).change(function(e){    
      // console.log(e.target.id);
      trigger(e);
    });
  });
};

$("#show-select").click(function(e){
  // console.log("button>" + $("#select-level-"+ current_level).val());
  insert_category_id();
});

function insert_category_id(){
  
  var _input = document.getElementById("input-category-id");
  var category_id = $("#select-level-"+ current_level).val();

  if (_input == undefined){    
    _input = document.createElement("input");
    _input.setAttribute("value", category_id);
    _input.setAttribute("type", "hidden");
    _input.setAttribute("name", "product[category_id]");
    _input.setAttribute("id", "input-category-id");

    document.forms[1].appendChild(_input);      
    // console.log("insert id level:" + current_level + "cat_id: " + category_id);
  }else{
    _input.setAttribute("value", category_id);
    // console.log("insert id level:" + current_level + "cat_id: " + category_id);
  }
}

// console.log($("#select-level-0").val());

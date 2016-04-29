
  (function() {
    function init(){
      var map, marker;
      var city_name;
      var geolocation;

      map = new BMap.Map("allmap");  

      city_name = "深圳";
      map.centerAndZoom(city_name,12);

      geolocation = new BMap.Geolocation();

      var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_TOP_LEFT});// 左上角，添加比例尺
      var top_left_navigation = new BMap.NavigationControl();  //左上角，添加默认缩放平移控件
      var top_right_navigation = new BMap.NavigationControl({anchor: BMAP_ANCHOR_TOP_RIGHT, type: BMAP_NAVIGATION_CONTROL_SMALL});

      var navigationControl = new BMap.NavigationControl({
        // 靠左上角位置
        anchor: BMAP_ANCHOR_TOP_LEFT,
        // LARGE类型
        type: BMAP_NAVIGATION_CONTROL_LARGE,
        // 启用显示定位
        enableGeolocation: true
      });
      map.addControl(navigationControl);

      // 添加定位控件

      /*
      var geolocationControl = new BMap.GeolocationControl();
      geolocationControl.addEventListener("locationSuccess", function(e){
        // 定位成功事件
        var address = '';
        address += e.addressComponent.province;
        address += e.addressComponent.city;
        address += e.addressComponent.district;
        address += e.addressComponent.street;
        address += e.addressComponent.streetNumber;
        // alert("当前定位地址为：" + address);

        city_name = e.addressComponent.city;
        //map.centerAndZoom(city_name,14);  
      });

        map.addControl(geolocationControl);
      */
      
      var shop_point = new BMap.Point(parseFloat("#{@item.loc[1]}"), parseFloat("#{@item.loc[0]}"));      

      // map.centerAndZoom(shop_point,12);  
      create_marker(shop_point);

      var geoc = new BMap.Geocoder();    

      var select_point;

      map.addEventListener("click", function(e){        
        select_point = e.point;

        geoc.getLocation(select_point, function(rs){
          var addComp = rs.addressComponents;
          //alert(addComp.province + ", " + addComp.city + ", " + addComp.district + ", " + addComp.street + ", " + addComp.streetNumber);
          create_marker(select_point);
        });        
      });
      

      function create_marker(point){
        map.clearOverlays();

        marker = new BMap.Marker(point);// 创建标注
        map.addOverlay(marker); 

        console.log("create_marker " + point.lng + "," + point.lat); 

        $("#lng").attr("value", point.lng);
        $("#lat").attr("value", point.lat);

        map.centerAndZoom(point,16);  
        //marker.enableDragging();
        //marker.setAnimation(BMAP_ANIMATION_BOUNCE);

        marker.addEventListener("click",onDragMarker);
        function onDragMarker(){
          var p = marker.getPosition();  //获取marker的位置
          console.log("marker的位置是" + p.lng + "," + p.lat); 
        }  
      };
    }

    $(document).ready(function() {
      return init();
    });

  }).call(this);       
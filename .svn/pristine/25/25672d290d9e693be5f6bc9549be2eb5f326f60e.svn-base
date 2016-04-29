/* 确认收货 */
function _confirm(id) {
    hd_alert("确定该操作吗？" , 2000 , 'confirm' , function() {
        $.post("/api/order/" + id + "/confirm", function(ret) {
        	if(ret.result_code == 1) {
        		location.reload();
        		return true;
        	} else {
        		hd_alert(ret.error_messagefo);
        		return false;
        	}
        }, 'JSON')
    })
}

/* 取消订单 */
function _cancel(id) {
    hd_alert("确定取消该订单吗？" , 2000 , 'confirm' , function() {
        $.get("/api/order/" + id + "/cancel",  function(ret) {
            if(ret.result_code == 1) {
                location.reload();
                return true;
            } else {
                hd_alert(ret.error_message);
                return false;
            }
        }, 'JSON')
    })
}


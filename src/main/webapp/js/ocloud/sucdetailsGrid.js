Date.prototype.format = function(format) {
    var o = {
        "M+": this.getMonth() + 1, // month
        "d+": this.getDate(), // day
        "h+": this.getHours(), // hour
        "m+": this.getMinutes(), // minute
        "s+": this.getSeconds(), // second
        "q+": Math.floor((this.getMonth() + 3) / 3), // quarter
        "S": this.getMilliseconds()
        // millisecond
    }
    if (/(y+)/.test(format))
        format = format.replace(RegExp.$1, (this.getFullYear() + "")
            .substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(format))
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
    return format;
}
function formatDatebox(value) {
 if (value == null || value == '') {
     return '';
 }
 var dt;
 if (value instanceof Date) {
     dt = value;
 } else {

     dt = new Date(value);

 }

 return dt.format("yyyy-MM-dd hh:mm:ss"); //扩展的Date的format方法(上述插件实现)
}


function getAPDevice(Url,model_id,range_id){
	loadGrid(Url,model_id,range_id);  
  //得到  studentTable 表格中的 分页对象
	var pager = $('#cgdata').datagrid('getPager');
	pager.pagination({
		onSelectPage:function(pageNumber, pageSize){
			pageCG(model_id,range_id,pageNumber,pageSize);
		
		}
	});
}

	//调用后台 业务 进行查询
	function pageCG(Url,model_id,range_id,pageNumber, pageSize){
		$.ajax({
			   type: "POST",
			   url:Url+"/device/getAPDevice",
			   data:"model_id=" + model_id + "&range_id="+ range_id+"&pageNumber="+pageNumber+"&pageSize="+pageSize,
			   success: function(data){
					if(data.rows!=null){
						$('#cgdata').datagrid("loadData",data); 
					}
			   }
			   
		});
	}
	
	function loadGrid(Url,model_id,range_id){  
		$('#cgdata').datagrid({
			width:'620px',
			url:Url+'/device/getAPDevice?model_id='+model_id+'&range_id='+range_id,
		    method: 'POST',
		    loadMsg:'数据加载中请稍后……',  
		    striped: true,
		    singleSelect: true, //true ：只能选一行 false： 选多行
		    rownumbers: true, 
		    pagination:true,
		    frozenColumns:[[
							{title:"序列号",field:'device_serial',align: 'center',width:"100px"}
							]],
		    pageList: [5,10, 20, 50, 100, 150],
		    nowrap: true,
		    showFooter: true,	
			columns:[
			         [
			          {field:'device_id',title:'设备ID',align: 'center',width:"200px"},
			          {field:'device_key',title:'设备Key',align: 'center',width:"100px"},
			          {field:'updated_at', formatter: formatDatebox,title:'最后接入时间',align: 'center',width:"200px"}
			          ]]
		});
		};
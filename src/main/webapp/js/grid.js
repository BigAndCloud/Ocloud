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




function getModelDevPro(URLL){
          $('#cgdata').datagrid({
              view: detailview,
              detailFormatter:function(index,row){
                  return '<div class="ddv" style="padding:5px 0"></div>';
              },
              width:'800px',
              height:'400px', 
      		url:URLL+'/deviceModel/mdp',
      		fitColumns:true,
      	    method: 'POST',
      	    loadMsg:'数据加载中请稍后……',  
      	    striped: true,
      	    fitColumns: true,
      	    singleSelect: false,
      	    rownumbers: true, 
      	    pagination:true,
      	  scrollbarSize :0,
      	    pageList: [5,10, 20, 50, 100, 150],
      	    nowrap: false,
      	    showFooter: true,	
      		columns:[
      		         [
						{title:"模型名称",field:'model_name',align: 'center'},
      		          {field:'model_id',title:'模型ID',align: 'center'},
      		          {field:'comment',title:'模型描述',align: 'center'},
      		        {field:'device.name',title:'设备名称',align: 'center',
      		        	formatter: function (value, row) {
      		              return row.device.name;}},
      		         {field:'device.site',title:'设备地址',align: 'center',
            		  	formatter: function (value, row) {
            		      return row.device.site;}},
       		         {field:'device.alive_time',title:'活跃时间',align: 'center',
              		  	formatter: function (value, row) {
              		      return row.device.alive_time;}},
          		    {field:'device.comment',title:'设备备注',align: 'center',
                		  	formatter: function (value, row) {
                		      return row.device.comment;}},
      		          ]],
      		      
              onExpandRow: function(index,row){
            	  var ddv = $(this).datagrid('getRowDetail',index).find('div.ddv');
            	  if (row.property==null) {
            		  ddv.datagrid('getExpander', index).hide();
				}else{
					
					  ddv.datagrid({
		                  	 fitColumns:true,   
		       	            singleSelect:true,   
		       	            loadMsg:'',   
		       	            height:'auto',  
		       	           url:URLL+'/deviceModel/getPro?model_id='+row.model_id,
		       	           columns:[[
		       	                     {field:'name',title:'属性名称',align: 'center', width:'200px'},
									{field:'alias',title:'属性别名',align: 'center', width:'200px'},
		       	                  {field:'created_at',title:'创建时间',formatter: formatDatebox,align: 'center', width:'200px'}
		      		             ]],
		           	           onResize:function(){   
		         	                $('#cgdata').datagrid('fixDetailRowHeight',index);   
		         	            },   
		         	            onLoadSuccess:function(){   
		                          
		         	                setTimeout(function(){   
		         	          
		         	                	$('#cgdata').datagrid('fixDetailRowHeight',index); },1);   
		         	                	
		         	            }  ,
		                      		onLoad:function(){
		                          $('#cgdata').datagrid('fixDetailRowHeight',index);
		                      }
		                  });
		                  
		                  $('#cgdata').datagrid('fixDetailRowHeight',index);
				}
              }
//             ,  onLoadSuccess: function (data) {
//	                //datagrid头部 table 的第一个tr 的td们，即columns的集合
//	                var headerTds = $(".datagrid-header-inner table tr:first-child").children();
//	                //datagrid主体 table 的第一个tr 的td们，即第一个数据行
//	                var bodyTds = $(".datagrid-body table tr:first-child").children();
//	                var totalWidth = 0; //合计宽度，用来为datagrid头部和主体设置宽度
//	                //循环设置宽度
//	                bodyTds.each(function (i, obj) {
//	                    var headerTd = $(headerTds.get(i));
//	                    var bodyTd = $(bodyTds.get(i));
//	                    $("div:first-child", headerTds.get(i)).css("text-align", "center");
//	                    var headerTdWidth = headerTd.width(); //获取第i个头部td的宽度
//	                    //这里加5个像素 是因为数据主体我们取的是第一行数据，不能确保第一行数据宽度最宽，预留5个像素。有兴趣的朋友可以先判断最大的td宽度都在进行设置
//	                    var bodyTdWidth = bodyTd.width() + 5;
//	                    var width = 0;
//	                    //如果头部列名宽度比主体数据宽度宽，则它们的宽度都设为头部的宽度。反之亦然
//	                    if (headerTdWidth > bodyTdWidth) {
//	                        width = headerTdWidth;
//	                        bodyTd.width(width);
//	                        headerTd.width(width);
//	                        totalWidth += width;
//	                    } else {
//	                        width = bodyTdWidth;
//	                        headerTd.width(width);
//	                        bodyTd.width(width);
//	                        totalWidth += width;
//	                    }
//	                });
//	                var headerTable = $(".datagrid-header-inner table:first-child");
//	                var bodyTable = $(".datagrid-body table:first-child");
//	                //循环完毕即能得到总得宽度设置到头部table和数据主体table中
//	                headerTable.width(totalWidth);
//	                bodyTable.width(totalWidth);
//	                bodyTds.each(function (i, obj) {
//	                    var headerTd = $(headerTds.get(i));
//	                    var bodyTd = $(bodyTds.get(i));
//	                    var headerTdWidth = headerTd.width();
//	                    bodyTd.width(headerTdWidth);
//	                });
//	            }
              
          });
      };
 

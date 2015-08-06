<%@page import="com.ourselec.ocloud.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style type="text/css">
input,button{
	width: 150px;
};
.notnull{
	color: red;
};

</style>	
   <link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/demo/demo.css">
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" src="http://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="http://www.jeasyui.com/easyui/datagrid-detailview.js"></script>
<script type="text/javascript">	



<% 
String errormsg = (String)request.getAttribute("errormsg");
if(!StringUtil.isEmpty(errormsg)) {
%>
function showerror() {
	Dialog.alert("<%=errormsg%>");
}
$(document).ready(function() {
	showerror();
});
<%	
}
%>	

function deleteproperty(id){
	if(!window.confirm("确定要删除吗？")){
		return ;
	}
	window.location.href = "<%=request.getContextPath()%>/property/deleteproperty?id="+id;
}



</script>	
<script type="text/javascript">
        $(function(){
            $('#cgdata').datagrid({
                view: detailview,
                detailFormatter:function(index,row){
                    return '<div class="ddv" style="padding:5px 0"></div>';
                },
                width:'800px',
                height:'auto', 
        		url:'<%=request.getContextPath()%>/device/getAPDevice?model_id=Ari&range_id=1',
        		fitColumns:true,
        	    method: 'POST',
        	    loadMsg:'数据加载中请稍后……',  
        	    striped: true,
        	    fitColumns: true,
        	    singleSelect: false,
        	    rownumbers: true, 
        	    pagination:true,
        	
        	    pageList: [5,10, 20, 50, 100, 150],
        	    nowrap: true,
        	    showFooter: true,	
        		columns:[
        		         [
  						{title:"序列号",field:'device_serial',align: 'center'},
        		          {field:'device_id',title:'设备ID',align: 'center',width:'200px'},
        		          {field:'updated_at',title:'最后接入时间',align: 'center',width:'200px'}
        		          ]],
                
                onExpandRow: function(index,row){
                    var ddv = $(this).datagrid('getRowDetail',index).find('div.ddv');
                    ddv.datagrid({
                    	 fitColumns:true,   
         	            singleSelect:true,   
         	            loadMsg:'',   
         	            height:'auto',  
         	           url:'<%=request.getContextPath()%>/device/getDeviceDetails?device_id='+row.device_id,
         	           columns:[[   
             	                {field:'device_key',title:'Order ID',width:100},   
             	                {field:'device_id',title:'Quantity',width:100},   
             	                {field:'name',title:'Unit Price',width:100}   
             	            ]],
             	           onResize:function(){   
           	                $('#cgdata').datagrid('fixDetailRowHeight',index);   
           	            },   
           	            onLoadSuccess:function(){   
           	                setTimeout(function(){   
           	                    $('#cgdata').datagrid('fixDetailRowHeight',index);   
           	                },0);   
           	            }  ,
                        		onLoad:function(){
                            $('#cgdata').datagrid('fixDetailRowHeight',index);
                        }
                    });
                    
                    $('#cgdata').datagrid('fixDetailRowHeight',index);
                }
            });
        });
    </script>
    
</head>

<body>
  <table id="cgdata" style="width:700px;height:250px"
            title="DataGrid - Expand Row"
>
            </table>
	

</body>
</html>
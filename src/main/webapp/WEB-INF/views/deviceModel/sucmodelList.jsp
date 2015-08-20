<%@page import="com.ourselec.ocloud.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/default.css">
<style type="text/css">
input,button{
	width: 150px;
};
.notnull{
	color: red;
};

</style>		
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Dialog.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/timezone.js"></script>	
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

function addProperty(model_id){
	var d = new Dialog("添加属性","property/addpropertyPage?model_id="+model_id,500,200);
	d.show();
}

</script>	

</head>

<body>
<div class="sensor-div">
	<h1 align="left" style="padding-left: 40px;">审核成功的设备模板列表</h1>
				<hr style="border:1px dashed #c0c0c0;border-bottom:0;border-right:0;
           border-left:0;width:95%;">
           <br/>
<form action="<%=request.getContextPath()%>/deviceModel/modelListDeve" method="post" id="form1">
	
	
	<table width="100%" id="t" cellspacing="0" cellpadding="2" class="dataTable" align="center">
		<tbody>
				<tr class="dataTableHead">
					
					<td>模板名称，ID</td>
					<td >创建时间</td>
					<td>设备名称，ID</td>
					<td >设备地址</td>
					<td >活跃时间</td>
					<td >设备备注</td>
					
					<td >详情</td>
						
					</tr>					
				<c:forEach items="${list}" var="model" varStatus="num">
				<tr>
				
					<td title="进入详情页面" >
					<a href="<%=request.getContextPath()%>/deviceModel/modelInfo?model_id=${model.model_id}">${model.model_name}(${model.model_id})</a></td>
					
					<td title="${model.created_at}" >
					<fmt:formatDate value="${model.created_at}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
					<td> ${model.device.name}(${model.device.alias})</td>
					<td> ${model.device.site}</td>
					<td> ${model.device.alive_time}</td>
					<td> ${model.device.comment}</td>
					
					<td>
					<a href="<%=request.getContextPath()%>/deviceModel/modelInfo?model_id=${model.model_id}">模型详情</a>
					<c:if test="${'1' eq model.device.pros }">
					<a href="<%=request.getContextPath()%>/deviceModel/sucdetailsListPage?model_id=${model.model_id}">生产设备</a></c:if>
					<c:if test="${'0' eq model.device.pros}"><a href="javascript:addProperty('${model.model_id}')">增加属性/通道</a></c:if>
					</td>
					</tr>
 									
				</c:forEach>
		
	</tbody>
	</table>
	


</form>
</div>
</body>
</html>
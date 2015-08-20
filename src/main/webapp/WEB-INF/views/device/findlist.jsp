<%@page import="com.ourselec.ocloud.util.BaiDuUtil"%>
<%@page import="com.ourselec.ocloud.util.StringUtil"%>
<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/default.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/map/jQuery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/map/map.js"></script> 
<script type="text/javascript"src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Dialog.js"></script>	
<style type="text/css">
.t1{
position: absolute;
}

</style>
</head>
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
<%

%>

// Y.Lei

function addProperty(model_id){
	var d = new Dialog("添加属性","property/addpropertyPage?model_id="+model_id,500,400);
	d.show();
}
</script>
<body>
<!-- <table  class="t1" border="1px" cellpadding="0" cellspacing="0" style=" margin-left:50px;   height:100%;border-left-style:solid; border-bottom-style:none;border-right-style:none;border-top-style:none"></table> -->
	<div class="sensor-div">
			<h2 align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;测试设备原型列表</h2>
			<hr style="border:1px dashed #c0c0c0;border-bottom:0;border-right:0;
           border-left:0;width:95%;">

				<form action="<%=request.getContextPath()%>/device/findlist" method="post" >
					<table  align="center">
						<tbody>
						<tr class="dataTableHead">
						<th>名称</th>
						<th>时区</th>
						<th>地点</th>
						<th>描述</th>
						<th>是否已接入</th>
						<th>操作</th> 
					</tr>
							
								<c:forEach items="${list}" var="device" varStatus="num">
									<tr>
										<td title="${device.name}${device.alias}" >
										
										<a href="<%=request.getContextPath()%>/device/getdevice?source_id=${device.device_id}">${device.name}(${device.alias})</a></td>
										<td title="${device.timezone}">${device.timezone}</td>
										
										<td title="${device.site}">${device.site}</td>
										
										<td title="${device.comment}">${device.comment}</td>
										<td title="${device.is_activated}" >
										<c:if test="${device.is_activated == 0}"  >未接入</c:if>
										<c:if test="${device.is_activated == 1}"  >已接入</c:if>
										</td>
										<td class="operate" >
									
										<a  href="<%=request.getContextPath()%>/device/indevice?id=${device.id}">编辑</a>
										<c:if test="${'0' eq device.pros}"><a  href="javascript:addProperty('${device.model_id}')">增加属性/通道</a></c:if>
										<c:if test="${'1' eq device.pros}"><a  href="<%=request.getContextPath()%>/property/propertylistPage?model_id=${device.model_id}">查看属性/通道</a></c:if>
										
										
										 </td>
 									</tr>
 									
								</c:forEach>
								
							<tr>
							</tr>
							
						</tbody>
					</table>
					</form>
	</div>
</body>
</html>
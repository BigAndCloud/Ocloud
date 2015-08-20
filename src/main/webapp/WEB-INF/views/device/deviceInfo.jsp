<%@page import="com.ourselec.ocloud.util.StringUtil"%>
<%@page import="com.ourselec.ocloud.util.BaiDuUtil"%>
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

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Dialog.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ocloud/proChanGrid.js"></script>	
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

</script>
<body>
	<div class="sensor-div">
	<h1 align="left" style="padding-left: 40px;">Device 信息</h1>
				<hr style="border:1px dashed #c0c0c0;border-bottom:0;border-right:0;
           border-left:0;width:95%;">
					<table width="100%" cellspacing="0" cellpadding="2" align="center"
						class="dataTable">
						<tbody>
						<tr >
					</tr>
									<tr>
										<td>名称</td><td>${dto.device.name}(${dto.device.alias})</td>
									</tr><tr>	
										<td>时区</td> <td >${dto.device.timezone}</td>
									</tr><tr>
										<td>地点</td><td >${dto.device.site}</td>
									</tr><tr>	
										<td>创建时间</td><td>${dto.created_at}</td>
									</tr><tr>	
										<td>描述</td><td>${dto.device.comment}</td>
										</tr><tr>
										<td>是否已接入</td><td>
										<c:if test="${dto.device.is_activated == 0}"  >未接入</c:if>
										<c:if test="${dto.device.is_activated == 1}"  >已接入</c:if>
										</td>
 									</tr>
							<tr>
							</tr>
							
						</tbody>
					</table>
					
					<h1 align="left" style="padding-left: 40px;">设备属性</h1>
				<hr style="border:1px dashed #c0c0c0;border-bottom:0;border-right:0;
           border-left:0;width:95%;">
					<table align="center">
					
						<tr >
						<td>属性名称别名</td><td>创建时间</td>
					</tr>
					<c:forEach items="${dto.property}" var="pro">
					<tr>
					<td>${pro.name}(${pro.alias})</td>
					<td><fmt:formatDate value="${pro.created_at}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					</tr>
					</c:forEach>
										
					</table>
					
					
						
					
	</div>
</body>
</html>
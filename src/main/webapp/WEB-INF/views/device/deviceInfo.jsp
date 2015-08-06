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
	
					<table width="100%" cellspacing="0" cellpadding="2"
						class="dataTable">
						<tbody>
						<tr >
						<th >名称</th><th >时区</th><th >地点</th><th >描述</th><th >创建时间</th><th >是否已接入</th><th>属性/通道</th>
					</tr>
									<tr>
										<td title="${dto.device.name}${dto.device.alias}" >
										<a href="">${dto.device.name}(${dto.device.alias})</a></td>
										<td title="${dto.device.timezone}">${dto.device.timezone}</td>
										<td title="${dto.device.site}">${dto.device.site}</td>
										<td title="${dto.created_at}">${dto.created_at}</td>
										<td title="${dto.device.comment}">${dto.device.comment}</td>
										<td title="${dto.device.is_activated}" >
										<c:if test="${dto.device.is_activated == 0}"  >未接入</c:if>
										<c:if test="${dto.device.is_activated == 1}"  >已接入</c:if>
										</td>
 									</tr>
							<tr>
							</tr>
							
						</tbody>
					</table>
					
					<table>
					<tr >
				<td align="left"colspan="5"><strong>设备属性</strong>
				</td>
			</tr>
						<tr >
						<th >属性名称别名</th><th >创建时间</th>
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
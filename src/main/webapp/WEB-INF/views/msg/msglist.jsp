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
<script type="text/javascript"src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Dialog.js"></script>	
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


// Y.Lei

</script>
<body>
	<div class="sensor-div">
	<table width="100%" cellspacing="0" cellpadding="0" border="0" >
		<tbody>
			<tr>
				<td style="padding: 2px 10px;">
				
				</td>
			</tr>
			<tr>
				<td	style="padding-top: 2px; padding-left: 6px; padding-right: 6px; padding-bottom: 2px;">
				<form action="<%=request.getContextPath()%>/msg/msglist" method="post">
					<table width="100%" cellspacing="0" cellpadding="2"
						class="dataTable" border="1px">
						<tbody>
						<tr class="dataTableHead">
						<th width="10%" height="30" class="thOver">发送人</th>
						<th width="10%" height="30" class="thOver">接收人</th>
						<th width="15%" height="30" class="thOver">发送时间</th>
						<th width="15%" height="30" class="thOver">接收时间</th>
						<th width="10%" height="30" class="thOver">消息状态</th>
						<th width="10%" height="30" class="thOver">消息类型</th>
						<th width="20%" height="30" class="thOver">消息主题</th>
						<th width="10%" height="30" class="thOver">详情</th>
					
						
					</tr>
							
								<c:forEach items="${msg}" var="msg" varStatus="num">
									<tr>
										<td title="${msg.msg_sender}">${msg.msg_sender}</td>
										<td title="${msg.msg_recipient}" >${msg.msg_recipient}</td>

										<td title="${msg.send_at}" >
										<fmt:formatDate value="${msg.send_at }" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										
										<td title="${msg.receive_at}">
										<fmt:formatDate value="${msg.receive_at }" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td title="${msg.msg_status}" >
										<c:if test="${msg.msg_status == 0}"  >已发送</c:if>
										<c:if test="${msg.msg_status == 1}"  >已接收</c:if>
										<c:if test="${msg.msg_status == 2}"  >已查看</c:if>
										<c:if test="${msg.msg_status == 3}"  >已回复</c:if>
										</td>
										<td title="${msg.msg_type}" >${msg.msg_type}</td>
										<td title="${msg.msg_theme}">${msg.msg_theme}</td>
										<td><a href="<%=request.getContextPath()%>/msg/inmsg?msg_id=${msg.msg_id}&msg_type=${msg.msg_type}&msg_sender=${msg.msg_sender}&msg_recipient=${msg.msg_recipient}">查看详情</a></td>
 									</tr>
								</c:forEach>
								
							<tr>
							</tr>
							
						</tbody>
					</table>
					</form>
				</td>
			</tr>
			
		</tbody>
	</table>
	</div>
</body>
</html>
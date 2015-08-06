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
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery.js"></script>
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
function submint1(){
	
	if(!window.confirm("确定提交吗?")) {
		return;
	}
	document.forms[0].submit();
}

// Y.Lei

</script>
<body>
<div class="sensor-div">
	<form action="<%=request.getContextPath()%>/deviceModel/updateModelSubmitAudit" method="post" id="form1">
	<table width="100%"  cellspacing="0" cellpadding="2" class="dataTable" border="1px" >
		<tbody>
			<tr class="dataTableHead">
				<td height="30" class="thOver" colspan="7"><strong>Ocloud 设备模型</strong>
				</td>
			</tr>

			<tr>
				<td height="30" >模块名称</td>
				<td height="30" >模板ID</td>
<td height="30" >文本编辑方式</td>
<td height="30" >二进制编码方法</td>
<td height="30" >来源设备</td>
<td height="30" >模板图片</td>
<td height="30" >模板备注</td>
			</tr>
			<tr>
				<td >${dto.model_name}</td>
	
				<td >${dto.model_id}</td>
			
				
				<td  >
				<c:if test="${'' eq dto.text_encoding_id}">无</c:if>
				<c:if test="${'0' eq dto.text_encoding_id}">XML</c:if>
				<c:if test="${'1' eq dto.text_encoding_id}">TXT</c:if>
				<c:if test="${'JSON' eq dto.text_encoding_id}">JSON</c:if>
				</td>
				
			
				<td  >
				<c:if test="${'' eq dto.binary_encoding_id}">无</c:if>
				<c:if test="${'0' eq dto.binary_encoding_id}">二进制0</c:if>
				<c:if test="${'1' eq dto.binary_encoding_id}">二进制1</c:if>
				</td>
		
			<td>${dto.device.name}(${dto.device.alias}) </td>
		
				<td  >${model.picture}</td>
			
				
				<td >${model.comment}</td>
			</tr>
		</tbody>
	</table>
	</form>
</div>
</body>
</html>
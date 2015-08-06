<%@page import="com.ourselec.ocloud.consts.DataType"%>
<%@page import="com.ourselec.ocloud.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/default.css">
<script type="text/javascript" 
	src="<%=request.getContextPath()%>/js/jquery.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Dialog.js"></script>		
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
function confirmSave() {
	Dialog.confirm("确定要修改吗?", function() {
		$("#form1").submit();
	}, function(){}, 300, 170);
	return false;
}
</script>	
</head>
<body>
<div class="sensor-div">
<form action="<%=request.getContextPath()%>/channel/updatechannel" method="post" id="form1" onsubmit="return confirmSave();">

<table width="100%" class="dataTable" bordercolor="red" border="1px">
		<tr class="dataTableHead">
			<td height="30" class="thOver" colspan="2"><strong>通道修改</strong>
			</td>
		</tr>
		<tr>
		<td colspan="2"><input type="hidden" name="property_id" id="property_id" value="${property_id}" /> </td>
		</tr>
		<tr>
			<td align="center" width="20%">通道名称:</td>
			<td ><input type="text" name="name" id="name" value="${c.name}" readonly="readonly"></td>
		</tr>
		<tr>
			<td align="center" width="20%">别名:</td>
			<td ><input type="text" name="alias" id="alias" value="${c.alias}" readonly="readonly"></td>
		</tr>
		<tr>
		<td align="center" >
				<select id="channel_type" name="channel_type" title="channel_type">
				<option value="0"<c:if test='${"0" eq channel_type}'>selected</c:if>>静态通道</option>
				<option value="1"<c:if test='${"1" eq channel_type}'>selected</c:if>>动态通道</option>
				</select>
				</td>
		</tr>
			<tr>
				<td align="center" width="20%">数据类型:</td>
				<td >
				<select name="base_type" id="base_type" style="width:100px" id="base_type"  >
						<option value="">---请选择--</option>
						<c:forEach var="t" items="<%=DataType.getValues() %>">
							<option value="${t.key}" <c:if test="${t.key eq c.base_type}">selected</c:if>>${t.value}</option>
						</c:forEach>
					</select>
				
				</td>
		</tr>
		<tr>
			<td align="center" width="20%">通道说明:</td>
			<td ><textarea  name="description" id="description"  style="width: 140px;height: 100px;"class="inputText" onfocus="this.select();" value="${c.description}" ></textarea></td>
		</tr>
		<tr>
			<td align="center" colspan="2"><input type="submit" value=" 保存 " class="inputButton"></td>
		</tr>
		</table>
		</form>
		</div>
</body>
</html>
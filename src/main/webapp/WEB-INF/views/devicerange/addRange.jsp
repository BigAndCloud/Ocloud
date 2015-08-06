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
<%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/button.css"> --%>
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
function submint1() {
	Dialog.confirm("确定要保存吗?", function() {
		$("#form1").submit();
	}, function(){}, 300, 170);
	return false;
}
</script>	
</head>
<body>
<br/>
<br/>
<div class="submit-div">
<form action="<%=request.getContextPath()%>/range/addRange" method="post" id="form1" onsubmit="return confirmSave();">

<table  cellspacing="0" border="1px">
		<tr >
			<td height="30" class="thOver" colspan="5"><strong>添加设备模型序列号范围</strong>
			</td>
		</tr>
		
		<tr>
			<td align="right"  >设备模板:</td><td align="left">
			<select id="model_id" name="model_id">
			<c:forEach items="${model}" var="m">
			<option value="${m.id}" <c:if test="${m.id eq param.model_id}">selected</c:if>>${m.model_name}</option>
			</c:forEach>
			</select>
		</td>
		<td align="right" >序列号类型:</td><td align="left">
			<select id="serial_type" name="serial_type" title="serial_type">
			<option value="0"<c:if test='${"0" eq range.serial_type}'>selected</c:if>>Base10</option>
			<option value="1"<c:if test='${"1" eq range.serial_type}'>selected</c:if>>Base16</option>
			<option value="2"<c:if test='${"2" eq range.serial_type}'>selected</c:if>>Mac</option>
			<option value="4"<c:if test='${"4" eq range.serial_type}'>selected</c:if>>自定义</option>
			</select>
			</td>
		
		</tr>
		<tr>
	
				<td align="right" >范围区间:</td><td align="left" colspan="3">
			<input id="range_min" style="width: 100px" name="range_min" value="${range.range_min}"/>&nbsp;~&nbsp;
			<input id="range_max" style="width: 100px" name="range_max" value="${range.range_max}"/>
				</td>
				
		</tr>
		<tr>
		<td align="right" >序列号长度:</td><td align="left" colspan="3">
		<input name="range_width" id="range_width" value="${range.range_width}"/>
		</td>

		</tr>
		
		<tr>
			<td align="right" >备注:</td>
			<td colspan="3" align="left"><textarea  name="description" id="description"  style="width: 200px;height: 100px;"class="inputText" onfocus="this.select();" value="${c.description}" ></textarea></td>
		</tr>
	<tr> <td colspan="4"></td></tr>
		</table>
		</form>
	<table width="100%" cellspacing="0" cellpadding="2" style="margin-top: -1px; border-top: 0px" border="0px">
			<tr>
			 <td align="right" colspan="3"  style="border-top: 0px;">
			<button class="submit-gray" style="cursor:pointer" type="button" onclick="submint1()" value="确认提交">确认提交
			
			</button>
			
		</tr>
	</table>
		</div>
</body>
</html>
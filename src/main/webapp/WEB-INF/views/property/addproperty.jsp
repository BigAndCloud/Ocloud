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
		
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Dialog.js"></script>	
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/buttons.css">
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
	if($.trim($("#alias").val())==""){
		Dialog.alert("请输入别称");
		return;
	}else if ($.trim($("#name").val())=="") {
		Dialog.alert("请输入属性名称");
		return;
	}
	if(!window.confirm("确定添加吗?")) {
		return;
	}
	document.forms[0].submit();
}

function openinfo(name) {
	var info = $("#" + $("#" + name + "_batchcode").val()).val().split("_");
	if("0" == info[6]) {
		Dialog.alert("当前期没有开奖信息");
		return;
	}
	var d = new Dialog("开奖信息", "property/addproperty?info=" + ($("#" + name + "_batchcode").val()), 400, 300);
	d.show();
}


</script>	

</head>

<body>
&nbsp;
&nbsp;
&nbsp;
&nbsp;
<div class="sensor-div">
<form action="<%=request.getContextPath()%>/property/addproperty" method="post" id="form1">
	<table width="100%" cellspacing="0" cellpadding="2" class="dataTable"  align="center">
		<tbody>
			<tr class="dataTableHead">
				<td height="30" class="thOver" colspan="3" align="center"><strong>Ocloud 添加属性</strong>
				</td>
			</tr>
			<tr>
			<td colspan="3"><input id="model_id" name="model_id" type="hidden" value="${model_id}" /> </td>
			</tr>
			<tr>
				<td height="30" align="right">属性名称</td>
				<td align="left">
					<input id="name" name="name" style="width: 200px"   onfocus="this.select();" value="${param.name}"/></td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">属性别名</td>
				<td align="left">
					<input id="alias" name="alias" style="width: 200px"   onfocus="this.select();" value="${param.alias}"/></td><td><span class="notnull" >必填</span></td>
			</tr>
		</tbody>
	</table>
	<HR style="FILTER: alpha(opacity=0,finishopacity=100,style=1)" width="100%" color=#555 SIZE=3>
	<table width="100%" cellspacing="0" cellpadding="2"	style="margin-top: 10px">
		<tr>
			<td align="right"  ><input type="button" value="添加 " style="cursor: pointer;" class="submit-big-gray" onclick="submint1()"></td>
		</tr>
	</table>
</form>
</div>
</body>
</html>
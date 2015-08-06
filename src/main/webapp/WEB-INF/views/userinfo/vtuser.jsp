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
function submint1(){
	if(!window.confirm("确定添加吗?")) {
		return;
	}
	document.forms[0].submit();
}

function checkEmail()
{
 var emailValue=document.getElementById("username").value;
 if (!isEmail(emailValue))
 {
  alert("您输入的邮箱有误,请重新核对后再输入!");
  document.getElementById("username").focus();
  return false;
 }
 return true;
}

function isEmail(str){
      var reg = /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;
      return reg.test(str);
  }

</script>	
</head>
<body>
<div class="sensor-div">
<form action="<%=request.getContextPath()%>/userinfo/vtusers" method="post" id="form1">
	<table width="50%" cellspacing="0" cellpadding="2" class="dataTable">
		<tbody>
			<tr class="dataTableHead">
				<td height="30" class="thOver" colspan="2" align="center"><strong>Ocloud 信息补充</strong>
				</td>
			</tr>
			
			<tr>
				<td height="30" align="right">用户ID</td>
				<td align="left">
					<input id="userid" name="userid" style="width: 120px"   onfocus="this.select();" value="${userid}" readonly="readonly"/></td>
			</tr>
			<tr>
				<td height="30" align="right">用户昵称</td>
				<td align="left">
					<input id="nickname" name="nickname" style="width: 120px"   onfocus="this.select();" value="${nickname}"/></td>
			</tr>
			<tr>
				<td height="30" align="right">联系电话</td>
				<td align="left">
					<input id="mebileId" name="mebileId" style="width: 120px"   onfocus="this.select();" value="${mebileId}"/></td>
			</tr>
		
			<tr>
				<td height="30" align="right">联系地址</td>
				<td align="left">
					<input id="address" name="address" style="width: 120px"   onfocus="this.select();" value="${address}"/></td>
			</tr>
			

			
		</tbody>
	</table>
	<table width="45%" cellspacing="0" cellpadding="2"	style="margin-top: 10px">
		<tr>
			<td align="center"><input type="button" value="确认提交 " class="inputButton" onclick="submint1()"></td>
		</tr>
	</table>
	
</form>
</div>
</body>
</html>
<%@page import="com.ourselec.ocloud.domain.Vendor"%>
<%@page import="com.ourselec.ocloud.util.SessionUtil"%>
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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/buttons.css">
<style type="text/css">
 input,button{
	width: 150px;
};
.notnull{
	color: red;
};

</style>	
<script type="text/javascript" 
	src="<%=request.getContextPath()%>/js/jquery.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Dialog.js"></script>	
<script type="text/javascript">	
function addproperty(){
	$('#t').append('<tr><td height="30" align="right">邀请用户邮箱</td><td align="left"><input id="useremail" name="useremail" style="width: 200px"/></td></tr>');
};


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
}%>
function checkEmail()
{
 var emailValue=document.getElementById("useremail").value;
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


function submint1(){
	if($.trim($("#vendor_id").val())==""){
		Dialog.alert("您的特有标识");
		return;
	}else if ($.trim($("#useremail").val())=="") {
		Dialog.alert("请输入要邀请的对象");
		return;
	}
	
	if(!window.confirm("确定邀请吗?")) {
		return;
	}
	document.forms[0].submit();}
</script>	
<%Vendor vendor= SessionUtil.getVendor(request);  %>
</head>

<body>
<div class="sensor-div">
<form action="<%=request.getContextPath()%>/vendor/invitedeve" method="post" id="form1">
<table>
	<tr >
				<td height="30" align="center">厂商授权申请
				</td>
				<td align="center" colspan="2"><input style="width: 200px" readonly="readonly" name="vendor_id" id="vendor_id" value="<%=vendor.getVendor_id()%>"  type="text" style="color:gray " /> </td>
			</tr>
	
			
</table>
<div id="org"  class="org">

	<table  cellspacing="0" id="t" cellpadding="2" width="100%">
		<tbody>
			<tr>
				<td height="30" align="right">邀请用户邮箱</td>
				<td align="left">
					<input id="useremail" name="useremail" style="width: 200px"/></td>
			</tr>
						
		</tbody>
	</table>
</div >
</form>
<div id="org1"  class="org1" ></div>
<table cellspacing="0" cellpadding="2" width="100%">
	<tr >
	<td> <input type="button" class="submit-big-gray" style="cursor:pointer" onclick="addproperty()"  value="增加邀请用户" />
	</td><td>
	<input type="button" value="确认提交 " class="submit-big-gray" style="cursor:pointer"onclick="submint1()"></td>
	</tr>
</table>
</div>





</body>
</html>
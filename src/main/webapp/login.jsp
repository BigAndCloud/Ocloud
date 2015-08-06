<%@page import="com.ourselec.ocloud.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>登陆</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Dialog.js"></script>	
<script>

var username = $.trim($("#UserName").val());
function login(){
	if($.trim($("#UserName").val())==""||$.trim($("#Password").val())==""){
		Dialog.alert("请输入用户名和密码");
		return;
	} else {
		Page.wait();
		$.ajax({
			url:"<%=request.getContextPath() %>/login",
			type:"POST",
			data:"username=" + $.trim($("#UserName").val()) + "&password=" + $.trim($("#Password").val()),
			
			success:function(data){
				if(data.errorCode == "0") {
					window.location = "<%=request.getContextPath()%>/indexs";
				} else {
					//Page.endWait();
					Dialog.alert(data.errorCode+date.value);
				}
			}
		});
	}
}
$(document).ready(function() {
	if(window.top.location != window.self.location){
		window.top.location = window.self.location;
	}else{
		$("#UserName").focus();
	}
	$("html").die().live("keydown",function(event){
        if(event.keyCode==13){
        	login();
         }
    });
});
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


function checkEmail()
{
 var emailValue=document.getElementById("UserName").value;
 if (!isEmail(emailValue))
 {
  alert("您输入的邮箱有误,请重新核对后再输入!");
  document.getElementById("UserName").focus();
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
<form id="form1" method="post" style=" display:block;height:100%;">
<table width="100%" height="100%">
	<tr>
		<td align="center" valign="middle">
		<table
			style=" height:283px; width:620px; ">
			<tr>
				<td>
				<div style="height:213px; width:620px;"></div>
				<div style="height:70px; width:620px;margin:0px auto 0px auto;">
				<table width="95%" border="0" align="center" cellpadding="0"
					cellspacing="0" style="margin-top:8px;">
					<tr>
						<td align="center">用户名：
					    <input name="UserName" type="text" style="width:120px"
							id="UserName" class="inputText" onfocus="this.select();" onchange="checkEmail();"/>
					    &nbsp;密码：
					    <input name="Password" type="password" style="width:120px"
							id="Password" class="inputText" onfocus="this.select();"/>
					    <span id='spanVerifyCode'></span>	
						&nbsp;<img src="<%=request.getContextPath()%>/images/loginbutton.jpg" name="LoginImg" align="absmiddle" id="LoginImg" style="cursor:pointer" onClick="login();" /></td>
					</tr>
					<tr><td align="center"><a href="<%=request.getContextPath()%>/users/register">注&nbsp;&nbsp;&nbsp;册</a>&nbsp;&nbsp;&nbsp;<a href="<%=request.getContextPath()%>/changepassword">忘记密码</a>   </td></tr>
					<tr>
						<td height="23" align="center" valign="bottom">Copyright &copy;  Ourselec.com Inc. All rights reserved. 北京奥尔斯 版权所有</td>
					</tr>
				</table>
				</div>
				</td>
			</tr>
		</table>
		<br>
		</td>
	</tr>
</table>
</form>
</body>

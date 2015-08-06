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

function confirmSave() {
	Dialog.confirm("确定要保接受吗?", function() {
		$("#form1").submit();
	}, function(){}, 300, 170);
	return false;
}
// Y.Lei
function accept(){
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




</script>
<body>
<div class="sensor-div">
	<form action="<%=request.getContextPath()%>/msg/saveReply" method="post" id="form1" onsubmit="return confirmSave();">
	<table width="100%" cellspacing="0" cellpadding="0" border="0">
		<tbody>
			<tr>
				<td style="padding: 2px 10px;">
				
				</td>
			</tr>
			<tr>
				<td	style="padding-top: 2px; padding-left: 6px; padding-right: 6px; padding-bottom: 2px;">
					<table width="100%" cellspacing="0" cellpadding="2"
						class="dataTable">
						<tbody>
						<tr class="dataTableHead">
						<td  colspan="2" height="30" class="thOver"><h1>邀请函</h1> </td>
					</tr>
						<tr>
							<td>厂商（${vendor.company_name}） 邀请您${msg_recipient}成为项目的开发者</td>
							<td><a>项目简介</a></td>
							</tr>
		<tr>
			<td align="left" >
			<a href="<%=request.getContextPath()%>/msg/replyinvit?msg_id=${msg_id}&msg_sender=${msg_sender}&msg_recipient=${msg_recipient}&reply=0">
			<img src="<%=request.getContextPath()%>/images/acceptbutton.png" name="acceptImg" align="absmiddle" id="acceptImg" style="cursor:pointer"  /></a></td>
			
			<td align="right" >
			<a href="<%=request.getContextPath()%>/msg/replyinvit?msg_id=${msg_id}&msg_sender=${msg_sender}&msg_recipient=${msg_recipient}&reply=1&">			
			<img src="<%=request.getContextPath()%>/images/refusebutton.png" name="refuseImg" align="absmiddle" id="refuseImg" style="cursor:pointer"  /></a></td>
		</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<!--
			@RequestParam(value="msg_id",required=false)String msg_id
			,@RequestParam(value="msg_sender",required=false)String vender
			,@RequestParam(value="msg_recipient",required=false)String deve
			,@RequestParam(value="reply",required= false)Integer reply
			  -->
		</tbody>
	</table>
	</form>
	</div>
</body>
</html>
<%@page import="com.ourselec.ocloud.domain.Users"%>
<%@page import="com.ourselec.ocloud.util.SessionUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/default.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>

<script type="text/javascript">
function changePassword() {
	window.parent.content.location = "<%=request.getContextPath() %>/frame/blank";
}
function logout() {
	if(window.confirm("确定退出?")) {
				window.parent.location = "<%=request.getContextPath() %>/login.jsp";
	}
}
function getMsg() {
	$.ajax( {  
        type : "post",  
        url : "<%=request.getContextPath()%>/msg/getmsg",  
//        dataType:"json",  
        success : function(msg) {  
            alert('重新加载成功');  
        }  
    });  
}

</script>
<%Users users= SessionUtil.getUsers(request); %>
</head>
<body  style="margin: 0px;background-color: #c0c0c0;" >
<div >


	<table id="_TableHeader" width="100%"   border="0" cellpadding="0"
		cellspacing="0" class="bluebg" style="margin:10px; background-color:rgba(255,255,255,0.4);">
		<!--style="background:#3388bb url(<%=request.getContextPath() %>/images/vistaBlue.jpg) repeat-x left top;"  -->
		<tr>
			<td height="80" valign="bottom">
			<table height="80" border="0" cellpadding="0" cellspacing="0"
				style="position:relative;">
				<tr>
					<td style="padding:0">&nbsp;&nbsp;&nbsp;&nbsp;<%-- <img src="<%=request.getContextPath() %>/images/logo.png"> --%></td>
				</tr>
			</table>
			</td>
			<td valign="bottom">
			<div style="text-align:right; margin:0 20px 15px 0;">当前用户：<b><%=users.getUsername() %></b>
			&nbsp;[&nbsp;<a href="javascript:void(0);"
				onClick="logout();">退出登录</a> | <a
				href="javascript:changePassword();">修改密码</a> ]&nbsp;<a	href="<%=request.getContextPath()%>/msg/getmsg"  target="context">消  息(${count})</a></div>
			</td>
		</tr>
	</table>
	</div>
</body> 
</html>
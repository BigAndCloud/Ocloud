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
<style type="text/css">
html { overflow: hidden; }
body{font-size: 16px;}
#_TableHeader  a {
  /*   color: #c6c6c6; */
    display: inline-block;
    font-size: 16px;
    height: 48px;
    line-height: 48px;
    padding: 0px;
}
a {
   /*  color: #333; */
   color: #888;	
    cursor: pointer;
    outline: medium none;
    text-decoration: none;
}

a:hover{
	
	color: #ffffff;
	text-decoration: none;
}
</style>
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
<body  style="margin: 0px;background:#f0f3f4 none repeat scroll 0 0;" >
<div >


	<table id="_TableHeader" width="100%"   border="0" cellpadding="0"
		cellspacing="0" class="bluebg" style="margin:0; background-color:black;">
		<!--style="background:#3388bb url(<%=request.getContextPath() %>/images/vistaBlue.jpg) repeat-x left top;"  -->
		<tr>
			<td height="80" valign="bottom">
			<table height="80"  cellpadding="0" cellspacing="0"
				style="position:relative;">
				<tr>
					<td style="padding:0; width: 250px;"align="right" ><span style="font-size: 40px; color: white;font-weight:bold;">OCloud</span>
					
					
					<%-- <img src="<%=request.getContextPath() %>/images/logo.png"> --%></td>
				</tr>
			</table>
			</td>
			<td valign="bottom">
			<div style="text-align:right; margin:0 20px 15px 0;"><a>当前用户：<%=users.getUsername() %></a>
			&nbsp;[&nbsp;<a href="javascript:void(0);"
				onClick="logout();">退出登录</a> | <a
				href="javascript:changePassword();">修改密码</a> ]&nbsp;<a	href="<%=request.getContextPath()%>/msg/getmsg"  target="context">消  息(${count})</a></div>
			</td>
		</tr>
	</table>
	</div>
</body> 
</html>
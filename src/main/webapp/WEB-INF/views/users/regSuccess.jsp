<%@page import="com.ourselec.ocloud.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript" 
	src="<%=request.getContextPath()%>/js/jquery.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Dialog.js"></script>	
<script type="text/javascript">	

</script>	
</head>
<body>
<div class="sensor-div">
<table>

<tr><td></td></tr>
<tr><td><h1>Ocloud 提示： 您已经注册成功！</h1></td></tr>
<tr><td><p>请打开邮件<a href="<%=request.getContextPath()%>/login?username=${username}&password=${password}" style="color: red">${username}</a>收取账号激活邮件 </p></td></tr>


</table>


</div>

</body>

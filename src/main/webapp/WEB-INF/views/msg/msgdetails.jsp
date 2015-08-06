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

</script>	
</head>
<body>
<div class="sensor-div">
<table >
<tr><td><h1 align="left">主题 :</h1></td></tr>
<tr><td>	&nbsp;&nbsp;&nbsp;<h3>${msg.msg_theme}</h3></td></tr>
<tr><td><h3 align="left">内容：</h3> </td></tr>
<tr><td>	&nbsp;&nbsp;<p>${msg.msg_context} </p></td></tr>
</table>
	
	</div>
</body>

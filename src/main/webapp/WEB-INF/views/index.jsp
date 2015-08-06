<%@page import="com.ourselec.ocloud.util.SessionUtil"%>
<%@page import="com.ourselec.ocloud.domain.Users"%>
<%@page import="com.ourselec.ocloud.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Ocloud</title>
 <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Dialog.js"></script>	

<script type="text/javascript">

<%
Users users =  SessionUtil.getUsers(request);
 if(users==null){
	 
	 %>
	 window.location = "<%=request.getContextPath()%>/login.jsp";
 <%
 }
%>

$(document).ready(function() {
	if(window.top.location != window.self.location){
		window.top.location = window.self.location;
	}
	$("html").die().live("keydown",function(event){
        if(event.keyCode==13){
        	login();
         }
    });
});
</script>
</head>


<frameset rows="80,*" cols="*" frameborder="no" border="1px"
	noresize="false" resizable="no" framespacing="0" >
	<frame src="<%=request.getContextPath()%>/frame/header" style="height: 200px"  name="topFrame"
		noresize="noresize" id="topFrame" title="topFrame" scrolling="no" />
	<frameset cols="200,*" framespacing="0" border="0" noresize="false"
		resizable="no" bordercolor="#0066cc">
		<frame   src="<%=request.getContextPath()%>/frame/left" name="leftFrame" bordercolor="#00ffcc"
			id="leftFrame" title="leftFrame" scrolling="auto"  />
		<frame src="about:blank" name="context" id="context"
			title="context" />
	</frameset>
</frameset>
</html>
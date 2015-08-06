<%-- <%@page import="com.ourselec.ocloud.domain.power.Tmenu"%>
<%@page import="com.ourselec.ocloud.controller.dto.RescourceDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%> --%>
<%@page import="com.ourselec.ocloud.domain.power.Tresources"%>
<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/default.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>

<title>Insert title here</title>

<script type="text/javascript">

$(document).ready(function(){
	var res = ${resources};
	var s=document.getElementById('res');
	
	for (var  i= 0; i < res.length; i++) {
		var l= document.createElement('li');
		var a= document.createElement('a');
		var li= s.appendChild(l); 
		var ca= li.appendChild(a);
		ca.innerHTML=res[i].name;
		ca.setAttribute("href",res[i].url);
		ca.setAttribute("target",res[i].target)
	}
	zNodes=${resources};
	 $.fn.zTree.init($("#treeDemo"), setting, zNodes);
	 var treeObj = $.fn.zTree.getZTreeObj("treeDemo"); 
	 treeObj.expandAll(true); 
});

</script>   
</head>
<body style="border-right: 2px solid #B1B1AD; margin-left: 30px;">
	<ul id="res"></ul>
</body>
</html>
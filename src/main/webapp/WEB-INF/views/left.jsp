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
<%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/default.css"> --%>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>
<style type="text/css">

.d_over{background-color:white;}
.d_out{background-color:rgba(255,255,255,0.4);}
li
{
	display:block;
	text-align:right;	
	 line-height:60px; /*设置垂直  */
	border-color:black;
	border:1px;
	width:170px;
	height:60px;
background-color:rgba(255,255,255,0.4);
}
ul{
margin: 0px;
padding: 0px;

}
a{
	height:200px;
	width: 200px;
	color: #555;
	padding: 20px;
}
ul li a:link {
text-decoration: none;

}
a:visited {
text-decoration: none;

}
a:hover {
text-decoration: none;
}
a:active {
text-decoration: none;
}


</style>
<title>Insert title here</title>

<script type="text/javascript">

$(document).ready(function(){
	var res = ${resources};
	var s=document.getElementById('res');
	
	for (var  i= 0; i < res.length; i++) {
		var l= document.createElement('li');
		var a= document.createElement('a');
	
		var li= s.appendChild(l); 
		li.setAttribute("onmouseover","this.className='d_over'");
		li.setAttribute("onmouseout","this.className='d_out'");
		var ca = li.appendChild(a);
		
		ca.innerHTML=res[i].name;
		ca.setAttribute("href",res[i].url);
		ca.setAttribute("target",res[i].target)
		
	}

});

</script>   
</head>
<!-- background="<%=request.getContextPath()%>/images/leftbg.jpg" -->
<body style="background-color: #c0c0c0;margin-top: 0px;">
 <!-- <div  ><a href="#" onmouseover="this.className='changes'" onmouseout="this.className='normal'">放上来就变色</a></div> -->

	<ul id="res"></ul>
</body>
</html>
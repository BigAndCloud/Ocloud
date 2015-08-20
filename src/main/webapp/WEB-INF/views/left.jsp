<%-- <%@page import="com.ourselec.ocloud.domain.power.Tmenu"%>
<%@page import="com.ourselec.ocloud.controller.dto.RescourceDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%> --%>
<%@page import="com.ourselec.ocloud.util.SessionUtil"%>
<%@page import="com.ourselec.ocloud.domain.Users"%>
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
html { overflow: hidden;  font: 14px "Microsoft YaHei",Helvetica,Arial,sans-serif; }
.d_over{background:#f0f3f4 none repeat scroll 0 0;}
.d_out{background:white; }
.w1{background:white;}
.w2{background:#f0f3f4 none repeat scroll 0 0;}
li
{
	display:block;
	text-align:left;	
	line-height:40px; /*设置垂直  */
	border-color:black;
	border:1px;
	width:190px;
	height:40px;
	padding:0px;
	background-color:white;
}
ul{
	margin: 0px;
	padding: 0px;
	padding-top: 30px;
	padding-bottom: 500px;
}
a{
	height:40px;
	width: 150px;
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
		li.setAttribute("class","w1");
	/* 	li.setAttribute("onmouseover","this.className='d_over'");
		li.setAttribute("onmouseout","this.className='d_out'"); */
		var ca = li.appendChild(a);
		
		ca.innerHTML=res[i].name;
		ca.setAttribute("href",res[i].url);
		ca.setAttribute("target",res[i].target)
		
	}

	  $(".w1").click(function(){
	       $(this).removeClass("w1");
	       $(this).addClass("w2");
	       $(this).siblings().removeClass("w2");
	       $(this).siblings().addClass("w1");
	   });
});

</script>   
<%Users users= SessionUtil.getUsers(request); %>
</head>
<body style="background:#f0f3f4 none repeat scroll 0 0; margin: 0px;padding: 0px;">
 <!-- <div  ><a href="#" onmouseover="this.className='changes'" onmouseout="this.className='normal'">放上来就变色</a></div> -->
<div class="div" style="height:1000px;width: 190px;margin-left:20px; background-color: white;" >
<br/><br/>
&nbsp;&nbsp;&nbsp;<strong style="font-size: 16px; color:#00a3e0; "><%=users.getUsername() %></strong>
<hr style="border:1px dashed #c0c0c0;margin-top:22px; border-bottom:0;border-right:0;border-left:0;width:95%;">
	<ul id="res"></ul>
</div>
</body>
</html>
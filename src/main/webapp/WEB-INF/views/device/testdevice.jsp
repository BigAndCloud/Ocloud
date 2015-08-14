<%@page import="com.ourselec.ocloud.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style type="text/css">

div.org{
border:1px;
border-color:red;
width:270px;
margin-top:10px;
margin-left:800px;
float:right;

};

div.org1{
position:absolute;
top: 200px;
};


</style>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/map/jQuery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/map/map1.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Dialog.js"></script>	
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/default.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/buttons.css">

<script type="text/javascript">	

$(document).ready(function(){
		var o = document.getElementById("org1");
	  $("button").click(function(){
	    $("#org1").before($("#org").clone());
	   
	  });
	  $("p").click(function(){
	    $(this).animate({fontSize:"+=1px"});
	  });
	});

function addproperty(){
	var input1 = document.createElement('input');
    input1.setAttribute('type', 'text');
    input1.setAttribute('name', 'organizers[]');
    input1.setAttribute('class', 'git');
    
    var btn1 = document.getElementById("org");
    btn1.insertBefore(input1,null);
};




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
function submint1(){
	if($.trim($("#alias").val())==""){
		Dialog.alert("请输入别称");
		return;
	}else if ($.trim($("#name").val())=="") {
		Dialog.alert("请输入设备名称");
		return;
	}else if ($.trim($("#timezone").val())=="") {
		Dialog.alert("请输入时区");
		return;
	}else if ($.trim($("#lat").val())=="") {
		Dialog.alert("请输入经度");
		return;
	}else if ($.trim($("#lng").val())=="") {
		Dialog.alert("请输入纬度");
		return;
	}else if ($.trim($("#alive_time").val())=="") {
		Dialog.alert("请输入活跃时间");
		return;
	}
	if(!window.confirm("确定添加吗?")) {
		return;
	}
	document.forms[0].submit();
}



$(function () {
    baidu_map();
});
</script>	

</head>

<body>

<div class="submit-div">
<button class="btn" onmouseover="this.className='d_over'" onmouseout="this.className='d_out'" style="float: right;margin-right: 40px;">增加属性</button>

<form action="<%=request.getContextPath()%>/device/testdevice" method="post"  id="form1">
<div id="org"  class="org" >
<table cellspacing="0" cellpadding="2" class="dataTable" >
		<tbody>
			<tr class="dataTableHead">
				<td height="30" class="thOver" colspan="2" align="center"><strong>Ocloud 添加属性</strong>
				</td>
			</tr>
			
			<tr>
				<td>属性名称</td>
				<td align="left">
					<input id="porname" name="porname" style="width: 200px"   onfocus="this.select();"/></td>
			</tr>
			<tr>
				<td>属性别名</td>
				<td align="left">
					<input id="poralias" name="poralias" style="width: 200px"   onfocus="this.select();" /></td>
			</tr>
		
		</tbody>
	</table>

</div >
<div id="org1" class="org1" ></div>

	<table width="60%" cellspacing="0" cellpadding="2" class="dataTable" >
		<tbody>
			<tr class="dataTableHead">
				<td height="30" class="thOver" colspan="2" align="center"><strong>Ocloud 添加设备</strong>
				</td>
			</tr>
			
			<tr>
				<td height="30" align="right">设备名称</td>
				<td align="left">
					<input id="name" name="name" style="width: 200px"   onfocus="this.select();" value="${param.name}"/></td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">设备别名</td>
				<td align="left">
					<input id="alias" name="alias" style="width: 200px"   onfocus="this.select();" value="${param.alias}"/></td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">活跃时间</td>
				<td align="left">
			
					<input id="alive_time" name="alive_time" style="width: 50px"   onfocus="this.select();" value="${param.alive_time}"/>&nbsp;分钟</td><td><span  >&nbsp;</span></td>
			</tr>
			<tr>
				<td height="30" align="right">设备时区</td>
				<td align="left" >
				<select id="timezone" name="timezone" title="timezone">
				<option value="Asia/shanghai">(GMT+8:00) 北京，重庆，香港，乌鲁木齐</option>
				</select>
				</td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">设备地点</td>
				<td align="left">
			<input type="text" id="suggestId" value=""  style="width: 340px" class="input-xlarge" name="address" data-rule-required="true" />
                   <button class="btn" onmouseover="this.className='d_over'" onmouseout="this.className='d_out'" type="button" id="positioning">搜索</button>
             
                <script src="http://api.map.baidu.com/api?key=D9S918lGOnIlK3PCUz4YRluN&v=1.1&services=true" type="text/javascript" type="text/javascript" /></script>
               
                <div id="l-map" style="width:500px; height:300px;">
                    <i class="icon-spinner icon-spin icon-large"></i>地图加载中...
                </div>
               
                    <input type="text" id="lng" name="lng" value="${param.lng}" /><input type="text" id="lat" value="${param.lat}" name="lat" />
			
			
			</td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">备注</td>
				<td align="left">
				<textarea rows="5" cols=""
				style="width: 300px;"
				id="comment" 
				name="comment" 
				onfocus="this.select();" >${param.comment}</textarea>
					</td><td><span class="notnull" >必填</span></td>
			</tr>
		<tr>
		<td colspan="6" width="20px">&nbsp;</td>
		</tr>
			
		</tbody>
</table>
</form>
<div style="border-top:  1px solid #D0D0D0; width: 60% ; float:right;" >
<table width="80%" style="margin-top: 40px; margin-bottom:20px; border-top: 0px">
			<tr>
			 <td align="right" colspan="3"  style="border-top: 0px; " >
			<button class="submit-big-gray" style="cursor:pointer"onclick="submint1()" value="添加设备 ">添加设备 </button>
			
		</tr>
	</table>
	</div>
</div>
</body>
</html>
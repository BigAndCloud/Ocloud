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
input,button{
	width: 150px;
};
.notnull{
	color: red;
};

</style>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/map/jQuery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/map/map.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Dialog.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/timezone.js"></script>	
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
function submint1(){
	if($.trim($("#alias").val())==""){
		Dialog.alert("您的特有标识");
		return;
	}else if ($.trim($("#name").val())=="") {
		Dialog.alert("您的公司全称");
		return;
	}
	else if ($.trim($("#company_industry").val())=="") {
		Dialog.alert("请输入您的行业");
		return;
	}else if ($.trim($("#contact_name").val())=="") {
		Dialog.alert("请输入联系人");
		return;
	}else if ($.trim($("#contact_number").val())=="") {
		Dialog.alert("请输入联系人电话");
		return;
	}else if ($.trim($("#contact_email").val())=="") {
		Dialog.alert("请输入联系email");
		return;
	}else if ($.trim($("#project_overview").val())=="") {
		Dialog.alert("项目概述");
		return;
	}else if ($.trim($("#cooperation_prospect").val())=="") {
		Dialog.alert("合作期望");
		return;
	}else if ($.trim($("#graphic_texture_data").val())=="") {
		Dialog.alert("图文资料");
		return;
	}
	if(!window.confirm("确定添加吗?")) {
		return;
	}
	document.forms[0].submit();
}

function checkEmail()
{
 var emailValue=document.getElementById("contact_email").value;
 if (!isEmail(emailValue))
 {
  alert("您输入的邮箱有误,请重新核对后再输入!");
  document.getElementById("contact_email").focus();
  return false;
 }
 return true;
}

function isEmail(str){
      var reg = /^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/;
      return reg.test(str);
  }

$(function () {
    baidu_map();
});
</script>	

</head>

<body>
<form action="<%=request.getContextPath()%>/vendor/submitauth" method="post" id="form1">
	<table width="50%" cellspacing="0" cellpadding="2" class="dataTable">
		<tbody>
			<tr class="dataTableHead">
				<td height="30" class="thOver" colspan="2" align="center"><strong>Ocloud 厂商授权申请</strong>
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
			
					<input id="timezone" name="timezone" style="width: 200px"   onfocus="this.select();" value="${param.timezone}"/></td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">设备地点</td>
				<td align="left">
			<input type="text" id="suggestId" value="" class="input-xlarge" name="address" data-rule-required="true" />
                    <button class="btn" type="button" id="positioning">搜索</button>
             
                <script src="http://api.map.baidu.com/api?key=D9S918lGOnIlK3PCUz4YRluN&v=1.1&services=true" type="text/javascript" type="text/javascript" /></script>
               
                <div id="l-map" style="width:500px; height:300px;">
                    <i class="icon-spinner icon-spin icon-large"></i>地图加载中...
                </div>
               
                    <input type="text" id="lng" name="lng" value="" /><input type="text" id="lat" value="" name="lat" />
			
			
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
		
			
		</tbody>
	</table>
	<table width="45%" cellspacing="0" cellpadding="2"	style="margin-top: 10px">
		<tr>
			<td align="center"><input type="button" value="添加设备 " class="inputButton" onclick="submint1()"></td>
		</tr>
	</table>
</form>
</body>
</html>
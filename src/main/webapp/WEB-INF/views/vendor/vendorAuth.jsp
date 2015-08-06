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
<style type="text/css">
input,button{
	width: 150px;
};
.notnull{
	color: red;
};

</style>	
<script type="text/javascript" 
	src="<%=request.getContextPath()%>/js/jquery.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Dialog.js"></script>	
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
	if($.trim($("#vendor_id").val())==""){
		Dialog.alert("您的特有标识");
		return;
	}else if ($.trim($("#company_name").val())=="") {
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

</script>	

</head>

<body>
<div class="sensor-div">
<form action="<%=request.getContextPath()%>/vendor/submitauth" method="post" id="form1">
	<table width="50%" cellspacing="0" cellpadding="2" class="dataTable">
		<tbody>
			<tr class="dataTableHead">
				<td height="30" class="thOver" colspan="2" align="center"><strong>Ocloud 厂商授权申请</strong>
				</td>
			</tr>
			
			<tr>
				<td height="30" align="right">公司名称</td>
				<td align="left">
					<input id="company_name" name="company_name" style="width: 200px"   onfocus="this.select();" value="${param.company_name}"/></td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">公司标识</td>
				<td align="left">
					<input id="vendor_id" name="vendor_id" style="width: 200px"   onfocus="this.select();" value="${param.vendor_id}"/></td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">公司主页</td>
				<td align="left">
					<input id="company_url" name="company_url" style="width: 200px"   onfocus="this.select();" value="${param.company_url}"/></td><td><span  >&nbsp;</span></td>
			</tr>
			<tr>
				<td height="30" align="right">所属行业</td>
				<td align="left">
					<input id="company_industry" name="company_industry" style="width: 200px"   onfocus="this.select();" value="${param.company_industry}"/></td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">公司规模</td>
				<td align="left">
				<select name="company_size" id="company_size" style="width: 60px">
				
				<option value="50">50</option>
				<option value="200">200</option>
				<option value="500">500</option>
				<option value="1000">1000</option>
				</select>
				</td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">联系人姓名</td>
				<td align="left">
					<input id="contact_name" name="contact_name" style="width: 200px"   onfocus="this.select();" value="${param.contact_name}"/></td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">联系人电话</td>
				<td align="left">
					<input id="contact_number" name="contact_number" style="width: 200px"   onfocus="this.select();" value="${param.contact_number}"/></td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">电子邮箱</td>
				<td align="left">
					<input id="contact_email" name="contact_email" style="width: 200px" onchange="checkEmail()"  onfocus="this.select();" value="${param.contact_email}"/></td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">项目概述</td>
				<td align="left">
				<textarea rows="5" cols=""
				style="width: 300px;"
				id="project_overview" 
				name="project_overview" 
				value="${param.project_overview}" 
				onfocus="this.select();" >${param.project_overview}</textarea>
					</td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">合作期望</td>
				<td align="left">
				<textarea rows="5" cols="" 
				style="width: 300px;"
				id="cooperation_prospect" 
				name="cooperation_prospect" 
				value="${param.cooperation_prospect}" 
				onfocus="this.select();" >${param.cooperation_prospect}</textarea>
					</td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">图文资料</td>
				<td align="left">
					<input  type="file" id="graphic_texture_data" name="graphic_texture_data" style="width: 250px ;"   onfocus="this.select();" value="${param.graphic_texture_data}"/>
					
					</td><td><span class="notnull" >必填</span></td>
			</tr>
			
			
		</tbody>
	</table>
	<table width="45%" cellspacing="0" cellpadding="2"	style="margin-top: 10px">
		<tr>
			<td align="center"><input type="button" value="确认提交 " class="inputButton" onclick="submint1()"></td>
		</tr>
	</table>
</form>
</div>
</body>
</html>
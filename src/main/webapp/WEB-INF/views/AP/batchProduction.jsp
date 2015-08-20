<%@page import="java.util.ArrayList"%>
<%@page import="com.ourselec.ocloud.domain.DeviceModelRange"%>
<%@page import="java.util.List"%>
<%@page import="com.ourselec.ocloud.consts.DataType"%>
<%@page import="com.ourselec.ocloud.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/default.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Dialog.js"></script>	
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/buttons.css">	
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
function submint1() {
	Dialog.confirm("确定要保存吗?", function() {
		$("#form1").submit();
	}, function(){}, 300, 170);
	return false;
}

function getRange(){
	var modelid= $("#model_id").find("option:selected").val();
	
	$.ajax({
		url:"<%=request.getContextPath() %>/range/getRangs",
		type:"POST",
		data:"modelid=" + modelid,
		
		success:function(data){
			 ranges= data.value;
			var o=  document.getElementById("ranges");
			o.innerHTML = "";
			if(ranges!=null){
				var len = ranges.length;
				
				for (var i = 0; i < len; i++) {
					var op = document.createElement("option");
					op.setAttribute("value", ranges[i].id);
					op.text= ranges[i].range_min+"/"+ranges[i].range_max;
					op.innerhtml = ranges[i];
					o.appendChild(op);
				}
			}
			
					 
		}
	});
	
	
}

</script>	
</head>
<body>
<br>
<br>
<div class="submit-div">
<form action="<%=request.getContextPath()%>/deviceModel/batchProduction" method="post" id="form1" onsubmit="return confirmSave();">

<table cellspacing="0" >
		<tr >
			<td colspan="2"><strong>批量添加接入设备</strong>
			</td>
		</tr>
		
		<tr>
			<td align="right">设备模板:</td><td>
			<select id="model_id" name="model_id" onchange="getRange();">
			<option value="">--请选择模板--</option>
			<c:forEach items="${model}" var="m" >
			<option value="${m.id}" <c:if test="${m.id eq param.model_id}">selected</c:if>>${m.model_name}</option>
			</c:forEach>
			</select>
		</td>
</tr>
		<tr>
			<td   align="right">序列号范围:</td><td>
			<select id="ranges" name="ranges" >
			<option value="">--请选择范围--</option>
			<c:forEach items="${ranges}" var="m" >
			<option value="${m.id}" <c:if test="${m.id eq param.model_id}">selected</c:if>>${m.model_name}</option>
			</c:forEach>
			</select>
		</td>
</tr>
		<tr>
			<td  align="right">添加设备个数:</td><td>
			<input name="num" id="num" value="${param.num}" />
		</tr>
		<tr><td><br></td> </tr>
		</table>
		
		
		</form>
		
		<table width="100%" cellspacing="0" cellpadding="2" style="margin-top: -1px; border-top: 0px" border="0px">
			<tr>
			 <td align="right" colspan="3"  style="border-top: 0px;">
			<!-- <button class="submit-gray" style="cursor:pointer" type="button" onclick="submint1()" value="确认提交">确认提交</button> -->
			<input style="cursor: pointer;" class="submit-gray" value="确认提交" type="button"onclick="submint1()"/>
		</tr>
	</table>
		</div>
</body>
</html>
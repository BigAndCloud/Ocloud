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

<link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/demo/demo.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-1.6.min.js"></script>
<script type="text/javascript" src="http://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/ocloud/sucdetailsGrid.js"></script>
<style type="text/css">

.bottom-div{
position:relative;
bottom:-300px;
}

</style>
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



</script>	

</head>

<body>
<div class="sensor-div">
<form action="<%=request.getContextPath()%>/deviceModel/modelListDeve" method="post" id="form1">
	
	
	<table width="100%" id="t" cellspacing="0" cellpadding="2" class="dataTable" border="2px" bordercolor="blue">
		<tbody>
		<tr class="dataTableHead">
				<td height="30" class="thOver" colspan="5" align="left"><strong>设备接入情况表</strong>
				</td>
			</tr>
				<tr class="dataTableHead">
					
					<td >名称，别名</td>
					<td >地址</td>
					<td >描述</td>
					<td >总接入量</td>
					
						
					</tr>					
				<tr>
				
					<td title="进入详情" >
					<a href="<%=request.getContextPath()%>/deviceModel/toupdateModelSubmitAudit?id=${list.id}">${list.name}(${list.alias})</a></td>
					<td title="${site}" >${site}</td>
					<td title="${list.comment}" >${list.comment}</td>
					<td>
					<a href="<%=request.getContextPath()%>/deviceModel/">${num}/${result}</a>
					</td>
					</tr>
 				<tr>
 					<td>创建时间</td>
					<td >序列号类型</td>
					<td >序列号长度、范围</td>
					<td >总接入量</td>
					</tr>
					<tr>
					<c:forEach items="${ranges}" var="range">
					<tr>
					<td title="${range.created_at}">
					<fmt:formatDate value="${range.created_at}" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td>
					<td title="${range.serial_type }">
					<c:if test='${"0" eq range.serial_type}'>Base10</c:if>
					<c:if test='${"1" eq range.serial_type}'>Base16</c:if>
					<c:if test='${"2" eq range.serial_type}'>MAC</c:if>
					<c:if test='${"4" eq range.serial_type}'>自定义</c:if>	
					</td>
					<td >
					${range.range_width} : ${range.range_min}~${range.range_max}					
					</td>
					<td>
					<a href="javascript:getAPDevice('<%=request.getContextPath()%>','${model_id}','${range.id}');"  >${range.ap}</a>
					</td>
					</tr>
					</c:forEach>
 				</tr>					
	
	</tbody>
		</table>
</form>

</div>
<div class="bottom-div" >
	<HR style="FILTER: progid:DXImageTransform.Microsoft.Shadow(color:#987cb9,direction:145,strength:15)" width="100%" color=#987cb9 SIZE=1>
	<div id="cgdata"></div>
</div>	


</body>
</html>
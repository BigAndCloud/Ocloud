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

//var d = new Dialog("添加通道", "channel/addchannel?channel_type="+channel_type+"&property_id"), 400, 300)
function addproperty() {
	
	var d = new Dialog("添加属性", "property/addpropertyPage", 500, 400);
	d.show();
}


function addChannel(property_id) {
	var d = new Dialog("添加通道", "channel/addchannelPage?property_id="+property_id , 500, 400);
	d.show();
}


function deleteproperty(id){
	if(!window.confirm("确定要删除吗？")){
		return ;
	}
	window.location.href = "<%=request.getContextPath()%>/property/deleteproperty?id="+id;
}
function updateproperty(id){
	///property/updatepropertyPage?id=${c.id}
	var d = new Dialog("修改属性","property/updatepropertyPage?id="+id);
	d.show();
}


</script>	

</head>

<body>
<div class="sensor-div">
<form action="<%=request.getContextPath()%>/property/propertylistPage" method="post" id="form1">
	
	
	<table width="100%" id="t" cellspacing="0" cellpadding="2" class="dataTable" border="2px" bordercolor="blue">
		<tbody>
		<tr>
				<td height="30" class="thOver" colspan="2" align="left"><strong>属性列表</strong>
				</td>
				<td colspan="1">
				 <a href="javascript:addproperty();">增加属性</a>
				</td>
			</tr>
				<tr class="dataTableHead">
					
					<td >属性名称，别名</td>
					<td >创建时间</td>
					<td >操作</td> 
					
						
					</tr>					
				<c:forEach items="${list}" var="c" varStatus="num">
				<tr>
				
					<td title="${c.name}${c.alias}" >
					<a href="<%=request.getContextPath()%>/property/updateproperty?id=${c.id}">${c.name}(${c.alias})</a></td>
				
					<td title="${c.created_at}">
					<fmt:formatDate value="${c.created_at}" pattern="yyyy-MM-dd  HH:mm:ss"/></td>
					
					<td title="delete" >
					<a ></a>
					<a href="javascript:updateproperty('${c.id}')">编辑</a>
					<c:if test="${'0' eq c.chans}"><a href="javascript:addChannel('${c.id}')">增加通道</a></c:if>
					<c:if test="${'1' eq c.chans}"><a href="<%=request.getContextPath()%>/channel/channellist?property_id=${c.id}">查看通道</a></c:if>
					
					 </td>
					</tr>
 									
				</c:forEach>
		
	</tbody>
	</table>
	


</form>
</div>
</body>
</html>
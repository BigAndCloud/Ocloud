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

function addChannel(channel_type,property_id) {
	var d = new Dialog("添加通道", "channel/addchannelPage?channel_type="+channel_type+"&property_id="+property_id , 500, 400);
	d.show();
}




function deletedChannel(id){
	if(!window.confirm("确定删除吗？")) {
		return;
	}
	window.location.href="<%=request.getContextPath() %>/channel/deletechannel?id="+id;
}

</script>	

</head>

<body>
<div class="sensor-div">
<form action="<%=request.getContextPath()%>/channel/channellist" method="post" id="form1">
	
	<table width="100%" cellspacing="0" cellpadding="2" class="dataTable" border="2px" bordercolor="blue">
		<tbody>
		<tr>
		<td colspan="6"><input type="hidden" name="property_id" id="property_id" value="${property_id}" /> </td>
		</tr>
		<tr class="dataTableHead">
				<td height="30" class="thOver" colspan="4" align="left"><strong>静态通道列表</strong>
				</td>
				<td colspan="1">
				<a href="javascript:addChannel(0,'${property_id}');">添加</a>
				</td>
				</tr>
				<tr class="dataTableHead">
					<td width="10%" height="30" class="thOver">静态通道名称(简称)</td>
					<td width="10%" height="30" class="thOver">数据类型</td>
					<td width="10%" height="30" class="thOver">通道说明</td>
					<td width="10%" height="30" class="thOver">创建时间</td>
					<td width="10%" height="30" class="thOver">删除时间</td>
					<td width="20%" height="30" colspan="2" class="thOver">操作</td> 
					</tr>
				
			<c:forEach items="${channel1}" var="c" varStatus="num">
				<tr>
					
					<td title="${c.name}${c.alias}" >
					<a href="<%=request.getContextPath()%>/channel/updatechannel?id=${c.id}">${c.name}(${c.alias})</a></td>
					<td title="${c.base_type}" >
					<c:if test="${c.base_type == 0}"  >文本</c:if>
					<c:if test="${c.base_type == 1}"  >二进制</c:if>
					<c:if test="${c.base_type == 2}"  >布尔型</c:if>
					<c:if test="${c.base_type == 3}"  >枚举</c:if>
					<c:if test="${c.base_type == 4}"  >整数</c:if>
					<c:if test="${c.base_type == 5}"  >小数型</c:if>
					<c:if test="${c.base_type == 6}"  >扩展数据零值</c:if>
					<c:if test="${c.base_type == 7}"  >扩展数据时间型</c:if>
					<c:if test="${c.base_type == 8}"  >扩展二维矩阵</c:if>
					<c:if test="${c.base_type == 9}"  >扩展三维空间矢量型</c:if>
					</td>
					<td title="${c.description}">${c.description}</td>
					<td title="${c.created_at}"><fmt:formatDate value="${c.created_at}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td title="${c.deleted_at}"><fmt:formatDate value="${c.deleted_at}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td title="delete" >
					<a href="#" onclick="deletedChannel(${c.id})" style="cursor: hand;">删除</a>
					
					<a href="<%=request.getContextPath()%>/channel/updatechannelPage?id=${c.id}">编辑</a>
					 </td>
					</tr>
 									
				</c:forEach>
	</tbody>
	</table>
&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;	
	<HR style="FILTER: alpha(opacity=0,finishopacity=100,style=1)" width="100%" color=#987cb9 SIZE=3>
&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;	
	<table width="100%" cellspacing="0" cellpadding="2" class="dataTable" border="2px" bordercolor="blue">
		<tbody>
		<tr>
		<td colspan="6"><input type="hidden" name="property_id" id="property_id" value="${property_id}" /> </td>
		</tr>
		<tr class="dataTableHead">
				<td height="30" class="thOver" colspan="4" align="left"><strong>动态通道列表</strong>
				</td>
				<td colspan="1">
				<a href="javascript:addChannel(1,'${property_id}');">添加</a>
				</td>
				</tr>
				<tr class="dataTableHead">
					<td width="10%" height="30" class="thOver">静态通道名称(简称)</td>
					<td width="10%" height="30" class="thOver">数据类型</td>
					<td width="10%" height="30" class="thOver">通道说明</td>
					<td width="10%" height="30" class="thOver">创建时间</td>
					<td width="10%" height="30" class="thOver">删除时间</td>
					<td width="20%" height="30" colspan="2" class="thOver">操作</td> 
					</tr>
				
			<c:forEach items="${channel2}" var="c2" varStatus="num">
				<tr>
					
					<td title="${c2.name}${c2.alias}" >
					<a href="<%=request.getContextPath()%>/channel/updatechannel?id=${c2.id}">${c2.name}(${c2.alias})</a></td>
					<td title="${c2.base_type}" >
					<c:if test="${c2.base_type == 0}"  >文本</c:if>
					<c:if test="${c2.base_type == 1}"  >二进制</c:if>
					<c:if test="${c2.base_type == 2}"  >布尔型</c:if>
					<c:if test="${c2.base_type == 3}"  >枚举</c:if>
					<c:if test="${c2.base_type == 4}"  >整数</c:if>
					<c:if test="${c2.base_type == 5}"  >小数型</c:if>
					<c:if test="${c2.base_type == 6}"  >扩展数据零值</c:if>
					<c:if test="${c2.base_type == 7}"  >扩展数据时间型</c:if>
					<c:if test="${c2.base_type == 8}"  >扩展二维矩阵</c:if>
					<c:if test="${c2.base_type == 9}"  >扩展三维空间矢量型</c:if>
					</td>
					<td title="${c2.description}">${c2.description}</td>
					<td title="${c2.created_at}"><fmt:formatDate value="${c2.created_at}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td title="${c2.deleted_at}"><fmt:formatDate value="${c2.deleted_at}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td title="delete" >
					<a href="#" onclick="deletedProperty(${c2.id})" style="cursor: hand" >删除</a>
					
					<a href="<%=request.getContextPath()%>/channel/updatechannel?id="${c2.id}>编辑</a>
					 </td>
					</tr>
 									
				</c:forEach>
	</tbody>
	</table>
	
</form>
</div>
</body>
</html>
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


</script>	

</head>

<body>
<div class="sensor-div">
<form action="<%=request.getContextPath()%>/deviceModel/modelListDeve" method="post" id="form1">
	
	
	<table width="100%" id="t" cellspacing="0" cellpadding="2" class="dataTable" border="2px" bordercolor="blue">
		<tbody>
		<tr class="dataTableHead">
				<td height="30" class="thOver" colspan="5" align="left"><strong>属性列表</strong>
				</td>
			</tr>
				<tr class="dataTableHead">
					
					<td width="10%" height="30" class="thOver">模板名称，ID</td>
					<td width="10%" height="30" class="thOver">模板图片地址</td>
					<td width="10%" height="30" class="thOver">接入/规划数量</td>
					<td width="10%" height="30" class="thOver">状态</td>
					
						
					</tr>					
				<c:forEach items="${list}" var="model" varStatus="num">
				<tr>
				
					<td title="${model.model_name}${model.model_id}" >
					<a href="">${model.model_name}(${model.model_id})</a></td>
					<td title="${model.picture}" >${model.picture}</td>
					<td title="" ></td>
					<td title="${model.audit_status}" >
					<c:if test="${model.audit_status == 3}"  ><span style="color: red">模板已生成</span></c:if>
					<c:if test="${model.audit_status == 0}"  ><span style="color: red">已提交审批</span></c:if>
					<c:if test="${model.audit_status == 1}"  ><span style="color: red">审批驳回</span></c:if>
					<c:if test="${model.audit_status == 2}"  ><span style="color: red">已重新提交</span></c:if>
					<c:if test="${model.audit_status == 8}"  ><span style="color: red">审核通过</span>（${model.updated_at}）</c:if>
					</td>
					</tr>
 									
				</c:forEach>
		
	</tbody>
	</table>
	


</form>
</div>
</body>
</html>
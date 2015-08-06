<%@page import="com.ourselec.ocloud.util.StringUtil"%>
<%@page import="java.math.BigDecimal"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/default.css">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/jquery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Dialog.js"></script>	
</head>
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


// Y.Lei

</script>
<body>
	<div class="sensor-div">

						<form action="<%=request.getContextPath()%>/admin/deviceModelAudit"
						method="post">
							<table  cellspacing="2" cellpadding="2" >
								<tr>
									<td align="right">申请日期:
									<input type="text" name="createtime" id="createtime" value="${param.createtime}"  class="Wdate" style="width:110px"/>
									--  <input type="text" name="endtime" id="endtime" value="${param.endtime}" class="Wdate" style="width:110px"/></td>
									
									<td align="right">申请模型名称:<input type="text" name="model_name" id="model_name" value="${param.model_name}"  style="width:110px"/></td>	
									<td >审核状态:
									<select name="audit_status" id="audit_status" style="width:80px" >
										<option value=""></option>
										<option value="0" <c:if test='${"0" eq param.audit_status}'>selected</c:if>>初次提交</option>
										<option value="1" <c:if test='${"1" eq param.audit_status}'>selected</c:if>>驳回申请</option>
										<option value="2" <c:if test='${"2" eq param.audit_status}'>selected</c:if>>资料更新</option>
										<option value="8" <c:if test='${"8" eq param.audit_status}'>selected</c:if>>审核通过</option>
									</select></td>
									<td></td>
									<td align="center"><input type="submit" value="查询" class="inputButton">
									</td>
								</tr>
								
							</table>
							</form>
			
					<form action="<%=request.getContextPath()%>/admin/deviceModelAuditPage" method="post">
					<table cellspacing="0" cellpadding="2">
						<tbody>
						<tr >
						<th width="10%" height="30" class="thOver">厂商</th>
						<th width="10%" height="30" class="thOver">模型名称</th>
						
						<th width="10%" height="30" class="thOver">关联设备</th>
						<th width="10%" height="30" class="thOver">提交时间</th>
						<th width="10%" height="30" class="thOver">描述</th>
						<th width="10%" height="30" class="thOver">审核状态</th>
					</tr>
							
								<c:forEach items="${list}" var="model" varStatus="num">
									<tr align="center" >
										<td title="${model.vendor.company_name}" >${model.vendor.company_name}</td>
										<td title="${model.model_name}">${model.model_name}</td>
										<td title="${model.device.name}" >
										<a href="<%=request.getContextPath()%>/device/getdevice?source_id=${model.device.device_id}">
										 ${model.device.name}( ${model.device.alias} )
										 </a>
										</td>
										
										<td title="${model.created_at}" >
										<fmt:formatDate value="${model.created_at }" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td title="${model.comment}" >${model.comment}</td>
									
										<td title="${model.audit_status}" >
										<c:if test="${model.audit_status == 0}"  ><span style="color: red">初次提交</span><a href="<%=request.getContextPath()%>/admin/toupdateModelAudit?id= ${model.id}">（审核信息）</a></c:if>
										<c:if test="${model.audit_status == 1}"  ><span style="color: red">驳回申请</span></c:if>
										<c:if test="${model.audit_status == 2}"  ><span style="color: red">更新资料</span><a href="<%=request.getContextPath()%>/admin/toupdateModelAudit?id= ${model.id}">（再次审核）</a></c:if>
										<c:if test="${model.audit_status == 8}"  ><span style="color: red">审核通过</span></c:if>
										</td>
 									</tr>
 									
								</c:forEach>
								
						</tbody>
					</table>
					</form>
		
</div>
</body>
</html>
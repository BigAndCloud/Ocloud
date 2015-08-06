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
	
					<form action="<%=request.getContextPath()%>/admin/vendorAuditSearch"
						method="post">
						
							<table cellspacing="2" cellpadding="2" id = "match">
								<tr>
									<td >申请日期:
									<input type="text" name="createtime" id="createtime" value="${param.createtime}"  class="Wdate" style="width:110px"/>
									--  <input type="text" name="endtime" id="endtime" value="${param.endtime}" class="Wdate" style="width:110px"/></td>
									
									<td>申请人:<input type="text" name="username" id="username" value="${param.username}"  style="width:110px"/></td>	
									<td>申请厂商ID:<input type="text" name="vendor_id" id="vendor_id" value="${param.vendor_id}" style="width:110px"/></td>
								
									<td>所属行业:
									<select name="company_industry" id="company_industry"  >
										<option value=""></option>
										<option value="0" <c:if test='${"0" eq param.company_industry}'>selected</c:if>>初次提交</option>
										<option value="1" <c:if test='${"1" eq param.company_industry}'>selected</c:if>>驳回申请</option>
										<option value="2" <c:if test='${"2" eq param.company_industry}'>selected</c:if>>资料更新</option>
										<option value="8" <c:if test='${"8" eq param.company_industry}'>selected</c:if>>审核通过</option>
									</select>
									</td>
									<td>是否启用
									<select name="is_enabled" id="is_enabled"  >
										<option value=""></option>
										<option value="0" <c:if test='${"0" eq param.is_enabled}'>selected</c:if>>使用</option>
										<option value="1" <c:if test='${"1" eq param.is_enabled}'>selected</c:if>>禁用</option>
									</select>
									</td>
									<td >审核状态:
									<select name="audit_status" id="audit_status"  >
										<option value=""></option>
										<option value="0" <c:if test='${"0" eq param.audit_status}'>selected</c:if>>初次提交</option>
										<option value="1" <c:if test='${"1" eq param.audit_status}'>selected</c:if>>驳回申请</option>
										<option value="2" <c:if test='${"2" eq param.audit_status}'>selected</c:if>>资料更新</option>
										<option value="8" <c:if test='${"8" eq param.audit_status}'>selected</c:if>>审核通过</option>
									</select></td>
								
									</tr>
									<tr>
									
									
									<td align="right" colspan="6"><input type="submit" value="查询" class="inputButton">
									</td>
								</tr>
							</table>
							</form>
	
	
	
					<form action="<%=request.getContextPath()%>/admin/vendorauditPage" method="post">
					<table cellspacing="0" cellpadding="2"
						class="dataTable">
						<tbody>
						<tr class="dataTableHead">
						<td width="10%" height="30" class="thOver">申请人</td> 
						<td width="10%" height="30" class="thOver">厂商ID</td>
						<td width="15%" height="30" class="thOver">公司名称</td>
						<td width="10%" height="30" class="thOver">公司规模</td>
						<td width="10%" height="30" class="thOver">提交时间</td>
						<td width="10%" height="30" class="thOver">是否启用</td>
						<td width="10%" height="30" class="thOver">审核状态</td>
						
						
						
					</tr>
							
								<c:forEach items="${list}" var="vendor" varStatus="num">
									<tr>
										<td title="${vendor.user_name}" name="user_name" value="${vendor.user_name}">${vendor.user_name}</td>
										<td title="${vendor.vendor_id}" name="vendor_id" value="${vendor.vendor_id}">${vendor.vendor_id}</td> 
										<td title="${vendor.company_name}" name="company_name" value="${vendor.company_name}">
										<a href="<%=request.getContextPath()%>/vendor/getvendor?id=${vendor.id}" >${vendor.company_name}</a>
										</td>
										
										
										<td title="${vendor.company_size}" name = "total_num" value="${vendor.company_size}">${vendor.company_size}</td>
										<td title="${vendor.created_at}" name = "created_at" value="${vendor.created_at}">
										<fmt:formatDate value="${vendor.created_at }" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td title="${vendor.is_enabled}" >
										<c:if test="${vendor.is_enabled == 1}"  >使用</c:if>
										<c:if test="${vendor.is_enabled == 0}"  ><span style="color: red">禁用</span></c:if>
										
										</td>
										<td title="${vendor.audit_status}" >
										<c:if test="${vendor.audit_status == 0}"  ><span style=" color: red">初次提交<a href="<%=request.getContextPath()%>/admin/toVendorAudit?id= ${vendor.id}">审核</a></span></c:if>
										<c:if test="${vendor.audit_status == 1}"  ><span style=" color: red">驳回申请</span></c:if>
										<c:if test="${vendor.audit_status == 2}"  ><span style=" color: red">更新资料<a href="<%=request.getContextPath()%>/admin/toVendorAudit?id= ${vendor.id}">审核</a></span></c:if>
										<c:if test="${vendor.audit_status == 8}"  ><span style=" color: red">审核通过</span></c:if>
										</td>
										
										
										
 									</tr>
 									
								</c:forEach>
								
						</tbody>
					</table>
					</form>
	
	</div>
</body>
</html>
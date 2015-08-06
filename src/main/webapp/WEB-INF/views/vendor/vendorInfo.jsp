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
	<form action="<%=request.getContextPath()%>/admin/vendorAudit" method="post">
	<table width="100%" cellspacing="0" cellpadding="0">
		<tbody>
			<tr>
				<td	style="padding-top: 2px; padding-left: 6px; padding-right: 6px; padding-bottom: 2px;">
					<table width="90%" cellspacing="0" cellpadding="2"
						class="dataTable" border="1px">
						<tbody>
						<tr class="dataTableHead">
						<td width="10%" height="30" class="thOver">申请人</td>
						<td title="${users.username}" >${users.username}</td>
						</tr>
						<tr>
						<td width="10%" height="30" class="thOver">厂商ID</td>
						<td width="60%" title="${vendor.vendor_id}" >${vendor.vendor_id}</td>
						</tr>
						<tr>
						<td width="10%" height="30" class="thOver">公司名称</td>
						<td title="${vendor.company_name}" >${vendor.company_name}</td>
						</tr>
						<tr>
						<td width="10%" height="30" class="thOver">公司主页</td>
						<td title="${vendor.company_url}" >${vendor.company_url}</td>
						</tr>
						<tr>
						<td width="10%" height="30" class="thOver">所属行业</td>
						<td title="${vendor.company_industry}" >
										<c:if test="${vendor.company_industry == 0}"  >信息产业，电脑软件，网络工程等</c:if>
										<c:if test="${vendor.company_industry == 1}"  >重工业 石油化工，化工产品设计等</c:if>
										<c:if test="${vendor.company_industry == 2}"  >水利水电，防洪工程、电力工程等</c:if>
										<c:if test="${vendor.company_industry == 3}"  >交通运输，轮胎汽车、航空交通 配件等</c:if>
										</td>
						</tr>
						<tr>
						<td width="10%" height="30" class="thOver">公司规模</td>
						<td title="${vendor.company_size}" >${vendor.company_size}</td>
						</tr>
						<tr>
						<td width="10%" height="30" class="thOver">联系人姓名</td>
						<td title="${vendor.contact_name}" >${vendor.contact_name}</td>
						</tr>
						<tr>
						<td width="20%" height="30" class="thOver">联系人手机号</td>
							<td title="${vendor.contact_number}">${vendor.contact_number}</td>
						</tr>
						<tr>
						<td width="20%" height="30" class="thOver">联系人email</td>
						<td title="${vendor.contact_email}">${vendor.contact_email}</td>
						</tr>
						<tr>
						<td width="20%" height="60" class="thOver">项目概述</td>
						<td title="${vendor.project_overview}" >${vendor.project_overview}</td>
						</tr>
						<tr>
						<td colspan="2"></td>
						</tr>
						<tr>
						<td width="15%" height="60" class="thOver">合作预期</td>
						<td title="${vendor.cooperation_prospect}" >${vendor.cooperation_prospect}</td>
						</tr>
						<tr>
						<td width="10%" height="30" class="thOver">图文资料</td>
							<td title="${vendor.graphic_texture_data}" >${vendor.graphic_texture_data}</td>
						</tr>
						<tr>
						<td width="20%" height="30" class="thOver">审核状态</td>
						<td title="${vendor.audit_status}" >
										<c:if test="${vendor.audit_status == 0}"  ><span style=" color: red">初次提交<a href="<%=request.getContextPath()%>/admin/toVendorAudit?id= ${vendor.id}">审核</a></span></c:if>
										<c:if test="${vendor.audit_status == 1}"  ><span style=" color: red">驳回申请</span></c:if>
										<c:if test="${vendor.audit_status == 2}"  ><span style=" color: red">更新资料<a href="<%=request.getContextPath()%>/admin/toVendorAudit?id= ${vendor.id}">审核</a></span></c:if>
										<c:if test="${vendor.audit_status == 8}"  ><span style=" color: red">审核通过</span></c:if>
										</td>
						</tr>
						<tr>
						<td width="15%" height="30" class="thOver">是否启用</td>
						
										<td title="${vendor.is_enabled}" >
										<c:if test="${vendor.is_enabled == 1}"  >使用</c:if>
										<c:if test="${vendor.is_enabled == 0}"  ><span style="color: red">禁用</span></c:if>
										
										</td>
						</tr>
						<tr>
						<td width="10%" height="30" class="thOver">提交时间</td>
							<td title="${vendor.created_at}" >
										<fmt:formatDate value="${vendor.created_at }" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
						</tr>
						
					
 									
								
						</tbody>
					</table>
				</td>
			</tr>
			
		</tbody>
	</table>
	</form>
	</div>
</body>
</html>
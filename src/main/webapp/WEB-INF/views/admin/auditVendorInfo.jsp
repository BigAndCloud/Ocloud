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

function auditOK(){
	if(!window.confirm("确定通过吗？")) {
		return;
	}{
			$.ajax({
				url:"<%=request.getContextPath() %>/admin/vendorAudit",
				type:"POST",
				data:"id=" + $.trim($("#id").val()) + "&audit_comments=" + $.trim($("#audit_comments").val())+"&user_id="+$.trim($("#user_id").val())+"&audit_status=8&is_enabled=1&submit_by=1",
			
				success:function(data){
						window.location = "<%=request.getContextPath()%>/admin/vendorAuditPage";
						//Page.endWait();
					Dialog.alert("审核完成");
					}
			});
			
	}
}
function auditNO(){
	if($.trim($("#audit_comments").val())==""){
		Dialog.alert("请输入驳回原因");
		return;
	} if(!window.confirm("确定驳回吗？")) {
		return;
	}{
	$.ajax({
		url:"<%=request.getContextPath() %>/admin/vendorAudit",
		type:"POST",
		data:"id=" + $.trim($("#id").val()) + "&audit_comments=" + $.trim($("#audit_comments").val())+"&user_id="+$.trim($("#user_id").val())+"&audit_status=1&is_enabled=0&submit_by=1",
		success:function(data){
			window.location = "<%=request.getContextPath()%>/admin/vendorAuditPage";
			//Page.endWait();
		Dialog.alert("审核完成");
		}
	
	});
	}
}

// Y.Lei

</script>
<body>

<div class="sensor-div">
				<table border="2px" cellspacing="2px" cellpadding="2px">
						<tbody>
						<tr>
						<td  colspan="3" ><input type="hidden" name="id" id="id" value="${vendor.id}"/></td>
						<td  ><input type="hidden" name="user_id" id="user_id" value="${vendor.user_id}"/></td>
						</tr>
						<tr bordercolor="gray">
						<td width="15%" height="30" class="thOver">申请人</td>
						<td title="${users.username}" >${users.username}</td>
							
							<td  height="30" class="thOver">是否启用</td>
							<td title="${vendor.is_enabled}" >
							<c:if test="${vendor.is_enabled == 1}"  >使用</c:if>
							<c:if test="${vendor.is_enabled == 0}"  >禁用</c:if>
								</td>
										
							<td title="${vendor.audit_status}" >
										<c:if test="${vendor.audit_status == 0}"  ><span style=" color: red">初次提交</span></c:if>
										<c:if test="${vendor.audit_status == 1}"  ><span style=" color: red">驳回申请</span></c:if>
										<c:if test="${vendor.audit_status == 2}"  ><span style=" color: red">更新资料</span></c:if>
										<c:if test="${vendor.audit_status == 8}"  ><span style=" color: red">审核通过</span></c:if>
										</td>
						</tr>
						<tr>
						
						<td width="auto" height="30" class="thOver">厂商ID</td>
						<td  title="${vendor.vendor_id}" >${vendor.vendor_id}</td>
						<td width="auto" height="30" class="thOver">联系人姓名</td>
						<td title="${vendor.contact_name}" >${vendor.contact_name}</td>
						
						</tr>
						<tr>
						<td width="auto" height="30" class="thOver">公司名称</td>
						<td title="${vendor.company_name}" >${vendor.company_name}</td>
						<td  height="30" class="thOver">联系人手机号</td>
						<td title="${vendor.contact_number}" >${vendor.contact_number}</td>
						</tr>
						<tr>
						<td width="auto" height="30" class="thOver">公司主页</td>
						<td title="${vendor.company_url}" >${vendor.company_url}</td>
						<td width="auto" height="30" class="thOver">图文资料</td>
						<td title="${vendor.graphic_texture_data}" >${vendor.graphic_texture_data}</td>
						</tr>
						
						<tr  bordercolor="blue">
						<td width="auto"  height="30" class="thOver">所属行业</td>
						<td title="${vendor.company_industry}" >
										<c:if test="${vendor.company_industry == 0}"  >信息产业，电脑软件，网络工程等</c:if>
										<c:if test="${vendor.company_industry == 1}"  >重工业 石油化工，化工产品设计等</c:if>
										<c:if test="${vendor.company_industry == 2}"  >水利水电，防洪工程、电力工程等</c:if>
										<c:if test="${vendor.company_industry == 3}"  >交通运输，轮胎汽车、航空交通 配件等</c:if>
										</td>
						<td width="auto" height="30" class="thOver">公司规模</td><td title="${vendor.company_size}" >${vendor.company_size}</td>
						</tr>
						<tr>
						<td colspan="4"></td>
						</tr>
						
						<tr bordercolor="pink">
						
						<td width="auto" height="30" class="thOver">联系人email</td>
						<td title="${vendor.contact_email}" >${vendor.contact_email}</td>
						<td width="auto" height="30" class="thOver">提交时间</td>
						<td title="${vendor.created_at}" >
						<fmt:formatDate value="${vendor.created_at }" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						</tr>
						<tr>
						
						
						
						
						</tr>
					</table>
					<table width="90%" cellspacing="0" cellpadding="2"
						class="dataTable" border="1px">
						<tr>
						<td  width="150" height="60" class="thOver">项目概述</td>
						<td title="${vendor.project_overview}" >
						<textarea rows="10" cols="50" readonly="readonly" >
						${vendor.project_overview}
						</textarea>
						</td>
						</tr>
						<tr>
						<td colspan="2"></td>
						</tr>
						<tr >
						<td  height="150" class="thOver">合作预期</td>
						<td title="${vendor.cooperation_prospect}"  >
						<textarea rows="10" cols="50"  readonly="readonly">
						${vendor.cooperation_prospect}
						</textarea>
						</td>
						</tr>
								
					</table>
					<table width="45%" cellspacing="0" cellpadding="2"	style="margin-top: 10px">
			<tr>
			<tr>
				<td height="30" align="right">驳回原因</td>
				<td align="left">
				<textarea rows="5" cols="" 
				style="width: 300px;"
				id="audit_comments" 
				name="audit_comments" 
				onfocus="this.select();" >${param.audit_comments}</textarea>
				</td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
			
			<td align="left" >
			
			<img src="<%=request.getContextPath()%>/images/auditOK.png" name="acceptImg"  id="acceptImg" style="cursor:pointer"  onclick="auditOK();" /></td>
			
			<td align="right" >
						
			<img src="<%=request.getContextPath()%>/images/auditNO.png" name="refuseImg"  id="refuseImg" style="cursor:pointer" onclick="auditNO();"  /></td>
		</tr>
	</table>
	</div>		
</body>
</html>
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
	}
			$.ajax({
				url:"<%=request.getContextPath() %>/admin/updateModelAudit",
				type:"POST",
				data:"device_model_id=" + $.trim($("#modelid").val()) + "&audit_comments=" + $.trim($("#audit_comments").val())+"&audit_status=8&is_enabled=1&submit_by=1",
			
				success:function(data){
					window.location = "<%=request.getContextPath()%>/admin/deviceModelAuditPage";
					//Page.endWait();
				Dialog.alert("审核完成");
				}
			}
			);
	
}
function auditNO(){
	if($.trim($("#audit_comments").val())==""){
		Dialog.alert("请输入驳回原因");
		return;
	} else {
		document.forms[0].submit();
//		$.ajax({
//		url:"<%=request.getContextPath() %>/admin/updateModelAudit",
//		type:"POST",
//		data:"device_model_id=" + $.trim($("#modelid").val()) + "&audit_comments=" + $.trim($("#audit_comments").val())+"&audit_status=1&is_enabled=0&submit_by=1",
//	});
	}
}


// Y.Lei

</script>
<body>
<div class="sensor-div">
<form action="<%=request.getContextPath() %>/admin/updateModelAudit" method="post" id="form1">
	<table border="2px" cellspacing="2px" cellpadding="2px">
		<tbody>
			<tr class="dataTableHead">
				<td height="30" class="thOver" colspan="2" align="center"><strong>Ocloud 审批设备模型</strong>
				</td>
			</tr>
			
			<tr>
				<td colspan="1" align="left">
					<input id="developer_id" name="developer_id" style="width: 200px"  type="hidden" onfocus="this.select();" value="${model.developer_id}"/></td>
				<td><input id="device_model_id" name="device_model_id" style="width: 200px"  type="hidden" onfocus="this.select();" value="${model.id}"/></td>	
				<td><input id="audit_status" name="audit_status" style="width: 200px"  type="hidden" onfocus="this.select();" value="1"/></td>	
				<td><input id="is_enabled" name="is_enabled" style="width: 200px"  type="hidden" onfocus="this.select();" value="0"/></td>	
				<td><input id="submit_by" name="submit_by" style="width: 200px"  type="hidden" onfocus="this.select();" value="1"/></td>	
			</tr>
			<tr>
			<td height="30" align="left"  >初次提交
			
			<input id = "created_at" name="created_at" style="width:200px" readonly="readonly" onfocus="this.select();" value="${model.created_at}"/>
			</td>
			<td height="30" align="left"  >
			最近提交
			<input id = "updated_at" name="updated_at" style="width:200px" readonly="readonly" onfocus="this.select();" value="${model.updated_at}"/>
			</td>
			
			</tr>
			<tr>
				<td height="30" width="300px" align="right">厂商名称</td>
				<td align="left">
					<a href="<%=request.getContextPath()%>/vendor/getvendor?id=${vendor.id}" >${vendor.company_name}</a></td>
			</tr>
			<tr>
				<td height="30" align="right">设备来源</td>
				<td colspan="2" align="left">
				<a href="<%=request.getContextPath()%>/device/getdevice?source_id=${model.source_id}" > ${model.source_id}</a></td>
			</tr>
			
			<tr>
				<td height="30" align="right">模块名称</td>
				<td align="left">
					<input id="model_name" name="model_name" style="width: 200px"   onfocus="this.select();" value="${model.model_name}"/></td>
			</tr>
			<tr>
				<td height="30" align="right">模板ID</td>
				<td align="left">
					<input id="model_id" name="model_id" style="width: 50px"   onfocus="this.select();" value="${model.model_id}"/>&nbsp;</td><td><span  >&nbsp;</span></td>
			</tr>
			<tr>
				<td height="30" align="right">文本编辑方式</td>
				<td align="left" >
				<select id="text_encoding_id" name="text_encoding_id" title="text_encoding_id">
				<option value="0">XML</option>
				<option value="1">TXT</option>
				<option value="JSON">JSON</option>
				</select>
				</td>
				<td><span class="notnull" >忽略多个空白字符</span></td>
				</tr>
			<tr>
				<td height="30" align="right">二进制编码方法</td>
				<td align="left" >
				<select id="binary_encoding_id" name="binary_encoding_id" title="binary_encoding_id">
				<option value="0">二进制0</option>
				<option value="1">二进制1</option>
				</select>
				</td><td><span class="notnull" ></span></td>
			</tr>
			<tr>
				<td height="30" align="right">模板图片</td>
				<td align="left" >
				<input type="text" readonly="readonly" value="${model.picture}" id="picture" name="picture"/>
				</td>
			</tr>
			<tr>
				<td height="30" align="right">模板备注</td>
				<td align="left">
				<textarea rows="5" cols="" 
				style="width: 300px;"
				id="comment" 
				name="comment" 
				onfocus="this.select();" >${model.comment}</textarea>
					</td>
			</tr>
			<tr>
			
				<td height="30" align="right">来往意见</td>
			
				<td style="height: auto; width: 200px"  align="left" bgcolor="gray">
				<c:if test="${!empty DMAC}">
				<c:forEach  items="${DMAC}" var="dmac" >
				 <c:if test='${"1" eq dmac.submit_by}'> <span style="color: black">${dmac.audit_comment}：自己的</span><br/></c:if>
				 <c:if test='${"0" eq dmac.submit_by}'>厂     商：<span style="color: blue">${dmac.audit_comment}</span><br/></c:if>
				</c:forEach>
				</c:if>
				</td>
			</tr>
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
			
		</tbody>
	</table>
	</form>
	<table width="45%" cellspacing="0" cellpadding="2"	style="margin-top: 10px">
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
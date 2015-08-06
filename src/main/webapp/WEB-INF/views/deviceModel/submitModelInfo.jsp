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
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/button.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/chatbg.css">
<style type="text/css">
.me{
	padding-left:50px;
	margin-left:150px;
	padding-right:5px;
	 background-color:#000000;
  opacity: 0.9;
  border:groove;
}

</style>
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
function submint1(){
	
	if(!window.confirm("确定提交吗?")) {
		return;
	}
	document.forms[0].submit();
}

// Y.Lei

</script>
<body>
<div class="submit-div">
	<form action="<%=request.getContextPath()%>/deviceModel/updateModelSubmitAudit" method="post" id="form1">
	<table width="100%"  cellspacing="0" cellpadding="2" >
		<tbody>
			<tr class="dataTableHead">
				<td height="30" class="thOver" colspan="2" align="center"><strong>Ocloud 设备模型</strong>
				</td>
			</tr>
			<tr>
			
				<td colspan="2" align="left">
					<input id="id" name="id" type="hidden"  value="${model.id}"/></td>
				
					
					
					
			</tr>
			<tr>
				<td height="30" width="200px" align="right">厂商名称:&nbsp;</td>
				<td align="left">${vendor.company_name}
				<input id="vendorid" name="vendorid" type="hidden" value="${vendor.id}">
				<input id="audit_status" name="audit_status"  type="hidden"value="${model.audit_status}"/>
				</td>
			</tr>
		
			<tr>
				<td height="30" align="right">模块名称:&nbsp;</td>
				<td align="left">
					<input id="model_name" name="model_name" style="width: 200px"   onfocus="this.select();" value="${model.model_name}"/></td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">模板ID:&nbsp;</td>
				<td align="left">
					<input id="model_id" name="model_id" style="width: 200px"   onfocus="this.select();" value="${model.model_id}"/></td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
			<td height="30" align="right">开发者:&nbsp;</td>
				<td  align="left">
					<select name="developer_id" id ="developer_id" style="width: 200px" >
					<c:forEach items="${deveList}" var="deve">
					<option value="${deve.id}" <c:if test="${deve.id eq param.developer_id}">selected</c:if>>${deve.username}</option>
					</c:forEach>
					</select>
					</td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">文本编辑方式:&nbsp;</td>
				<td align="left" >
				<select id="text_encoding_id" name="text_encoding_id" title="text_encoding_id">
				<option value="0">XML</option>
				<option value="1">TXT</option>
				<option value="JSON">JSON</option>
				</select>
				</td>
				<td><span class="notnull" >^.^</span></td>
				</tr>
			<tr>
				<td height="30" align="right">二进制编码方法:&nbsp;</td>
				<td align="left" >
				<select id="binary_encoding_id" name="binary_encoding_id" title="binary_encoding_id">
				<option value="0">二进制0</option>
				<option value="1">二进制1</option>
				</select>
				</td><td><span class="notnull" >^.^</span></td>
			</tr>
			<tr>
			<td height="30" align="right">来源设备:&nbsp;</td>
		
			<td align="left"><input  style="color: gray;" type="text" readonly="readonly"  value="${model.source_id}" id="source_id" name="source_id"/> </td>
			<td><span class="notnull" >^.^</span></td>
			</tr>
			
			<tr>
				<td height="30" align="right">模板图片:&nbsp;</td>
				<td align="left" >
				<input type="text" readonly="readonly" value="${model.picture}" id="picture" name="picture"/>
				</td>
				<td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">模板备注:&nbsp;</td>
				<td align="left">
				<textarea rows="5" cols="" 
				style="width: 300px;"
				id="comment" 
				name="comment" 
				onfocus="this.select();" >${model.comment}</textarea>
					</td>
					<td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
			
				<td height="30" align="right">来往意见:&nbsp;</td>
			
				<td style="height: auto; width: 200px"  align="left" bgcolor="gray">
				<c:if test="${!empty DMAC}">
				<c:forEach  items="${DMAC}" var="dmac" >
				 <c:if test='${"0" eq dmac.submit_by}'><p class="triangle-border right">${dmac.audit_comment}</p></c:if>
				 <c:if test='${"1" eq dmac.submit_by}'><p class="triangle-border left">${dmac.audit_comment}</p></c:if>
				</c:forEach>
				</c:if>
				</td>
			</tr>
			
			
			<tr>
				<td height="30" align="right">信息留言:&nbsp;</td>
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
	<table width="100%" cellspacing="0" cellpadding="2" style="margin-top: -1px; border-top: 0px" border="0px">
			<tr>
			 <td align="right" colspan="3" width="600px" style="border-top: 0px;"><!-- <input type="button" value="确认提交 "  class="inputButton" onclick="submint1()"> -->
			<button class="pbtn3 btn15" style="cursor:pointer" type="button" onclick="submint1()">
			
			</button>
			
		</tr>
	</table>
	</div>
</body>
</html>
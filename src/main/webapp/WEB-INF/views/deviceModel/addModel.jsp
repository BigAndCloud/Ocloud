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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/map/jQuery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/map/map1.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Dialog.js"></script>	
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/buttons.css">
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
 	 if($.trim($("#name").val())==""){
		Dialog.alert("请填写设备原型名称");
		return;
	}else  if ($.trim($("#model_name").val())=="") {
		Dialog.alert("请输入模型名称");
		return;
	}else if ($.trim($("#model_id").val())=="") {
		Dialog.alert("请输入模型ID");
		return;
	}else if ($.trim($("#picture").val())=="") {
		Dialog.alert("请输入picture");
		return;
	}else if ($.trim($("#modelcomment").val())=="") {
		Dialog.alert("请输入模型备注");
		return;
	}else  if ($.trim($("#alias").val())=="") {
		Dialog.alert("请输入设备原型别名");
		return;
	}else  if ($.trim($("#alive_time").val())=="") {
		Dialog.alert("请输入设备的活跃时间");
		return;
	}else  if ($.trim($("#alive_time").val())=="") {
		Dialog.alert("请输入设备的活跃时间");
		return;
	}
	 
	if(!window.confirm("确定添加吗?")) {
		return;
	}
	document.forms[0].submit();
}



$(function () {
    baidu_map();
});

</script>	
<style type="text/css">

</style>
</head>

<body>

<form action="<%=request.getContextPath()%>/UpLoad/service" method="post" id="form1" enctype="multipart/form-data">
<div class="sensor-div">
	<table border="2px" cellspacing="0" cellpadding="2px">
		<tbody>
			<tr class="dataTableHead">
				<td height="30" class="thOver" colspan="3" align="center"><strong>Ocloud 添加设备模型</strong>
				</td>
			<td></td>
				<td height="30" class="thOver" colspan="3" align="center"><strong>Ocloud 添加设备原型</strong>
				</td>
			</tr>
			<tr>
				<td height="30" align="right" colspan="3">
					<input id="vendor_id"  type="hidden" name="vendor_id"value="${vendor.id}"/>
					<input id="user_id"  type="hidden" name="user_id"  value="${user_id}"/></td>
			<td></td>
				<td height="30" align="right" colspan="3"></td>
			</tr>
			<tr>
				<td height="30" align="right">厂商名称</td>
				<td align="left">
					<input id="company_name" name="company_name" style="width: 200px"   onfocus="this.select();" value="${vendor.company_name}"/></td><td><span class="notnull" >必填</span></td>
				<td></td>
				<td height="30" align="right">设备名称</td>
				<td align="left">
					<input id="name" name="name" style="width: 200px"   onfocus="this.select();" value="${param.name}"/></td><td><span class="notnull" >必填</span></td>
			</tr>
			
			<tr>
			<td height="30" align="right">开发者</td>
				<td  align="left">
					<select name="developer_id" id ="developer_id" style="width: 200px" >
					<c:forEach items="${deveList}" var="deve">
					<option value="${deve.id}" <c:if test="${deve.id eq param.developer_id}">selected</c:if>>${deve.username}</option>
					</c:forEach>
					</select>
					</td><td><span class="notnull" >必填</span></td>
				<td></td>	
				<td height="30" align="right">设备别名</td>
				<td align="left">
					<input id="alias" name="alias" style="width: 200px"   onfocus="this.select();" value="${param.alias}"/></td><td><span class="notnull" >必填</span></td>	
			</tr>
			<tr>
			<td height="30" align="right">模块名称</td>
				<td align="left">
					<input id="model_name" name="model_name" style="width: 200px"   onfocus="this.select();" value="${param.model_name}"/></td><td><span class="notnull" >必填</span></td>
			<td></td>
				<td height="30" align="right">活跃时间</td>
				<td align="left">
					<input id="alive_time" name="alive_time" style="width: 50px"   onfocus="this.select();" value="${param.alive_time}"/>&nbsp;分钟</td><td><span  >&nbsp;</span></td>			
			</tr>
			<tr>
				<td height="30" align="right">模板ID</td>
				<td align="left">
				<input id="model_id" name="model_id"  style="width: 200px"   onfocus="this.select();" value="${param.model_id}"/>&nbsp;</td><td><span  class="notnull">必填</span></td>
			<td></td>
				<td height="30" align="right">模板图片</td>
				<td align="left" >
				<input  id="picture" name="picture" class="btn" type="file" value="${param.picture}"/>
				
				</td><td><span class="notnull" >必填</span></td>
							
			
			</tr>
			<tr>

			<td height="30" align="right">设备时区</td>
				<td align="left" >
				<select id="timezone" name="timezone" title="timezone">
				<option value="Asia/shanghai">(GMT+8:00) 北京，重庆，香港，乌鲁木齐</option>
				</select>
				</td><td><span class="notnull" >必填</span></td>	
				<td></td>
			<td height="30" align="right">设备地点</td>
				<td align="left">
			<input type="text" id="suggestId" value=""  style="width: 340px" class="input-xlarge" name="address" />
                    <button class="btn" onmouseover="this.className='d_over'" onmouseout="this.className='d_out'" type="button" id="positioning">搜索</button>
             
                <script src="http://api.map.baidu.com/api?key=D9S918lGOnIlK3PCUz4YRluN&v=1.1&services=true" type="text/javascript" type="text/javascript" /></script>
               
                <div id="l-map" style="width:500px; height:300px;">
                    <i class="icon-spinner icon-spin icon-large"></i>地图加载中...
                </div>
               
                    <input type="hidden" id="lng" name="lng"  value="${param.lng}" /><input type="hidden" id="lat" value="${param.lat}" name="lat" />
			
			
			</td><td><span class="notnull" >必填</span></td>
			
			</tr>
			<tr>
				<td height="30" align="left" colspan="3">文本编辑方式
				<select id="text_encoding_id" name="text_encoding_id" title="text_encoding_id">
				<option value="0">XML</option>
				<option value="1">TXT</option>
				<option value="JSON">JSON</option>
				</select>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				二进制编码方法:
				<select id="binary_encoding_id" name="binary_encoding_id" title="binary_encoding_id">
				<option value="0">二进制0</option>
				<option value="1">二进制1</option>
				</select>
				</td>
				</tr>
		
			<tr>
				<td height="30" align="right">模板备注</td>
				<td align="left">
				<textarea rows="5" cols=""
				style="width: 300px;"
				id="modelcomment" 
				name="modelcomment" 
				onfocus="this.select();" >${param.comment}</textarea>
					</td><td><span class="notnull" >必填</span></td>
					<td></td>
					<td height="30" align="right">备注</td>
				<td align="left">
				<textarea rows="5" cols=""
				style="width: 300px;"
				id="devicecomment" 
				name="devicecomment" 
				onfocus="this.select();" >${param.comment}</textarea>
					</td><td><span class="notnull" >必填</span></td>
			</tr>
		
			
		</tbody>
	</table>
	<div style="border-top:  1px solid #D0D0D0; width: 100% ; float:right;" >
	<table width="100%" style="margin-bottom:20px; border-top: 0px">
			<tr>
			 <td align="right" colspan="3"  style="border-top: 0px; " >
			 <input style="cursor: pointer;" class="submit-big-gray" value="生成设备模型" type="button"onclick="submint1()"/>
			<!-- <!-- <button class="submit-big-gray" style="cursor:pointer"onclick="submint1()" value="生成设备模型 ">生成设备模型 </button> --> -->
			
		</tr>
	</table>
	</div>

	</div>
	
		
</form>

</body>
</html>
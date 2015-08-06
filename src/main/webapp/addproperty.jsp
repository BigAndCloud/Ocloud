<%@page import="com.ourselec.ocloud.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

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
function submint1(){
	if($.trim($("#alias").val())==""){
		Dialog.alert("请输入别称");
		return;
	}else if ($.trim($("#name").val())=="") {
		Dialog.alert("请输入属性名称");
		return;
	}else if ($.trim($("#calias").val())=="") {
		Dialog.alert("请输通道别称");
		return;
	}else if ($.trim($("#cname").val())=="") {
		Dialog.alert("请输入通道名称");
		return;
	}
	if(!window.confirm("确定添加吗?")) {
		return;
	}
	document.forms[0].submit();
}

function openinfo(name) {
	var info = $("#" + $("#" + name + "_batchcode").val()).val().split("_");
	if("0" == info[6]) {
		Dialog.alert("当前期没有开奖信息");
		return;
	}
	var d = new Dialog("开奖信息", "property/addproperty?info=" + ($("#" + name + "_batchcode").val()), 400, 300);
	d.show();
}

function addLine(i){
 var table = document.getElementById("t");
// 2 代表 向表格的第二列一下添加

var tr = table.insertRow(table.rows.length );
tr.idName = "channel"; //添加class
var td = tr.insertCell(0);
td.innerHTML ="<input type='hidden'  name='channel_type' value='"+i+"' >" ;
var td = tr.insertCell(1);
td.innerHTML = "<input type='text' name='cname' id='cname' value='${pro.name}' />" ;
var td = tr.insertCell(2);
td.innerHTML ="<input type='text' name='calias' id='calias' value='${pro.alias}' />" ;

var td = tr.insertCell(3);
td.innerHTML = "<select name='base_type' id='base_type'><option value='0' <c:if test='${0 eq pro.base_type}'>selected</c:if>>小数点</option><option value='1' <c:if test='${1 eq pro.base_type}'>selected</c:if>>二维矩阵</option> <option value='2' <c:if test='${2 eq pro.base_type}'>selected</c:if>>整数</option>" ;
//
var td = tr.insertCell(4);
td.innerHTML ="<input type='text' name='description' id='description' value='${pro.description}' />" ;

var td = tr.insertCell(5);
td.innerHTML ="<a href='javascript:deleteChannel();'>删除</a>" ;


}


function delChannelAll()
{
document.getElementById('myTable').deleteRow(0)
}

function deleteChannel(obj) {  
}  



</script>	

</head>

<body>
<form action="<%=request.getContextPath()%>/property/addproperty" method="post" id="form1">
	<table width="50%" cellspacing="0" cellpadding="2" class="dataTable">
		<tbody>
			<tr class="dataTableHead">
				<td height="30" class="thOver" colspan="2" align="center"><strong>Ocloud 添加属性</strong>
				</td>
			</tr>
			
			<tr>
				<td height="30" align="right">属性名称</td>
				<td align="left">
					<input id="name" name="name" style="width: 200px"   onfocus="this.select();" value="${param.name}"/></td><td><span class="notnull" >必填</span></td>
			</tr>
			<tr>
				<td height="30" align="right">属性别名</td>
				<td align="left">
					<input id="alias" name="alias" style="width: 200px"   onfocus="this.select();" value="${param.alias}"/></td><td><span class="notnull" >必填</span></td>
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
				<td height="30" align="right"></td>
				<td align="left" >
				<select id="binary_encoding_id" name="binary_encoding_id" title="binary_encoding_id">
				<option value="0">二进制0</option>
				<option value="1">二进制1</option>
				</select>
				</td><td><span class="notnull" ></span></td>
			</tr>
		</tbody>
	</table>
	<HR style="FILTER: alpha(opacity=0,finishopacity=100,style=1)" width="100%" color=#987cb9 SIZE=3>
	
	<table width="100%" name="t" id="t" cellspacing="0" cellpadding="2" class="dataTable" border="2px" bordercolor="blue">
		<tbody>
		<tr class="dataTableHead">
				<td height="30" class="thOver" colspan="5" align="left"><strong>静态属性列表</strong>
				</td>
				<td colspan="1">
				 
				<a href="javascript:addLine(0);">添加一列</a>

				</td>
			</tr>
				<tr class="dataTableHead">
					<td width="10%" height="30" class="thOver">选择</td>
					<td width="10%" height="30" class="thOver">静态通道名称，别名</td>
					<td width="10%" height="30" class="thOver">数据类型</td>
					<td width="10%" height="30" class="thOver">通道说明</td>
					<td width="10%" height="30" class="thOver">创建时间</td>
					<td width="10%" height="30" class="thOver">操作</td> 
					
						
					</tr>					
			<c:forEach items="${property}" var="pro" varStatus="num">
				<tr>
					<td>
					<input type="checkbox" />
					</td>
					<td title="${pro.name}${pro.alias}" >
					<a href="<%=request.getContextPath()%>/device/updatechannel?id=${pro.id}">${pro.name}(${pro.alias})</a></td>
					<td title="${pro.created_at}">${pro.created_at}</td>
					
					<td title="${pro.description}">${pro.description}</td>
					
					<td title="${pro.comment}">${pro.comment}</td>
					<td title="${pro.base_type}" >
					<c:if test="${pro.base_type == 0}"  >小数点</c:if>
					<c:if test="${pro.base_type == 1}"  >整数</c:if>
					<c:if test="${pro.base_type == 2}"  >二维矩阵</c:if>
					</td>
					<td title="delete" >
					<a href="javascript:deleteproperty('${pro.id}');">删除</a>
					 </td>
					
					</tr>
 									
				</c:forEach>
		
		
	</tbody>
	</table>
	
	
	<HR style="FILTER: alpha(opacity=0,finishopacity=100,style=1)" width="100%" color=#987cb9 SIZE=3>
	
	<table width="100%" cellspacing="0" cellpadding="2" class="dataTable" border="2px" bordercolor="azure">
		<tbody>
		<tr class="dataTableHead">
				<td height="30" class="thOver" colspan="5" align="left"><strong>动态属性列表</strong>
				</td>
				<td colspan="1">
				<a href="javascript:addLine(1);">添加一列</a>
				</td>
				</tr>
				<tr class="dataTableHead">
					<td width="5%" height="30" class="thOver">选择</td>
					<td width="10%" height="30" class="thOver">静态通道名称</td>
					<td width="10%" height="30" class="thOver">别名</td>
					<td width="10%" height="30" class="thOver">数据类型</td>
					<td width="10%" height="30" class="thOver">通道说明</td>
					<td width="20%" height="30" colspan="2" class="thOver">操作</td> 
					</tr>
			<c:forEach items="${property}" var="pro" varStatus="num">
				<tr>
					<td>
					<input type="radio" />
					</td>
					<td title="${pro.name}${pro.alias}" >
					<a href="<%=request.getContextPath()%>/device/updatechannel?id=${pro.id}">${pro.name}(${pro.alias})</a></td>
					<td title="${pro.created_at}">${pro.created_at}</td>
					
					<td title="${pro.description}">${pro.description}</td>
					
					<td title="${pro.comment}">${pro.comment}</td>
					<td title="${pro.base_type}" >
					<c:if test="${pro.base_type == 0}"  >小数点</c:if>
					<c:if test="${pro.base_type == 1}"  >整数</c:if>
					<c:if test="${pro.base_type == 2}"  >二维矩阵</c:if>
					</td>
					<td title="delete" >
					<a href="javascript:deleteproperty('${pro.id}');">删除</a>
					
					<a href="javascript:updateproperty('${pro.id}');">编辑</a>
					 </td>
					</tr>
 									
				</c:forEach>
		
		
	</tbody>
	</table>
	
	
	
	<table width="45%" cellspacing="0" cellpadding="2"	style="margin-top: 10px">
		<tr>
			<td align="center"><input type="button" value="添加 " class="inputButton" onclick="submint1()"></td>
		</tr>
	</table>
</form>
</body>
</html>
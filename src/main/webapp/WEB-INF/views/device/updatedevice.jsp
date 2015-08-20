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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/map/map.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Dialog.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/timezone.js"></script>	
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/CSS/buttons.css">
<script type="text/javascript">	



function getTimezone(){
    //获得省份下拉框的对象
    var sltProvince=document.form1.province;
    //获得城市下拉框的对象
    var sltCity=document.form1.timezone;         
    //得到对应省份的城市数组
    var provinceCity=timeData[sltProvince.selectedIndex - 1];

    //清空城市下拉框，仅留提示选项
    sltCity.length=1;

    //将城市数组中的值填充到城市下拉框中
    for(var i=0;i<provinceCity.length;i++){
        sltCity[i+1]=new Option(provinceCity[i],provinceCity[i]);
    }
}



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
		Dialog.alert("请输入设备名称");
		return;
	}else if ($.trim($("#timezone").val())=="") {
		Dialog.alert("请输入时区");
		return;
	}else if ($.trim($("#lat").val())=="") {
		Dialog.alert("请输入经度");
		return;
	}else if ($.trim($("#lng").val())=="") {
		Dialog.alert("请输入纬度");
		return;
	}else if ($.trim($("#alive_time").val())=="") {
		Dialog.alert("请输入活跃时间");
		return;
	}
	if(!window.confirm("确定添加吗?")) {
		return;
	}
	document.forms[0].submit();
}
<%
String site = (String)request.getAttribute("stie");
String lngstr = (String)request.getAttribute("lngstr");
String latstr = (String)request.getAttribute("latstr");
%>

$(function () {
    baidu_map();
});
</script>	

</head>

<body>
<div class="submit-div">
<form action="<%=request.getContextPath()%>/device/updatedevice" method="post" id="form1">
	<table width="100%" cellspacing="0" cellpadding="2" class="dataTable">
		<tbody>
			<tr class="dataTableHead">
				<td height="30" class="thOver" colspan="2" align="center"><strong>Ocloud 添加设备</strong>
				<input id="id" name="id"  type="hidden" value="${device.id}" style="width:200px" />
				</td>
			</tr>
			
			<tr>
				
				<td height="30" align="right">设备名称</td>
				<td align="left">
					<input id="name" name="name" style="width: 200px"   onfocus="this.select();" value="${device.name}"/></td>
			</tr>
			<tr>
				<td height="30" align="right">设备别名</td>
				<td align="left">
					<input id="alias" name="alias" style="width: 200px"   onfocus="this.select();" value="${device.alias}"/></td>
			</tr>
			<tr>
				<td height="30" align="right">活跃时间</td>
				<td align="left">
			
					<input id="alive_time" name="alive_time" style="width: 50px"   onfocus="this.select();" value="${device.alive_time}"/>&nbsp;分钟</td>
			</tr>
			<tr>
				<td height="30" align="right">设备时区</td>
				<td align="left" >
				<select id="timezone" name="timezone" title="timezone">
				<option value="GMT+8:00" <c:if test='${"GMT+8:00" eq device.timezone}'>selected</c:if>>(GMT+8:00) 北京，重庆，香港，乌鲁木齐</option>
				</select>
				</td>
			</tr>
			<tr>
				<td height="30" align="right">设备地点</td>
				<td align="left">
			<input type="text" id="suggestId" value=""  style="width: 340px" class="input-xlarge" name="address" data-rule-required="true" />
                    <button class="btn" type="button" id="positioning">搜索</button>
             
                <script src="http://api.map.baidu.com/api?key=D9S918lGOnIlK3PCUz4YRluN&v=1.1&services=true" type="text/javascript" type="text/javascript" /></script>
               
                <div id="l-map" style="width:500px; height:300px;">
                    <i class="icon-spinner icon-spin icon-large"></i>地图加载中...
                </div>
               
                    <input type="text" id="lng" name="lng" value="${device.lng}" /><input type="text" id="lat" value="${device.lat}" name="lat" />
			
			
			</td>
			</tr>
			<tr>
				<td height="30" align="right">描述</td>
				<td align="left">
				<textarea rows="5" cols=""
				style="width: 300px;"
				id="comment" 
				name="comment" 
				onfocus="this.select();" >${device.comment}</textarea>
					</td>
			</tr>
			<tr>
				<td height="30" align="right">设备ID</td>
				<td><input type="text" id="device_id" name="deivce_id" value="${device.device_id}" readonly="readonly" /> </td>
			</tr>
			<tr>
				<td height="30" align="right">设备Key</td>
				<td><input type="text" id="device_key" name="deivce_key" value="${device.device_key}" readonly="readonly" /> </td>
			</tr>
			
		</tbody>
	</table>
<br/>
	<table width="100%" cellspacing="0" cellpadding="2"	style="margin-top: 10px ;border-top:  1px solid #D0D0D0;">
		<tr>
			<td align="right"><input type="button" value="修改设备 " style="cursor: pointer;" class="submit-big-gray" onclick="submint1()"></td>
		</tr>
	</table>
</form>
</div>
</body>
</html>
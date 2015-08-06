<%@page import="com.ourselec.ocloud.controller.dto.UserInfoDTO"%>
<%@page import="com.ourselec.ocloud.domain.UserInfo"%>
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

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.js"></script>	
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Dialog.js"></script>	
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
<%
UserInfoDTO dtoo = (UserInfoDTO)request.getAttribute("dto");

System.out.print(dtoo.getUserinfo().getMobileId());
String modileId = dtoo.getUserinfo().getMobileId();
%>

function updateUser(user_id){
	var d = new Dialog("修改信息", "userinfo/updateuserPage?userid="+user_id, 500, 400);
	d.show();
	
}

//显示对象
function updateUsers(user_id){
    $(obj).show();    
}
//隐藏对象
function HideObj(obj){
    $(obj).hide();    
}
function updateUsers(){
    $("#updateUser").hide(); 
}
/**
 *$(function(){
		
	    var objDivs=$("#option a");  
	    objDivs.click(function(){
	        HideOperator();
	        var divName=$(this).attr("href");
	        ShowObj($(divName));
	    }); 
 */

</script>
<body>
<div class="sensor-div">
	<form action="<%=request.getContextPath()%>/userinfo/findInfo" method="post">
			<table border="2px" cellspacing="2px" cellpadding="2px">
						<tbody>
						<tr class="dataTableHead">
						<td width="10%" height="30" class="thOver">账号</td>
						<td width="10%" height="30" class="thOver">用户昵称</td>
						<td width="10%" height="30" class="thOver">电话号码</td>
						<td width="10%" height="30" class="thOver">联系地址</td>
						<td width="10%" height="30" class="thOver">创建时间</td>
						<td width="10%" height="30" class="thOver">操作</td>
						
					</tr>
					
									<tr>
										<td title="${dto.users.username}" >${dto.users.username}</td>
										<td title="${dto.userinfo.nickname}">${dto.userinfo.nickname}</td>
										<td title="${dto.userinfo.mobileId}">${dto.userinfo.mobileId}</td>
										<td title="${dto.userinfo.address}" >${dto.userinfo.address}</td>
										
										<td title="${dto.userinfo.createdAt}">
										<fmt:formatDate value="${dto.userinfo.createdAt }" pattern="yyyy-MM-dd HH:mm:ss"/>
										</td>
										<td><a href="javascript:updateUser(${dto.userinfo.user_id})" target="context" >修改</a>
										</td>
 									</tr>
 									
								
							<tr>
							<td colspan="6">
							<c:if test="${'2' eq dto.users.user_type}"></c:if>
							<c:if test="${'0' eq dto.users.user_type}"><a href="<%=request.getContextPath()%>/vendor/auth?userid= ${dto.userinfo.user_id}">申请厂商</a></c:if>
							</td>
							</tr>
						
						</tbody>
					</table>
	
	</form>
	</div>
	
	
	

</body>
</html>
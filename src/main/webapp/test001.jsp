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

ul { list-style: none; }
          
a.button {
    display: block;
    float: left;
    position: relative;
    height: 25px;
    width: 80px;
    margin: 0 10px 18px 0;
     
    text-decoration: none;
    font: 12px "Helvetica Neue", Helvetica, Arial, sans-serif;
    font-weight: bold;
    line-height: 25px;
    text-align: center;
     
    -webkit-border-radius: 3px; 
    -moz-border-radius: 3px;
    border-radius: 3px;
}
a.button:before,
a.button:after {
    content: '';
    position: absolute;
    left: -1px;
    height: 25px;
    width: 80px;
    bottom: -1px;
     
    -webkit-border-radius: 3px; 
    -moz-border-radius: 3px;
    border-radius: 3px;
}
 
a.button:before { 
    height: 23px;
    bottom: -4px;
    border-top: 0;
     
    -webkit-border-radius: 0 0 3px 3px; 
    -moz-border-radius: 0 0 3px 3px;
    border-radius: 0 0 3px 3px;
     
    -webkit-box-shadow: 0 1px 1px 0px #bfbfbf;
    -moz-box-shadow: 0 1px 1px 0px #bfbfbf;
    box-shadow: 0 1px 1px 0px #bfbfbf;
}
/* GRAY */
a.gray,
a.gray:hover,
a.gray:visited {
    color: #555;
    border-bottom: 4px solid #b2b1b1;
    text-shadow: 0px 1px 0px #fafafa;
     
    background: #eee;
    background: -webkit-gradient(linear, left top, left bottom, from(#eee), to(#e2e2e2));
    background: -moz-linear-gradient(top,  #eee,  #e2e2e2);
     
    box-shadow: inset 1px 1px 0 #f5f5f5;
}
 
.gray:before,
.gray:after {
    border: 1px solid #cbcbcb;
    border-bottom: 1px solid #a5a5a5;
}
 
.gray:hover {
    background: #e2e2e2;
    background: -webkit-gradient(linear, left top, left bottom, from(#e2e2e2), to(#eee));
    background: -moz-linear-gradient(top,  #e2e2e2,  #eee);
}




</style>

</head>

<body>
<table id="dg" style="width:700px;height:250px"title="DataGrid - SubGrid" >   
    <thead>   
        <tr>   
            <th title="id"  width="80">编号</th>   
            <th title="productid" width="100">产品ID</th>   
            <th title="listprice" align="right" width="80">价格列表</th>   
            <th title="unitcost" align="right" width="80">Unit Cost</th>   
            <th title="attr1" width="220">Attribute</th>   
            <th title="status" width="60" align="center">Status</th>   
        </tr>   
    </thead>   
</table>   
因为人们的大脑分为左右脑，因为发达的程度不同看到的上图的表情也不同。
<br/>如果你看到A图中人物是开心的，
<br/>那么你的左脑在日常生活中发挥较大的作用；如果是B图，
<br/>那么结果相反，右脑在日常生活中发挥较大的作用。那么你看到的是哪张呢？
<ul class="buttons">
    <li><a href="#" class="button gray">Download</a></li>
    <li><a href="#" class="button pink">Download</a></li>
    <li><a href="#" class="button blue">Download</a></li>
    <li><a href="#" class="button green">Download</a></li>
    <li><a href="#" class="button turquoise">Download</a></li>
    <li><a href="#" class="button black">Download</a></li>
    <li><a href="#" class="button darkgray">Download</a></li>
    <li><a href="#" class="button yellow">Download</a></li>
    <li><a href="#" class="button purple">Download</a></li>
    <li><a href="#" class="button darkblue">Download</a></li>
</ul>

<a href="#" class="button gray">Download</a>
</body>
</html>
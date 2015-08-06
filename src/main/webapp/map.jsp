<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>微盟（九瑞）—国内最大的微信公众服务平台</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/map/jQuery.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/map/map.js"></script>	
</head>
<body>
	
 

                                

       
     
                    <input type="text" id="suggestId" value="" class="input-xlarge" name="address" data-rule-required="true" />
                    <button class="btn" type="button" id="positioning">搜索</button>
             
                <script src="http://api.map.baidu.com/api?key=D9S918lGOnIlK3PCUz4YRluN&v=1.1&services=true" type="text/javascript" type="text/javascript" /></script>
                <span class="maroon">注意：这个只是模糊定位，准确位置请地图上标注!</span>
                <div id="l-map" style="width:500px; height:300px;">
                    <i class="icon-spinner icon-spin icon-large"></i>地图加载中...
                </div>
               
                    <input type="text" id="lng" name="lng" value="" /><input type="text" id="lat" value="" name="lat" />



 
    <script type="text/javascript">
 
        $(function () {
            baidu_map();
        });
    </script>
    
    </body>


<%@page import="com.ourselec.ocloud.util.StringUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Loading nested subgrid data - jQuery EasyUI Demo</title>
    <link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="http://www.jeasyui.com/easyui/demo/demo.css">
    <script type="text/javascript" src="http://www.jeasyui.com/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="http://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="http://www.jeasyui.com/easyui/datagrid-detailview.js"></script>
</head>
<body>
    <h2>Loading nested subgrid data</h2>
    <p>Click the expand button to expand row and view subgrid.</p>
    
    <table id="dg"></table>
    <script type="text/javascript">
        var conf = {
            options:{
                fitColumns:true,
                columns:[[
                    {field:'company',title:'Company Name',width:200},
                    {field:'contact',title:'Contact Name',width:200},
                    {field:'country',title:'Country',width:200}
                ]],
                data:[
                    {company:'Speed Info',contact:'Minna John',country:'Sweden'}
                ]
            },
            subgrid:{
                options:{
                    fitColumns:true,
                    foreignField:'companyid',
                    columns:[[
                        {field:'orderdate',title:'Order Date',width:200},
                        {field:'shippeddate',title:'Shipped Date',width:200},
                        {field:'freight',title:'Freight',width:200}
                    ]],
                    data:[
                        {orderdate:'08/23/2012',shippeddate:'12/25/2012',freight:9734}
                    ]
                },
                subgrid:{
                    options:{
                        fitColumns:true,
                        foreignField:'orderid',
                        columns:[[
                            {field:'price',title:'Unit Price',width:200,align:'right'},
                            {field:'quantity',title:'Quantity',width:200,align:'right'},
                            {field:'discount',title:'Discount',width:200,align:'right',formatter:function(value){
                                return value*100+'%'
                            }}
                        ]],
                        data:[
                            {price:923,quantity:2312,discount:0.2}
                        ]
                    },
                    subgrid:{
                        options:{
                            fitColumns:true,
                            foreignField:'pid',
                            singleSelect:true,
                            columns:[[
                                {field:'pnumber',title:'Product Number',width:200},
                                {field:'pname',title:'Product Name',width:200},
                                {field:'supplier',title:'Supplier',width:200}
                            ]],
                            data:[
                                {pnumber:'00100823',pname:'Canon PowerShot A1300',supplier:'Canon'},
                                {pnumber:'12023423',pname:'Cisco RV110W-A-NA-K9',supplier:'Cisco'},
                                {pnumber:'82312393',pname:'Nikon COOLPIX L26 16.1 MP',supplier:'Nikon'}
                            ]
                        }
                    }
                }
            }
        };
 
        $(function(){
            $('#dg').datagrid({
                title:'DataGrid - Nested SubGrid',
                width:700,
                height:300
            }).datagrid('subgrid', conf);
        });
    </script>
    
    
</body>
</html>
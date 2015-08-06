<script language="javascript" type="text/javascript">
    $(document).ready(function () {
        $("#test").datagrid({
            url: "/Test/Test1Data",
            type: "post",
            datatype: "json",
            width: 465,
            height: 280,
            loadMsg: "数据加载中，请稍后...",
            fitCloumns: true,
            nowrap: true,
            rownumbers: false,
            pagination: true,
            singleSelect: true,
            showFooter: true,
            columns: [[
                    { field: 'testName', title: '测试名', align: 'center' },
                    { field: 'testValue', title: '测试值', align: 'center' }
                    ]],
            //bind数据成功设置列宽度
            onLoadSuccess: function (data) {
                //datagrid头部 table 的第一个tr 的td们，即columns的集合
                var headerTds = $(".datagrid-header-inner table tr:first-child").children();
                //datagrid主体 table 的第一个tr 的td们，即第一个数据行
                var bodyTds = $(".datagrid-body table tr:first-child").children();
                var totalWidth = 0; //合计宽度，用来为datagrid头部和主体设置宽度
                //循环设置宽度
                bodyTds.each(function (i, obj) {
                    var headerTd = $(headerTds.get(i));
                    var bodyTd = $(bodyTds.get(i));
                    $("div:first-child", headerTds.get(i)).css("text-align", "center");
                    var headerTdWidth = headerTd.width(); //获取第i个头部td的宽度
                    //这里加5个像素 是因为数据主体我们取的是第一行数据，不能确保第一行数据宽度最宽，预留5个像素。有兴趣的朋友可以先判断最大的td宽度都在进行设置
                    var bodyTdWidth = bodyTd.width() + 5;
                    var width = 0;
                    //如果头部列名宽度比主体数据宽度宽，则它们的宽度都设为头部的宽度。反之亦然
                    if (headerTdWidth > bodyTdWidth) {
                        width = headerTdWidth;
                        bodyTd.width(width);
                        headerTd.width(width);
                        totalWidth += width;
                    } else {
                        width = bodyTdWidth;
                        headerTd.width(width);
                        bodyTd.width(width);
                        totalWidth += width;
                    }
                });
                var headerTable = $(".datagrid-header-inner table:first-child");
                var bodyTable = $(".datagrid-body table:first-child");
                //循环完毕即能得到总得宽度设置到头部table和数据主体table中
                headerTable.width(totalWidth);
                bodyTable.width(totalWidth);
                bodyTds.each(function (i, obj) {
                    var headerTd = $(headerTds.get(i));
                    var bodyTd = $(bodyTds.get(i));
                    var headerTdWidth = headerTd.width();
                    bodyTd.width(headerTdWidth);
                });
            }
        });
        $("#test").datagrid('getPager').pagination({
            showPageList: false,
            showRefresh: false,
            beforePageText: "第",
            afterPageText: "页 <a href='javascript:void(0)' onclick='GoEnterPage()'><img src='http://www.cnblogs.com/Content/themes/icons/Go_.gif'></a>，共{pages}页",
            displayMsg: '当前{from}到{to}条，总共{total}条'
        });
    });
    function GoEnterPage() {
        var e = jQuery.Event("keydown");
        e.keyCode = 13;
        $("input.pagination-num").trigger(e);
    }
</script>
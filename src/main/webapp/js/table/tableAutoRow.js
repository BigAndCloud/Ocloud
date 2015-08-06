//为表格主体添加单击事件,当单击时添加行数,使表格保持有n个空行  
(function ($) {  
    $.fn.extend({  
        tableAutoRow: function (rowfunction) {  
            return $(this).each(function () {  
                var tb = this;  
                if (!(this.tagName.toUpperCase() == "TBODY")) {  
                    if (!this.tBodies[0]) {  
                        return;  
                    } else {  
                        tb = this.tBodies[0];  
                    }  
                }  
                //记录当前行数  
                var rowsCount = tb.rows.length;  
                //添加一个隐藏行，为了避免事件重复绑定，后面新增行复制此行  
                var lastRow = tb.rows[tb.rows.length - 1];  
                if (!$(lastRow).is(":hidden")) {  
                    var row = $(lastRow).clone(true, true);  
                    $(row).insertAfter($(tb).find("tr:last")).hide();  
                }  
                //绑定事件到行、单元格，单击时添加行  
                $(tb).on('click', 'td,tr', function (e) { autoRows(e, rowfunction); });  
                //绑定事件到input元素，当获取焦点或者单击时添加行  
                $(tb).on('focus', 'input', function (e) { autoRows(e, rowfunction); });  
                //单击第一行，初始化  
                tb.rows[rowsCount - 1].click();  
                //对原有行添加事件  
                if (typeof (rowfunction) == 'function') {  
                    for (var i = 0 ; i < rowsCount; i++) {  
                        rowfunction(tb.rows[i]);  
                    }  
                }  
            });  
        }  
    });  
    //自动增加行  
    function autoRows(e, rowfunction) {  
        var e = e || event;  
        var obj = e.target || e.srcElement;  
        while (obj.tagName != "TR") {  
            obj = obj.parentNode;  
        }  
        var tb = obj.parentNode;  
        var index = $(obj).index();  
        var n = 5 - (tb.rows.length - index);  
        if (n > 0) {  
            var lastRow = tb.rows[tb.rows.length - 1];  
            for (var j = 0; j < n; j++) {  
                var row = $(lastRow).clone(true, true);  
                //将新行添加到最后一行之前  
                row.insertBefore($(tb).find("tr:last")).show();  
                //如果有回调函数则执行  
                if (typeof (rowfunction) == 'function') {  
                    rowfunction(row);  
                }  
            }  
        }  
    }  
  
  
    $.fn.tableAutoRow.deleteRow = function (obj) {  
        if (!confirm('确定删除此行？')) {  
            return;  
        }  
        var loop = 0;   //加入循环次数，防止死循环  
        while (obj.tagName != "TR" && loop < 10) {  
            obj = obj.parentNode;  
            loop++;  
        }  
        if (obj.tagName != "TR") {  
            return;  
        }  
        if (obj.parentNode.rows.length == 2) {  
            alert('不能删除全部行');  
            return;  
        } else {  
            $(obj).remove();  
        }  
    }  
  
  
    //在表格中指定位置插入指定行数,新插入的行内容为同一表格主体最后一行  
    //obj:行内的任意对象  
    //n:要增加的行数  
    //isInsertAfter:插入在当前行的后面，否则在前面  
    $.fn.tableAutoRow.insertRow = function (obj, n, isInsertAfter) {  
        var loop = 0;   //加入循环次数，防止死循环  
        while (obj.tagName != "TR" && loop < 10) {  
            obj = obj.parentNode;  
            loop++;  
        }  
        if (obj.tagName != "TR") {  
            return;  
        }  
        var tb = obj.parentNode;  
        switch (arguments.length) {  
            case 2:  
                var isInsertAfter = true;  
            case 1:  
                var isInsertAfter = true;  
                var n = 1;  
        }  
        for (var i = 0; i < n; i++) {  
            var lastRow = tb.rows[tb.rows.length - 1];  
  
  
            var row = $(lastRow).clone(true, true);  
            //将新行添加到当前行之前/后  
            if (isInsertAfter) {  
                row.insertAfter(obj).show();  
            } else {  
                row.insertBefore(obj).show();  
            }  
        }  
    }  
    //清除指定行数据  
    //obj为行或者行内的节点  
    //startColnum:起始列  
    //endColumn:终止列  
    //isReset:是否恢复到初始值  
    $.fn.tableAutoRow.clearRowData = function (obj, startColnum, endColumn, isReset) {  
        var loop = 0;   //加入循环次数，防止死循环  
        while (obj.tagName != "TR" && loop < 10) {  
            obj = obj.parentNode;  
            loop++;  
        }  
        if (obj.tagName != "TR") {  
            return;  
        }  
        var cellsCount = obj.cells.length;                  //此行单元格总数  
        if (startColnum < 0 || !startColnum) {             //如果未指定清除起始列则从第一列清除  
            startColnum = 0;  
        }  
        if (endColumn > cellsCount - 1 || !endColumn) {     //如果未指定清除终止列则清除到最后一列前(通常最后一列用于放置清除按钮)  
            endColumn = cellsCount - 1;  
        }  
        if (isReset == undefined) {  
            isReset = false;  
        }  
        for (var c = startColnum; c <= endColumn; c++)//循环各列,设置单元格里的控件值  
        {  
            for (var j = 0; j < obj.cells[c].childNodes.length; j++) {  //循环处理指定单元格中的子节点  
                var node = obj.cells[c].childNodes[j];  
                setObjData(node, isReset);  
            }  
        }  
    };  
    function setObjData(node, isReset) {  
        switch (node.type) {  
            case "text":  
            case "hidden":  
            case "textarea":  
                if (isReset) {  
                    node.value = node.defaultValue;  
                } else {  
                    node.value = "";  
                }  
                break;  
  
  
            case "select-one":  
            case "select-multiple":  
                if (isReset) {  
                    for (var k = node.options.length - 1; k >= 0; k--) {  
                        node.options[k].selected = node.options[k].defaultSelected;  
                    }  
                } else {  
                    for (var k = node.options.length - 1; k >= 0; k--) {  
                        //node.options.remove(k);  
                        node.options[k].selected = false;  
                    }  
                }  
                break;  
            case "checkbox":  
            case "radio":  
                if (isReset) {  
                    node.checked = node.defaultChecked;  
                } else {  
                    node.checked = false;  
                }  
                break;  
        }  
        if (node.childNodes && node.childNodes.length > 0) {  
            var l = node.childNodes.length;  
            for (var i = 0; i < l; i++) {  
                setObjData(node.childNodes[i], isReset);  
            }  
        }  
    }  
})(jQuery);  
$(function(){  
    $('.autoRows').tableAutoRow();  
});  
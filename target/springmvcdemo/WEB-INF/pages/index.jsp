<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>用户兴趣研究</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/uikit.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/uikit.gradient.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/awesome.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/components/slideshow.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/components/sticky.css" />
    <script src="<%=request.getContextPath()%>/static/js/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/static/js/uikit.min.js"></script>

    <script src="<%=request.getContextPath()%>/static/js/awesome.js"></script>
    <script src="<%=request.getContextPath()%>/static/js/components/lightbox.min.js"></script>
    <script src="<%=request.getContextPath()%>/static/js/components/search.js"></script>
    <script src="<%=request.getContextPath()%>/static/js/components/sticky.js"></script>
    <script src="<%=request.getContextPath()%>/static/js/components/pagination.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/static/font-awesome-470/css/font-awesome.css" />
    <script src="<%=request.getContextPath()%>/static/js/echarts.js"></script>
    <style>
        .uk-width-medium-1-2 span{
            display: inline-block;
            padding: 5px;
            font: 500;
            border: 1px seagreen solid;
            border-radius: 5px;
            margin-top: 5px;
        }
        .uk-width-medium-1-2 span i{
            color: darkred;
            margin-left: 3px;
        }
    </style>

</head>
<body>
<nav class="uk-navbar uk-margin-bottom" data-uk-sticky="{top:1}">
    <div class="uk-container uk-container-center">
        <a href="#" class="uk-navbar-brand">分析</a>
        <ul class="uk-navbar-nav">
            <li ><a href="index?category_name=美妆" class="uk-active"><i class="uk-icon-home"></i>类目偏好</a></li>
            <li><a href="http://wiki.inf.lehe.com/pages/viewpage.action?pageId=16029152"><i class="uk-icon-book">开发文档</i></a></li>
            <li><a href="#"><i class="uk-icon-users"></i>个性化</a></li>
            <li><a href="#"><i class="uk-icon-users"></i>问答&建议</a></li>
        </ul>
    </div>
</nav>

<div class="uk-container uk-container-center" style="border: 1px solid #cccccc;border-radius: 5px;padding-top: 5px;">
    <div class="uk-width-medium-1-1">

        <form class="uk-form" action="index" method="get">
            ${sqlstr}
            <fieldset data-uk-margin>
                <legend>查询控制台: 查询记录数<red>${datasize}</red></legend>
                类目名:
                <select name="category_name">
                    <option value="${paramMap.get("category_name")}">${paramMap.get("category_name")}</option>
                    <option value="美妆">美妆</option>
                    <option value="男装">男装</option>
                    <option value="男鞋">男鞋</option>
                    <option value="女装">女装</option>
                    <option value="女鞋">女鞋</option>
                    <option value="配饰">配饰</option>
                    <option value="食品">食品</option>
                    <option value="运动户外">运动户外</option>
                    <option value="箱包">箱包</option>
                    <option value="家居/家具">家居/家具</option>
                    <option value="数码/家电">数码/家电</option>
                    <option value="保健品">保健品</option>
                    <option value="母婴">母婴</option>
                    <option value="其他">其他</option>
                </select>
                &nbsp;&nbsp;&nbsp;&nbsp;地域:
                <select name="reciver_area">
                    <option value="${paramMap.get("reciver_area")}">${paramMap.get("reciver_area")}</option>
                    <option value="不区分">不区分</option>
                    <option value="华东">华东</option>
                    <option value="华中">华中</option>
                    <option value="华北">华北</option>
                    <option value="华南">华南</option>
                    <option value="东北">东北</option>
                    <option value="西北">西北</option>
                    <option value="西南">西南</option>
                </select>

                &nbsp;&nbsp;&nbsp;&nbsp;价格段:
                <select name="price_div">
                    <option value="${paramMap.get("price_div")}">${paramMap.get("price_div")}</option>
                    <option value="不区分">不区分</option>
                    <option value="[0,500)">[0,500)</option>
                    <option value="[500,1000)">[500,1000)</option>
                    <option value="[1000,2000)">[1000,2000)</option>
                    <option value="[2000,5000)">[2000,5000)</option>
                    <option value="[5000,&)">[5000,&)</option>
                </select>

                &nbsp;&nbsp;&nbsp;&nbsp;季节:
                <select name="season">
                    <option value="${paramMap.get("season")}">${paramMap.get("season")}</option>
                    <option value="不区分">不区分</option>
                    <option value="春季">春季</option>
                    <option value="夏季">夏季</option>
                    <option value="秋季">秋季</option>
                    <option value="秋季">冬季</option>
                </select>
                &nbsp;&nbsp;&nbsp;&nbsp;取TOP:
                <select name="limit">
                <option value="${paramMap.get("limit")}">${paramMap.get("limit")}</option>
                <option value=10>10</option>
                <option value=30>30</option>
                <option value=40>40</option>
                <option value=50>50</option>
                </select>
                <input type="submit" class="uk-button" value="查询"/>
            </fieldset>
        </form>
    </div>
    <!--类目不区分-->
    <div class="uk-grid">
        <div class="uk-width-medium-1-2">
            <div class="uk-panel uk-panel-header" >
                <h3>高频词:</h3>
            </div>
            <c:forEach items="${listdata}" var="list">
                <span>${list.key_words}<i>${list.tis}</i></span>
            </c:forEach>
        </div>
        <div class="uk-width-medium-1-2">
            <div id="main" style="height: 500px;"> </div>
        </div>
    </div>
</div>


<div class="uk-margin-large-top" style="background-color:#ffffff; border-top:1px solid #ededed;">
    <div class="uk-container uk-container-center uk-text-center">
        <div class="uk-panel uk-margin-top uk-margin-bottom">
            <p>
               科技改变时代,数据让生活更美好。
            </p>
        </div>
    </div>
</div>

<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    //获取后提啊数据:
    var context = eval('${categorydata}');
    //名称数组
    var nameArray = new Array();
    //数据数组
    var dataArray= new Array();
    for (var i=0; i<context.length; i++){
        nameArray.push(context[i].key_words);
        dataArray.push(context[i].tis);
    }

    var myChart = echarts.init(document.getElementById('main'));

    // 指定图表的配置项和数据
    var option = {
        tooltip: {},
        toolbox: {
            show : true,
            orient : 'vertical',
            left: 'right',
            top: 'center',
            feature : {
                mark : {show: true},
                dataView : {show: true, readOnly: false},
                restore : {show: true},
                saveAsImage : {show: true}
            }
        },
        legend: {
            data:['词频']
        },
        xAxis: {
            data: nameArray
        },
        yAxis: {},
        series: [{
            name: '词频',
            type: 'bar',
            data: dataArray
        }]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
    //图表宽度自适应
    window.onresize = myChart.resize;
</script>

</body>
</html>
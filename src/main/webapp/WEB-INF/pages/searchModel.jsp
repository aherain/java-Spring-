<!DECRYPT html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title></title>
    <style type="text/css">
        @import url('//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css');
        body{
            background-color: #fff;
            width: 100%;
        }
        div {
            border: 0px solid #898989;
        }
        .pubu1,.pubu2{
            border:2px seagreen;
            border-radius: 5px;
            padding-left: 30px;
        }
    </style>
    <script src="http://cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
</head>
<body >
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-12">
            <div class="input-group" style="margin: 10px;">
                <input type="text" class="form-control" id="keyword" name="keyword" placeholder="Search for..." value="" />
      <span class="input-group-btn">
        <button class="btn btn-default" type="button" onclick="search()"> Search!</button>
      </span>
            </div>
        </div>
        <div class="row info" id="info_tip"></div>
    </div>
    <div class="row">
        <div class="col-xs-6 col-sm-6 col-md-6 pubu1" >
            <div class="info text-center" style="line-height: 36px;background: darkgray;">
                <span>recall method one <span>(reacll1_<b id="recall1"></b>)</span>
            </div>
        </div>
        <div class="col-xs-6 col-sm-6 col-md-6 pubu2" >
            <div class="info text-center" style="line-height: 36px;background: darkgray;">
                 <span>recall method two <span>(reacll2_<b id="recall2"></b>)</span>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script type="text/javascript" >
    var searchword = '';
    var p = 0;
    var interval;
    var ajaxing = false;
    var host1="search.lehe.com/search";
    var host2 = "search.lehe.com/search";
    function search() {
        var keyword = $('#keyword').val();
        if (!keyword && keyword == '') {
            $("#info_tip").innerHTML="<p color='red'>亲,你的搜索词不能为空</p>";
            return;
        }
        $('.pubu1 div.goods').remove();
        $('.pubu2 div.goods').remove();
        searchword = keyword;
        p=0;
        getData();
    }
    function getData() {
        ajaxing = true;
        p++;
        $.ajax({
            type: "get",
            url:"http://"+host1+"/goods/search?page="+p+"&pageSize=10&v=0.2&keyword="+searchword+"&accountId=152196418355464901",
            cache: false,
            async: false,
            dataType: "jsonp",
            jsonp: "callback",
            jsonpCallback:"jsonp",
            success: function(data) {
                //alert(data.code);
                $.each(data.data.list, function(i, value) {
                    $('#recall1').text(data.data.total);
                    //alert(value.goodsName);
                    if (value.objectType == 'Goods') {
                        $('.pubu1').append('<div style="width: 240px;height:450px;margin-left:10px;float:left;border:1px solid #ededed;border-radius: 5px 5px;">' +
                                '<img src="' + value.object.goodsPicUrl + '" style="margin-top:5px;" width="218px" height="340px">' +
                                '<p class="info" style="font-size:8px;font-family: Abadi MT Condensed Light; ">'+(value.object.superGreatFlag==1?'<span style="color:red; font-size: 14px; font-weight: bolder;">super/</span>':'') + value.object.goodsName + '</p>' +
                                '<p class="info"  style="font-size: 8px;">&yen; ' +
                                value.object.salePrice + '&nbsp;&nbsp;&nbsp;  <b>' + value.object.salesVolumeDesc + '</b></p>' +
                                '</div>');
                    }
                });
            },
            error: function(textStatus, errorThrown) {
                alert(textStatus);
                alert(errorThrown);
            }
        });
        interval = setInterval(getData2, 2000);
    }
    function getData2() {
        $.ajax({
            type: "get",
            url:"http://"+host2+"/goods/search?page="+p+"&pageSize=10&v=0.2&keyword="+searchword+"&accountId=157421630547205964",
            cache: false,
            async: false,
            dataType: "jsonp",
            jsonp: "callback",
            jsonpCallback:"jsonp",
            success: function(data) {
                $('#recall2').text(data.data.total);
                //alert(data.code);
                $.each(data.data.list, function(i, value){
                    //alert(value.goodsName);
                    if (value.objectType == 'Goods') {
                        $('.pubu2').append('<div style="width: 240px;height:450px;margin-left:10px;float:left;border:1px solid #ededed;border-radius: 5px 5px;">' +
                                '<img src="' + value.object.goodsPicUrl + '" style="margin-top:5px;" width="218px" height="340px">' +
                                '<p class="info" style="font-size:8px;font-family: Abadi MT Condensed Light; ">'+(value.object.superGreatFlag==1?'<span style="color:red; font-size: 14px; font-weight: bolder;">super/</span>':'') + value.object.goodsName + '</p>' +
                                '<p class="info"  style="font-size: 8px;">&yen; '+value.object.salePrice + '&nbsp;&nbsp;&nbsp;  <b>' + value.object.salesVolumeDesc + '</b></p>' +
                                '</div>');
                    }
                });
            },
            error: function(textStatus, errorThrown) {
                alert(textStatus);
                alert(errorThrown);
            }
        });
        clearInterval(interval);
        ajaxing = false;
    }

    $(document).ready(function () {
        $(document).scroll(function () {
            //$(window).scrollTop()这个方法是当前滚动条滚动的距离
            //$(window).height()获取当前窗体的高度
            //$(document).height()获取当前文档的高度
            var bot = 10; //bot是底部距离的高度
            if ($(window).scrollTop() == ($(document).height() - $(window).height())) {
                //当底部基本距离+滚动的高度〉=文档的高度-窗体的高度时；
                //我们需要去异步加载数据了
                if(!ajaxing)
                    getData();
                //getData2("wormhole.inf.lehe.com/api/search1");
                //getData3("wormhole.inf.lehe.com/api/search2");
            }
        });

        $('#keyword').bind('keypress',function(event){
            if(event.keyCode == "13")
            {
                search();
            }
        });
    });
</script>

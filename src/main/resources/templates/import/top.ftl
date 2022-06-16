<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">


<#--    这里引入的是网络链接的         -->
    <!-- ZUI 标准版压缩后的 CSS 文件 -->
    <link rel="stylesheet" href="//cdn.bootcdn.net/ajax/libs/zui/1.10.0/css/zui.min.css">
    <!-- ZUI Javascript 依赖 jQuery -->
    <script src="//cdn.bootcdn.net/ajax/libs/zui/1.10.0/lib/jquery/jquery.js"></script>
    <!-- ZUI 标准版压缩后的 JavaScript 文件 -->
    <script src="//cdn.bootcdn.net/ajax/libs/zui/1.10.0/js/zui.min.js"></script>

<#--    引入自己的js文件       -->
    <script src="/res/js/common.js"></script>

    <link rel="shortcut icon" href="/res/img/favicon.ico" type="image/x-icon">
    <link rel="icon" href="/res/img/favicon.ico" type="image/x-icon">


<#--    这里引入的是下载到本地的 css 和 js 文件-->
<#--    <link rel="stylesheet" href="/res/zui/1.10.0/css/zui.min.css">-->
<#--    <script src="/res/zui/1.10.0/lib/jquery.js"></script>-->
<#--    <script src="/res/zui/1.10.0/js/zui.min.js"></script>-->


    <title>Title</title>
</head>
<body>

<div class="container">
    <nav class="navbar navbar-default" role="navigation">
        <div class="container-fluid">
            <!-- 导航头部 -->
            <div class="navbar-header">
                <!-- 移动设备上的导航切换按钮 -->
                <button type="button" class="navbar-toggle" data-toggle="collapse"
                        data-target=".navbar-collapse-example">
                    <span class="sr-only">切换导航</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <!-- 品牌名称或logo -->
                <a class="navbar-brand" href="/">首页</a>
            </div>
            <!-- 导航项目 -->
            <div class="collapse navbar-collapse navbar-collapse-example">
                <!-- 一般导航项目 -->
                <ul class="nav navbar-nav">
                    <li class="active"><a href="/"><i class="icon icon-list-ol"></i> 基础数据</a></li>
                    <!-- 导航中的下拉菜单 -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown"><i class="icon icon-group"></i> 用户管理 <b class="caret"></b></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="/user/list">用户列表</a></li>
                        </ul>
                    </li>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon icon-th-list"></i> 文章管理 <b class="caret"></b></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="/article/type/list">文章类型</a></li>
                            <li><a href="/article/tag/list">文章标签</a></li>
                            <li><a href="/article/list">文章列表</a></li>
                        </ul>
                    </li>
                    <li class="active"><a href="/link/list"><i class="icon icon-smile"></i> 友情链接</a></li>
                    <li class="active"><a href="/ad/list"><i class="icon icon-dollar"></i> 广告管理</a></li>
                </ul>



                <!-- 右侧的导航项目 -->
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="/"><i class="icon icon-signout"></i> 退出登录</a></li>
                </ul>

            </div><!-- END .navbar-collapse -->
        </div>
    </nav>



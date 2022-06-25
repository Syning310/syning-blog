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
                    <li class="active"><a href="/article/list"><i class="icon icon-th-list"></i> 文章列表</a></li>
                    <li class="active"><a href="/article/publish"><i class="icon icon-list-ol"></i> 发布文章</a></li>

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="icon icon-umbrella"></i></i>
                            文章管理 <b class="caret"></b></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="/article/type/list">文章类型</a></li>
                            <li><a href="/article/tag/list">文章标签</a></li>
                        </ul>
                    </li>
                    <!-- 导航中的下拉菜单 -->
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown"><i class="icon icon-group"></i> 用户管理 <b
                                    class="caret"></b></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="/user/list">用户列表</a></li>
                        </ul>
                    </li>

                    <li class="active"><a href="/link/list"><i class="icon icon-smile"></i> 收藏链接</a></li>

                    <li class="active"><a href="/ad/list"><i class="icon icon-dollar"></i> 广告管理 </a></li>

                </ul>


                <!-- 右侧的导航项目 -->
                <ul class="nav navbar-nav navbar-right">
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown"><i class="icon icon-cube-alt"></i> 系统 <b
                                    class="caret"></b></a>
                        <ul class="dropdown-menu" role="menu">
                            <li><a href="/admin/login"><i class="icon icon-location-arrow"></i> 登录用户</a></li>
                            <li><a onclick="openRestPwd()"><i class="icon icon-history"></i> 修改密码</a></li>
                            <li><a href="/logout"><i class="icon icon-signout"></i> 退出登录</a></li>
                        </ul>

                    </li>

                </ul>

            </div><!-- END .navbar-collapse -->
        </div>
    </nav>


    <#--    添加模态框       -->
    <div id="resetPwd" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="#" method="post">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span
                                    aria-hidden="true">×</span><span
                                    class="sr-only">关闭</span></button>
                        <h4 class="modal-title">修改密码</h4>
                    </div>
                    <div class="modal-body">

                        <div class="form-group">
                            <label for="exampleInputPassword1">用户名:</label>
                            <input type="text" class="form-control" id="resetName" placeholder="用户名">
                        </div>

                        <div class="form-group">
                            <label for="exampleInputAccount1">密码:</label>
                            <input type="text" class="form-control" id="resetPassword" placeholder="密码">
                        </div>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" onclick="restAdmin()">保存</button>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <script type="text/javascript">
        // 打开修改密码模态框
        function openRestPwd() {
            $('#resetPwd').modal('toggle', 'center');

        }

        function restAdmin() {
            // 收集账号密码数据，发送给后端
            let adminName = $('#resetName').val();
            let adminPassword = $('#resetPassword').val();

            if (!checkNotNull(adminName) || !checkNotNull(adminPassword)) {
                zuiMsg('请完善参数!');
                return;
            }

            $.post('/admin/resetPassword', {
                userName: adminName,
                userPassword: adminPassword
            }, function (data) {
                resolveRep(data);

            });

        }


    </script>

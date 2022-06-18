<#include "${springMacroRequestContext.contextPath}/import/top.ftl">


<div class="container">
    <div class="panel panel-primary">
        <div class="panel-heading">管理员登录</div>
        <div class="panel-body" style="height: 380px;">
            <form class="form-horizontal" action="/admin/login" method="post">
                <div class="form-group">
                    <label for="adminName" class="col-sm-2">用户名：</label>
                    <div class="col-sm-10">
                        <input type="text" class="form-control" id="adminName" maxlength="50" name="adminName"
                               placeholder="用户名" value="syning">
                    </div>
                </div>
                <div class="form-group">
                    <label for="adminPassword" class="col-sm-2">密码：</label>
                    <div class="col-sm-10">
                        <input type="password" class="form-control" id="adminPassword" maxlength="50" name="adminPassword"
                               placeholder="密码" value="syning">
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-2">
                    </div>
                    <div class="col-sm-2">
                        <button type="button" onclick="submitForm()" class="btn btn-default">
                            <i class="icon-signin"></i> 登录
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>



<script type="text/javascript">

    function submitForm() {
        let adminName = $("#adminName").val();
        let adminPassword = $("#adminPassword").val();

        if (!checkNotNull(adminName) || !checkNotNull(adminPassword)) {
            zuiMsg("请输入登录信息");
            return;
        }



        // const xhr = new XMLHttpRequest();
        //
        // xhr.open('POST', 'http://localhost/admin/verify');
        //
        // xhr.send('adminName=' + adminName + "&adminPassword=" + adminPassword);
        //
        // xhr.onreadystatechange = function() {
        //     if (xhr.readyState === 4) {
        //         if (xhr.status >= 200 && xhr.status < 300) {
        //             // 处理服务返回的结果
        //             window.location.href = '/';
        //         } else {
        //             zuiMsg(xhr.response);
        //             return;
        //         }
        //     } else {
        //         zuiMsg(xhr.response);
        //         return;
        //     }
        // }



        $.post('/admin/verify', {
                adminName: adminName,
                adminPassword: adminPassword
            },
            function (data) {
                if (data.code === 200) {
                    window.location.href = "/";
                    return;
                } else {
                    zuiMsg(data.message);
                }


        });
    }


</script>


<#include "${springMacroRequestContext.contextPath}/import/bottom.ftl">

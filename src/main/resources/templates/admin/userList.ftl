<#include "${springMacroRequestContext.contextPath}/import/top.ftl">


<div class="panel">
    <div class="panel-body">


        <form class="form-horizontal" action="/user/list" method="post">
            <div class="form-group">
                <label for="userName" class="col-sm-1">用户名:</label>
                <div class="col-sm-2">
                    <input type="text" class="form-control" id="exampleInputAccount4" name="userName"
                           placeholder="用户名">
                </div>

                <div class="col-sm-1">
                    <button type="submit" class="btn btn-success">条件查询</button>
                </div>

                <div class="col-sm-1">
                    <a href="/user/list" class="btn btn-success">查询All&nbsp;</a>
                </div>

                <div class="col-sm-1">
                    <button type="button" class="btn btn-success" style="margin-left: 550px;"
                    onclick="openAddModal()">添加用户</button>
                </div>

            </div>
        </form>

    </div>
</div>


<#if userPage?? && userPage.list?size gt 0>

    <div class="panel">
        <div class="panel-body">

            <table class="table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>用户名</th>
                    <th>注册时间</th>
                    <th>@</th>
                    <th>操作</th>
                </tr>

                </thead>

                <#list userPage.list as user>

                    <tbody>
                    <tr>
                        <td>${user?index + 1}</td>
                        <td>${(user.userName)!}</td>
                        <td>${(user.userRegisterTime)!}</td>
                        <td>😊</td>
                        <td>
                            <button onclick="openUpdateModal('${user.userId}', '${user.userName}', 0)" type="button"
                                    class="btn btn-mini"><i class="icon icon-cog"></i>修改
                            </button>
                            <button onclick="delUser('${(user.userId)!}')"
                                    type="button" class="btn btn-mini"><i class="icon icon-remove"></i>删除
                            </button>
                        </td>
                    </tr>

                    </tbody>

                </#list>

            </table>

        </div>

    </div>


    <div class="panel">
        <div class="panel-body" style="padding: 0;">
            <div class="col-sm-12" style="padding: 0;text-align: center;">
                <ul class="pager" style="margin-top: 10px;margin-bottom: 10px;">
                    <#--                    跳转到第一页          -->
                    <li class="previous" onclick="getNewData(1)">
                        <a href="javascript:void(0)"><i class="icon-step-backward"></i></a>
                    </li>

                    <#--                    当前页小于等于 1 时，则按钮失效    -->
                    <#if userPage.pageNumber lte 1>
                        <li class="previous disabled">
                            <a href="javascript:void(0)"><i class="icon-chevron-left"></i></a>
                        </li>
                    <#else>
                    <#--                            传入当前页面 -1 的页数         -->
                        <li class="previous" onclick="getNewData('${userPage.pageNumber-1}')">
                            <a href="javascript:void(0)"><i class="icon-chevron-left"></i></a>
                        </li>


                    <#--                        中间显示共多少页-->
                    </#if>
                    <li>
                        <a href="javascript:void(0)" class="btn">
                            ${userPage.pageNumber}页/共${userPage.totalPage}</a>
                    </li>

                    <#--                    如果当前页码大于等于总页码 按钮失效       -->
                    <#if userPage.pageNumber gte userPage.totalPage>
                        <li class="next disabled">
                            <a href="javascript:void(0)"><i class="icon-chevron-right"></i></a>
                        </li>

                    <#--                        下一页传入当前页码 +1    -->
                    <#else>
                        <li class="next" onclick="getNewData('${userPage.pageNumber+1}')">
                            <a href="javascript:void(0)"><i class="icon-chevron-right"></i></a>
                        </li>


                    <#--                        传入最后一页的页码           -->
                    </#if>
                    <li class="previous" onclick="getNewData('${userPage.totalPage}')">
                        <a href="javascript:void(0)"><i class="icon-step-forward"></i></a>
                    </li>

                    <#--                        输入框             -->
                    <li class="next">
                        <a href="javascript:void(0)">
                            <input type="number" id="renderPageNumber" maxlength="5"
                                   style="width:50px;height: 20px;" oninput="value=value.replace(/[^\d]/g,'')">
                        </a>
                    </li>
                    <#--                    跳转按钮            -->
                    <li class="next">
                        <a href="javascript:void(0)" onclick="renderPage()"
                           style="padding-left: 2px;padding-right: 2px;">
                            跳转
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>


<#--    暂无数据的情况     -->
<#else>

    <div class="panel">
        <div class="panel-body" style="padding: 0;">
            <div style="text-align: center;">
                <h3><i class="icon icon-coffee"></i></h3>
                <h3>暂无数据</h3>
            </div>


        </div>
    </div>
</#if>


<div id="userUpdateModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="/user/update" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span
                                class="sr-only">关闭</span></button>
                    <h4 class="modal-title">修改用户</h4>
                </div>
                <div class="modal-body">

                    <#--                    这个隐藏于是在函数中，填入userId给这个隐藏于的value，让他带到后端          -->
                    <input hidden name="userId" id="userId">

                    <div class="form-group">
                        <label for="exampleInputAccount1">用户名:</label>
                        <input type="text" class="form-control" id="userNameUpdate"
                               disabled="disabled">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">密码:</label>
                        <input type="password" class="form-control" id="userPassword" placeholder=""
                               name="userPassword">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputMoney1">是否冻结</label>
                        <div class="input-group">
                            <label>
                                <input type="radio" name="userFrozen" value="0"> 正常
                            </label>
                            <label>
                                <input type="radio" name="userFrozen" value="1"> 冻结
                            </label>
                        </div>
                    </div>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="userUpdate()">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>


<div id="addUserModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="/user/update" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span
                                class="sr-only">关闭</span></button>
                    <h4 class="modal-title">修改用户</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label for="exampleInputAccount1">用户名:</label>
                        <input type="text" class="form-control" id="addUserName">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputPassword1">密码:</label>
                        <input type="password" class="form-control" id="addUserPassword" placeholder=""
                               name="userPassword">
                    </div>


                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="sendUserAdd()">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>



<script type="text/javascript">


    function sendUserAdd() {

        // 获取填入的账号密码，传给后端
        let userName = $('#addUserName').val();
        let userPassword = $('#addUserPassword').val();

        if (!checkNotNull(userName) || !checkNotNull(userPassword)) {
            zuiMsg('请完善信息!');
            return;
        }

        $.post('/user/add', {
            userName: userName,
            userPassword: userPassword
        }, rep => {
            resolveRep(rep);
        });

    }



    function openAddModal() {
        // 打开模态框
        $('#addUserModal').modal('toggle', 'center');
    }


    // 修改模态框点击保存修改，发送数据到后端修改数据
    function userUpdate() {
        // 将表单的数据读出来
        let userId = $('#userId').val();
        let userName = $('#userNameUpdate').val();          // userName 不能修改，所以不传到后端
        let userPassword = $('#userPassword').val();
        let userFrozen = $('input[name="userFrozen"]:checked').val();   // 冻结功能还未做

        // console.log(userFrozen);

        if (!checkNotNull(userId)) {
            zuiMsg('提示消息：出错了！请刷新页面重试');
            return;
        }

        if (!checkNotNull(userPassword)) {
            zuiMsg('提示消息：请输入修改的密码');
            return;
        }


        $.post("/user/update", {
                userId: userId,
                userPassword: userPassword
            },
            function (data) {
                if (data.code == 200) {
                    alert(data.message);
                    location.reload();
                    return;
                }
                zuiMsg(data.message);
            }
        );


    }


    // 修改按钮，打开模态框，并回显数据
    function openUpdateModal(userId, userName, userFrozen) {
        // 打开模态框
        $('#userUpdateModal').modal('toggle', 'center');

        $('#userId').val(userId);   // 填入userId带给后端

        $('#userNameUpdate').val(userName);   // 回显userName

        $(':radio[name="userFrozen"][value=' + userFrozen + ']').prop('checked', 'checked');

    }


    // 删除按钮
    function delUser(userId) {
        if (!confirm('是否删除')) {
            return;
        }

        if (!checkNotNull(userId)) {
            new $.zui.Messager('提示消息：出错了！请刷新页面重试', {
                type: 'warning',     // 定义颜色主题
                placement: 'center'
            }).show();
            return;
        }

        $.post('/user/del', {
                userId: userId

            },
            function (data) {
                if (data.code === 200) {
                    alert(data.message);
                    location.reload();
                    return;
                } else {
                    new $.zui.Messager(data.message, {
                        type: 'warning',
                        placement: 'center'
                    }).show();
                }
            }
        );

    }


    // 获取新数据
    function getNewData(pageNumber) {
        if (!checkNotNull(pageNumber)) {
            pageNumber = 1;
        }
        window.location.href = "/user/list?pageNumber=" + pageNumber + "<#if (userName?? && userName?length>0)>&userName=${userName!}</#if>";
    }

    // 渲染页面
    function renderPage() {
        let renderPageNumber = $("#renderPageNumber").val();
        if (!checkNotNull(renderPageNumber)) {
            new $.zui.Messager('请输入跳转的页码!', {
                type: 'warning',
                placement: 'center'
            }).show();
            return;
        }
        let totalPage = '${userPage.totalPage}';
        if (parseInt(renderPageNumber) > parseInt(totalPage)) {
            renderPageNumber = totalPage;
        }
        getNewData(renderPageNumber);
    }


</script>


<#include "${springMacroRequestContext.contextPath}/import/bottom.ftl">

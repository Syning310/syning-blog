<#include "../import/top.ftl">


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
                            <button type="button" class="btn btn-mini"><i class="icon icon-cog"></i>修改</button>
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


    <div class="panel">
    <div class="panel-body" style="padding: 0;">

        <#--    暂无数据的情况     -->
        <#else>
            <div style="text-align: center;">
                <h3><i class="icon icon-coffee"></i></h3>
                <h3>暂无数据</h3>
            </div>

    </div></div>

</#if>


<script type="text/javascript">

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
            zuiMsg("请输入跳转的页码！");
            return;
        }
        let totalPage = '${userPage.totalPage}';
        if (parseInt(renderPageNumber) > parseInt(totalPage)) {
            renderPageNumber = totalPage;
        }
        getNewData(renderPageNumber);
    }


    function checkNotNull(str) {
        if (str == null || str == "" || str.length < 1 || str == undefined) {
            return false;
        }
        return true;
    }

</script>


<#include "../import/bottom.ftl">

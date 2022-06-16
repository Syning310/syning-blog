<#include "${springMacroRequestContext.contextPath}/import/top.ftl">


<div class="panel">
    <div class="panel-body">

        <button type="button" class="btn btn-mini"
                onclick="openLinkAddModal()"><i class="icon icon-plus"></i> 添加链接
        </button>
        <hr/>

        <h4>友链数量 ${linkList?size} 条</h4>

        <#if linkList?? && linkList?size gt 0>

            <table class="table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Logo</th>
                    <th>链接标题</th>
                    <th>链接</th>
                    <th>添加时间</th>
                    <th>操作</th>
                </tr>

                </thead>

                <#list linkList as link>

                    <tbody>
                    <tr>
                        <td>${link?index + 1}</td>

                        <td>
                            <#if link.linkLogoUrl?? && link.linkLogoUrl?length gt 0>
                                <img src="${link.linkLogoUrl}" class="img-thumbnail" width="30px" height="20px">

                            <#else>
                                <img src="/res/img/null_logo.png" class="img-thumbnail" width="30px" height="20px">
                            </#if>

                        </td>

                        <td>
                            ${(link.linkTitle)!}
                        </td>

                        <td>
                            ${(link.linkUrl)!}
                        </td>

                        <td>${(link.linkAddTime)!}</td>

                        <td>
                            <a href="${(link.linkUrl)!}" target="_blank" class="btn btn-mini"><i
                                        class="icon icon-eye-open"></i> 跳转</a>

                            <#--                                            修改链接，传 id 、 title 、 url 给后端修改-->
                            <button onclick="openLinkUpdateModal('${(link.linkId)!}',
                                    '${(link.linkTitle)!}',
                                    '${(link.linkUrl)!}',
                                    '${(link.linkLogoUrl)!}')"
                                    type="button" class="btn btn-mini"><i class="icon icon-cog"></i>修改
                            </button>

                            <button onclick="linkDel(${link.linkId})"
                                    type="button" class="btn btn-mini"><i class="icon icon-remove"></i>删除
                            </button>
                        </td>
                    </tr>

                    </tbody>

                </#list>

            </table>


        <#else>
            <div class="panel">
                <div class="panel-body" style="padding: 0;">
                    <#--    暂无数据的情况     -->
                    <div style="text-align: center;">
                        <h3><i class="icon icon-coffee"></i></h3>
                        <h3>暂无数据</h3>
                    </div>

                </div>
            </div>
        </#if>

    </div>

</div>


<#--    修改模态框-->
<div id="linkUpdateModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="/link/addLinkOrUpdate" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span
                                aria-hidden="true">×</span><span
                                class="sr-only">关闭</span></button>
                    <h4 class="modal-title">修改友情链接</h4>
                </div>
                <div class="modal-body">

                    <#--                    这个隐藏于是在函数中，填入userId给这个隐藏于的value，让他带到后端          -->
                    <input hidden name="linkId" id="linkIdUpdate">


                    <div class="form-group">
                        <label for="exampleInputPassword1">链接logo:</label>
                        <input type="text" class="form-control" id="linkLogoUrlUpdate" placeholder="logo地址"
                               name="linkLogoUrl">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputPassword1">链接地址:</label>
                        <input type="text" class="form-control" id="linkUrlUpdate" placeholder="链接地址"
                               name="linkUrl">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputAccount1">链接名称:</label>
                        <input type="text" class="form-control" id="linkTitleUpdate"
                               name="linkTitle" placeholder="链接名称">
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="linkUpdate()">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>


<#--    添加模态框       -->
<div id="linkAddModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="/link/addLinkOrUpdate" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span
                                aria-hidden="true">×</span><span
                                class="sr-only">关闭</span></button>
                    <h4 class="modal-title">修改友情链接</h4>
                </div>
                <div class="modal-body">

                    <div class="form-group">
                        <label for="exampleInputPassword1">链接logo:</label>
                        <input type="text" class="form-control" id="linkLogoUrlAdd" placeholder="logo地址"
                               name="linkLogoUrl">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputPassword1">链接地址:</label>
                        <input type="text" class="form-control" id="linkUrlAdd" placeholder="链接地址"
                               name="linkUrl">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputAccount1">链接名称:</label>
                        <input type="text" class="form-control" id="linkTitleAdd"
                               name="linkTitle" placeholder="链接名称">
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="linkSave()">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">

    // 根据 id 删除
    function linkDel(linkId) {

        if (!checkNotNull(linkId)) {
            zuiMsg('提示消息：出错了 请刷新页面重试');
        }

        $.post('/link/del', {
            linkId: linkId
        }, function(data) {
            if (data.code == 200) {

                new $.zui.Messager(data.message, {
                    type: 'success',
                    placement: 'center'
                }).show();

                // 设置定期是弹出删除成功页面，1秒后刷新页面
                setInterval(function() {
                    location.reload();
                }, 300);
                return;
            } else {
                zuiMsg(data.message);
            }
        });

    }


    // 收集数据，发送给后端
    function linkSave() {
        let linkLogoUrl = $('#linkLogoUrlAdd').val();
        let linkUrl = $('#linkUrlAdd').val();
        let linkTitle = $('#linkTitleAdd').val();

        if (!checkNotNull(linkUrl) || !checkNotNull(linkTitle)) {
            zuiMsg('请完善数据!');
        }

        $.post('/link/addLinkOrUpdate', {
            linkLogoUrl: linkLogoUrl,
            linkUrl: linkUrl,
            linkTitle: linkTitle
        }, function (data) {
            if (data.code == 200) {

                new $.zui.Messager(data.message, {
                    type: 'success',
                    placement: 'center'
                }).show();

                // 设置定时器弹出修改成功页面，1秒后再刷新页面
                setInterval(function () {
                    location.reload();
                }, 300);
                return;
            } else {
                zuiMsg(data.message);
            }

        });

    }

    // 打开添加模态框
    function openLinkAddModal() {
        $('#linkAddModal').modal('toggle', 'center');
    }


    // 收集数据，发送给后端
    function linkUpdate() {
        let linkId = $('#linkIdUpdate').val();
        let linkLogoUrl = $('#linkLogoUrlUpdate').val();
        let linkUrl = $('#linkUrlUpdate').val();
        let linkTitle = $('#linkTitleUpdate').val();

        if (!checkNotNull(linkId)) {
            zuiMsg('提示消息：出错了 请刷新页面重试');
            return;
        }

        if (!checkNotNull(linkUrl)) {
            zuiMsg('提示消息：请输入正确的URL地址');
            return;
        }

        if (!checkNotNull(linkTitle)) {
            zuiMsg('提示消息：请输入链接名称')
            return;
        }

        // 发送后端
        $.post('/link/addLinkOrUpdate', {
            linkId: linkId,
            linkLogoUrl: linkLogoUrl,
            linkUrl: linkUrl,
            linkTitle: linkTitle
        }, function (data) {
            if (data.code == 200) {
                new $.zui.Messager(data.message, {
                    type: 'success',
                    placement: 'center'
                }).show();

                // 设置定时器弹出修改成功页面，1秒后再刷新页面
                setInterval(function () {
                    location.reload();
                }, 300);
                return;
            } else {
                zuiMsg(data.message);
            }
        });

    }

    // 打开修改模态框，回显数据
    function openLinkUpdateModal(linkId, linkTitle, linkUrl, linkLogoUrl) {
        $('#linkUpdateModal').modal('toggle', 'center');

        $('#linkIdUpdate').val(linkId);
        $('#linkLogoUrlUpdate').val(linkLogoUrl);
        $('#linkUrlUpdate').val(linkUrl);
        $('#linkTitleUpdate').val(linkTitle);

    }


</script>


<#include "${springMacroRequestContext.contextPath}/import/bottom.ftl">

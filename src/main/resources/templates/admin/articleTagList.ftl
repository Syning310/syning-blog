<#include "${springMacroRequestContext.contextPath}/import/top.ftl">


<div class="panel">
    <div class="panel-body">

        <button type="button" class="btn btn-mini"
                onclick="openArticleTagAddModal()">添加标签
        </button>
        <hr/>
        <#if articleTagList?? && articleTagList?size gt 0>

            <#list articleTagList as articleTag>

                <div class="col-sm-2" style="padding: 2px;">

                    <div class="img-thumbnail" style="width: 100%; height: 100%;">
                        ${(articleTag.articleTagName)!}

                        <div class="pull-right">
                            <i class="icon icon-cog" data-toggle="tooltip" data-placement="top" title="修改"
                               onclick="openArticleTagUpdateModal('${(articleTag.articleTagName)!}', ${articleTag.articleTagId})"></i>

                            <i class="icon icon-remove" data-toggle="tooltip" data-placement="top" title="删除"
                               onclick="articleTagDel(${(articleTag.articleTagId)!})"></i>
                        </div>

                    </div>

                </div>

            </#list>


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

<#--    修改模态框       -->
<div id="articleTagUpdateModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span
                            class="sr-only">关闭</span></button>
                <h4 class="modal-title">修改标签</h4>
            </div>
            <div class="modal-body">

                <input type="hidden" id="articleTagIdUpdate" name="articleTagIdUpdate">
                <div class="form-group">
                    <label for="exampleInputPassword1">标签名:</label>
                    <input type="text" class="form-control" id="articleTagNameUpdate" placeholder="标签名"
                           name="articleTypeSort">
                </div>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="articleTagUpdate()">修改</button>
            </div>
        </div>
    </div>
</div>


<#--    添加模态框       -->
<div id="articleTagAddModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span
                            class="sr-only">关闭</span></button>
                <h4 class="modal-title">添加标签</h4>
            </div>
            <div class="modal-body">

                <div class="form-group">
                    <label for="exampleInputPassword1">标签名:</label>
                    <input type="text" class="form-control" id="articleTagNameAdd" placeholder="标签名"
                           name="articleTypeSort">
                </div>


            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="articleTagAdd()">添加</button>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">

    // 根据id删除标签
    function articleTagDel(articleTagId) {

        if (!confirm('是否删除标签')) {
            return;
        }

        if (!checkNotNull(articleTagId)) {
            zuiMsg('提示消息：出错了 请重新刷新页面!');
            return;
        }

        $.post('/article/tag/del', {
            articleTagId: articleTagId
        }, function (data) {
            if (data.code == 200) {
                new $.zui.Messager(data.message, {
                    type: 'success',
                    placement: 'center'
                }).show();

                // 设置定时器，弹出删除成功的标签后，1秒后再刷新页面
                setInterval(function() {
                    location.reload();  // 刷新当前页面
                }, 300);
                return;
            } else {
                zuiMsg(data.message);
            }

        });

    }


    // 点击添加模态框的添加按钮，发送给后端
    function articleTagAdd() {
        // 收集数据
        let articleTagName = $('#articleTagNameAdd').val();

        if (!checkNotNull(articleTagName)) {
            zuiMsg('提示消息：添加类型标签名不能为空!');
            return;
        }

        $.post('/article/tag/add',
            {
                articleTagName: articleTagName
            },
            function (data) {
                if (data.code == 200) {
                    new $.zui.Messager(data.message, {
                        type: 'success',     // 定义颜色主题
                        placement: 'center'
                    }).show();

                    // 关闭模态框
                    $('#addArticleTypeModal').modal('hide');

                    // 设置定时器，弹出修改成功的标签后，1秒再刷新页面
                    setInterval(function () {
                        location.reload();  // 刷新当前页面
                    }, 600)

                    return;
                }
                zuiMsg(data.message);
            }
        );

    }


    // 打开添加模态框
    function openArticleTagAddModal() {
        // 打开添加模态框
        $('#articleTagAddModal').modal('toggle', 'center');
    }


    // 点击修改模态框的修改按钮，发送数据给后端
    function articleTagUpdate() {

        let articleTagName = $('#articleTagNameUpdate').val();
        let articleTagId = $('#articleTagIdUpdate').val();

        if (!checkNotNull(articleTagName)) {
            zuiMsg('提示消息：请输入修改的名称!');
            return;
        }

        if (!checkNotNull(articleTagId)) {
            zuiMsg('提示消息：出错了! 请刷新页面重试');
            return;
        }

        $.post('/article/tag/update', {
                articleTagName: articleTagName,
                articleTagId: articleTagId
            },
            function (data) {
                if (data.code == 200) {
                    // 关闭模态框
                    $('#articleTypeUpdateModal').modal('hide');

                    new $.zui.Messager(data.message, {
                        type: 'success',     // 定义颜色主题
                        placement: 'center'
                    }).show();

                    // 设置定时器，弹出修改成功的标签后，1秒再刷新页面
                    setInterval(function () {
                        location.reload();  // 刷新当前页面
                    }, 600)
                } else {
                    zuiMsg(data.message);
                }

            }
        );

    }

    // 打开修改模态框，并回显数据
    function openArticleTagUpdateModal(articleTagName, articleTagId) {
        console.log("art = " + articleTagName)
        // 打开修改模态框
        $('#articleTagUpdateModal').modal('toggle', 'center');

        // 回显
        $('#articleTagNameUpdate').val(articleTagName);

        // id回显到隐藏于中，传给后端
        $('#articleTagIdUpdate').val(articleTagId);
    }


</script>


<#include "${springMacroRequestContext.contextPath}/import/bottom.ftl">

<#include "../import/top.ftl">


<div class="panel">
    <div class="panel-body">

        <button type="button" class="btn btn-success" onclick="addArticleType()"
                style="margin-bottom: 20px">添加文章类型
        </button>

        <#if articleTypeList?? && articleTypeList?size gt 0>
            <table class="table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>文章类型</th>
                    <th>添加时间</th>
                    <th>文章数量</th>
                    <th>操作</th>
                </tr>

                </thead>

                <#list articleTypeList as articleType>

                    <tbody>
                    <tr>
                        <td>${articleType?index + 1}</td>
                        <td>${(articleType.articleTypeName)!}</td>

                        <td>${(articleType.articleTypeAddTime)!}</td>

                        <td>${(articleType.articleCount)!}</td>

                        <td>
                            <button onclick="openUpdateModal('${articleType.articleTypeId}',
                                    '${articleType.articleTypeName}',
                            ${articleType.articleTypeSort})"
                                    type="button"
                                    class="btn btn-mini"><i class="icon icon-cog"></i>修改
                            </button>

                            <button onclick="delArticleType('${(articleType.articleTypeId)!}')"
                                    type="button" class="btn btn-mini"><i class="icon icon-remove"></i>删除
                            </button>
                        </td>
                    </tr>

                    </tbody>

                </#list>

            </table>



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


    </div>

</div>


<#--    修改模态框-->
<div id="articleTypeUpdateModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <form action="/article/type/update" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span
                                aria-hidden="true">×</span><span
                                class="sr-only">关闭</span></button>
                    <h4 class="modal-title">修改文章类型</h4>
                </div>
                <div class="modal-body">

                    <#--                    这个隐藏于是在函数中，填入userId给这个隐藏于的value，让他带到后端          -->
                    <input hidden name="articleTypeId" id="articleTypeId">


                    <div class="form-group">
                        <label for="exampleInputPassword1">类型排序:</label>
                        <input type="number" class="form-control" id="articleTypeSort" placeholder="类型排序"
                               name="articleTypeSort">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputAccount1">类型名称:</label>
                        <input type="text" class="form-control" id="articleTypeName"
                               name="articleTypeName" placeholder="类型名称">
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="articleTypeUpdate()">保存</button>
                </div>
            </form>
        </div>
    </div>
</div>


<#--    添加模态框           -->
<div id="addArticleTypeModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <#--            这里的action不是发送的没有作用，提交是通过下面的保存按钮，发送ajax请求给后端-->
            <form action="#" method="post">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span
                                aria-hidden="true">×</span><span
                                class="sr-only">关闭</span></button>
                    <h4 class="modal-title">添加文章类型</h4>
                </div>
                <div class="modal-body">

                    <#--                    这个隐藏于是在函数中，填入userId给这个隐藏于的value，让他带到后端          -->

                    <div class="form-group">
                        <label for="exampleInputPassword1">类型排序:</label>
                        <input type="number" class="form-control" id="articleTypeSortAdd" placeholder="类型排序"
                               name="articleTypeSort" value="0">
                    </div>

                    <div class="form-group">
                        <label for="exampleInputAccount1">类型名称:</label>
                        <input type="text" class="form-control" id="articleTypeNameAdd"
                               name="articleTypeName" placeholder="类型名称">
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="articleTypeAdd()">添加</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">

    // 添加模态框点击保存，发送数据给后端添加数据
    function articleTypeAdd() {
        let articleTypeNameAdd = $('#articleTypeNameAdd').val();  // 取出类型名称
        let articleTypeSortAdd = $('#articleTypeSortAdd').val();  // 取出类型排序

        // console.log('名称: ' + articleTypeNameAdd);
        // console.log('排序: ' + articleTypeSortAdd);

        if (!checkNotNull(articleTypeNameAdd)) {
            zuiMsg('提示消息：添加类型名称不能为空!');
            return;
        }

        $.post("/article/type/add", {
                articleTypeName: articleTypeNameAdd,
                articleTypeSort: articleTypeSortAdd
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


    // 修改模态框点击保存修改，发送数据到后端修改数据
    function articleTypeUpdate() {
        // 将表单的数据读出来
        let articleTypeId = $('#articleTypeId').val();
        let articleTypeName = $('#articleTypeName').val();  // 取出类型名称
        let articleTypeSort = $('#articleTypeSort').val();  // 取出类型排序

        // console.log(userFrozen);

        if (!checkNotNull(articleTypeId)) {
            zuiMsg('提示消息：出错了！请刷新页面重试');
            return;
        }

        if (!checkNotNull(articleTypeName)) {
            zuiMsg('提示消息：请输入修改的名称');
            return;
        }

        if (!checkNotNull(articleTypeSort)) {
            zuiMsg('提示消息：请输入修改的排序');
            return;
        }

        $.post("/article/type/update", {
                articleTypeId: articleTypeId,
                articleTypeName: articleTypeName,
                articleTypeSort: articleTypeSort
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


    // 修改按钮，打开模态框，并回显数据
    // 参数是  类型id、类型名称、类型排序
    function openUpdateModal(articleTypeId, articleTypeName, articleTypeSort) {
        // 打开模态框
        $('#articleTypeUpdateModal').modal('toggle', 'center');

        $('#articleTypeId').val(articleTypeId);   // 填入articleTypeId带给后端

        $('#articleTypeName').val(articleTypeName);   // 回显 articleTypeName

        $('#articleTypeSort').val(articleTypeSort);   // 回显 articleTypeSort
    }


    // 打开添加模态框，不需要显示数据
    function addArticleType() {
        // 添加模态框和修改类型的模态框可以一致
        $('#addArticleTypeModal').modal('toggle', 'center');
    }


    // 删除按钮
    function delArticleType(articleTypeId) {
        if (!confirm('是否删除类型')) {
            return;
        }

        if (!checkNotNull(articleTypeId)) {
            new $.zui.Messager('提示消息：出错了！请刷新页面重试', {
                type: 'warning',     // 定义颜色主题
                placement: 'center'
            }).show();
            return;
        }

        $.post('/article/type/del', {
                articleTypeId: articleTypeId

            },
            function (data) {
                if (data.code === 200) {
                    new $.zui.Messager(data.message, {
                        type: 'success',
                        placement: 'center'
                    }).show();

                    // 设置定时器，弹出修改成功的标签后，1秒再刷新页面
                    setInterval(function () {
                        location.reload();  // 刷新当前页面
                    }, 300);

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


</script>


<#include "../import/bottom.ftl">

<#include "${springMacroRequestContext.contextPath}/import/top.ftl">


<div class="panel">
    <div class="panel-body">

        <form class="form-horizontal" action="/article/list" method="get">
            <div class="form-group">
                <label for="articleTitle" class="col-sm-2">文章标题</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" value="${articleTitle!}"
                           name="articleTitle" id="articleTitle" placeholder="文章标题">
                </div>
                <div class="col-sm-2">
                    <button type="submit"><i class="icon icon-search"></i> 搜索文章</button>
                </div>
                <div class="col-sm-2">
                    <button type="button" onclick="getAll()"><i class="icon icon-search"></i> 搜索All</button>
                </div>
            </div>
        </form>

    </div>
</div>

<div class="panel">
    <div class="panel-body">

        <a href="/article/publish" class="btn btn-mini">添加文章
        </a>
        <hr/>

        <#if articleIPage?? && articleIPage.list?size gt 0>

            <h4>当前共有 ${(articleIPage.total)!0} 篇文章</h4>
            <table class="table table-hover table-bordered">
                <thead>
                <tr>
                    <th>文章标题</th>
                    <th>文章类型</th>
                    <th>发布者</th>
                    <th>发布时间</th>
                    <th>浏览</th>
                    <th>点赞</th>
                    <th>收藏</th>
                    <th>操作</th>
                </tr>

                </thead>

                <#list articleIPage.list as article>

                    <tbody>
                    <tr>
                        <td>${(article.articleTitle)!}</td>
                        <td>${(article.articleTypeName)!}</td>
                        <td>${(article.userName)!}</td>
                        <td>${(article.articleAddTime)!}</td>
                        <td>${(article.articleLookNumber)!}</td>
                        <td>${(article.articleGoodNumber)!}</td>
                        <td>${(article.articleCollectionNumber)!}</td>
                        <td>
                            <a class="btn btn-mini" href="/article/view/${(article.articleId)!}">
                                <i class="icon icon-eye-open"></i>查看</a>

                            <a class="btn btn-mini" href="/article/edit/${(article.articleId)!}">
                                <i class="icon icon-edit-sign"></i>编辑</a>

                            <button onclick="delArticleById(${article.articleId})"
                                    type="button" class="btn btn-mini"><i class="icon icon-remove"></i>删除
                            </button>
                        </td>
                    </tr>

                    </tbody>

                </#list>

            </table>


            <div class="panel">
                <div class="panel-body" style="padding: 0;">
                    <div class="col-sm-12" style="padding: 0;text-align: center;">
                        <ul class="pager" style="margin-top: 10px;margin-bottom: 10px;">
                            <#--                    跳转到第一页          -->
                            <li class="previous" onclick="getNewData(1)">
                                <a href="javascript:void(0)"><i class="icon-step-backward"></i></a>
                            </li>

                            <#--                    当前页小于等于 1 时，则按钮失效    -->
                            <#if articleIPage.pageNumber lte 1>
                                <li class="previous disabled">
                                    <a href="javascript:void(0)"><i class="icon-chevron-left"></i></a>
                                </li>
                            <#else>
                            <#--                            传入当前页面 大于1 的页数         -->
                                <li class="previous" onclick="getNewData('${articleIPage.pageNumber-1}')">
                                    <a href="javascript:void(0)"><i class="icon-chevron-left"></i></a>
                                </li>


                            <#--                        中间显示共多少页    -->
                            </#if>
                            <li>
                                <a href="javascript:void(0)" class="btn">
                                    ${articleIPage.pageNumber}页/共${articleIPage.totalPage}</a>
                            </li>

                            <#--                    如果当前页码大于等于总页码 按钮失效       -->
                            <#if articleIPage.pageNumber gte articleIPage.totalPage>
                                <li class="next disabled">
                                    <a href="javascript:void(0)"><i class="icon-chevron-right"></i></a>
                                </li>

                            <#--                        下一页传入当前页码 +1    -->
                            <#else>
                                <li class="next" onclick="getNewData('${articleIPage.pageNumber+1}')">
                                    <a href="javascript:void(0)"><i class="icon-chevron-right"></i></a>
                                </li>


                            <#--                        传入最后一页的页码           -->
                            </#if>
                            <li class="previous" onclick="getNewData('${articleIPage.totalPage}')">
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


<script type="text/javascript">


    // 发送删除请求给后端
    function delArticleById(articleId) {
        if (!confirm('是否删除')) {
            return;
        }

        if (!checkNotNull(articleId)) {
            zuiMsg('提示消息：出错了！ 请刷新页面重试');
            return;
        }

        $.post('/article/del', {
            articleId: articleId
        }, function (data) {
            if (data.code == 200) {
                new $.zui.Messager(data.message, {
                    type: 'success',
                    placement: 'center'
                }).show();

                // 设置定时器，弹出删除成功的标签后，1秒后再刷新页面
                setInterval(function () {
                    location.reload();  // 刷新当前页面
                }, 500);
                return;
            }
            else if (data.code === '403') {
                zuiMsg(data.message);
            }
            else {
                zuiMsg(data.message);
            }
        });

    }


    // 获取所有的按钮
    function getAll() {
        window.location.href = '/article/list';
    }

    // 获取新数据
    function getNewData(pageNumber) {

        if (!checkNotNull(pageNumber)) {
            pageNumber = 1;
        }

        window.location.href = "/article/list?pageNumber=" + pageNumber + "<#if (articleTitle?? && articleTitle?length>0)>&articleTitle=${articleTitle!}</#if>";
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
        let totalPage = '${articleIPage.totalPage}';
        if (parseInt(renderPageNumber) > parseInt(totalPage)) {
            renderPageNumber = totalPage;
        }
        getNewData(renderPageNumber);
    }


</script>


<#include "${springMacroRequestContext.contextPath}/import/bottom.ftl">

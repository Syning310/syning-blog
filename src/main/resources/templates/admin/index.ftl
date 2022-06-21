<#include "../import/top.ftl">

<#--<div class="col-xs-6">-->
<#--    <div class="panel">-->

<#--        <div class="panel-body">-->

<#--            <h5><i class="icon icon-desktop"></i> 系统类型：${osName!}</h5>-->
<#--            <h5><i class="icon icon-server"></i> 服务器IP：${hostAddress!}</h5>-->

<#--            <h5><i class="icon icon-stack"></i> 文章数量：${articleCount!}</h5>-->
<#--            <h5><i class="icon icon-th-list"></i> 文章标签数量：${articleTagCount!}</h5>-->
<#--            <h5><i class="icon icon-user"></i> 用户数量：${userCount!}</h5>-->
<#--        </div>-->
<#--    </div>-->
<#--</div>-->

<div class="panel col-xs-12">


    <div class="form-group col-xs-6">


        <div style="margin-top: 15px;">


            <label for="exampleInputAccount4" class="col-sm-2">文章类型:</label>
            <div class="col-sm-6">

                <ul class="nav nav-primary">
                    <li class="dropdown">
                        <a class="dropdown-toggle" data-toggle="dropdown">

                            <#if articleTypeDTO.articleTypeName??>
                                ${articleTypeDTO.articleTypeName}
                            <#else>
                                --{ 无选择 }--
                            </#if>

                            <span class="caret"></span></a>
                        <ul class="dropdown-menu">
                            <li><a href="/">
                                    --{ 无选择 }--
                                </a></li>
                            <#if articleTypeList?? && articleTypeList?size gt 0>
                                <#list articleTypeList as type>
                                    <li>
                                        <a href="/?articleTypeId=${type.articleTypeId}&articleTypeName=${type.articleTypeName}">
                                            ${type.articleTypeName}</a></li>
                                </#list>
                            </#if>

                        </ul>
                    </li>
                </ul>


            </div>
        </div>

    </div>


    <div class="panel-body col-xs-6">

        <div>
            <form class="form-horizontal" action="/" method="get">
                <div class="form-group">
                    <label for="articleTitle" class="col-sm-3">文章标题</label>
                    <div class="col-sm-3">
                        <input type="text" class="form-control" value="${articleTitle!}"
                               name="articleTitle" id="articleTitle" placeholder="文章标题">
                    </div>
                    <div class="col-sm-3">
                        <button type="submit"><i class="icon icon-search"></i> 搜索文章</button>
                    </div>
                    <div class="col-sm-3">
                        <button type="button" onclick="getAll()"><i class="icon icon-search"></i> 搜索All</button>
                    </div>
                </div>


            </form>


        </div>

    </div>


</div>


<#if articlePage?? && articlePage.list?size gt 0>
    <#list articlePage.list as article>

        <div class="col-xs-6">
            <div class="panel">
                <div style="margin-left: 20px;">

                    <p class="lead" style="margin-top: 20px;">
                        <a href="/article/view/${(article.articleId)!}" style="color: black;"
                           href="">${(article.articleTitle)!}</a>
                    </p>

                    <p>文章类型: ${article.articleTypeName!}</p>
                    <p>发布时间: ${(article.articleAddTime)!}</p>
                </div>


            </div>
        </div>


    </#list>


    <div class="panel">
        <div class="panel-body" style="padding: 0;">
            <div class="col-sm-12" style="padding: 0;text-align: center;">
                <ul class="pager" style="margin-top: 10px;margin-bottom: 10px;">
                    <#--                    跳转到第一页          -->
                    <li class="previous" onclick="getNewData(1)">
                        <a href="javascript:void(0)"><i class="icon-step-backward"></i></a>
                    </li>

                    <#--                    当前页小于等于 1 时，则按钮失效    -->
                    <#if articlePage.pageNumber lte 1>
                        <li class="previous disabled">
                            <a href="javascript:void(0)"><i class="icon-chevron-left"></i></a>
                        </li>
                    <#else>
                    <#--                            传入当前页面 大于1 的页数         -->
                        <li class="previous" onclick="getNewData('${articlePage.pageNumber-1}')">
                            <a href="javascript:void(0)"><i class="icon-chevron-left"></i></a>
                        </li>


                    <#--                        中间显示共多少页    -->
                    </#if>
                    <li>
                        <a href="javascript:void(0)" class="btn">
                            ${articlePage.pageNumber}页/共${articlePage.totalPage}</a>
                    </li>

                    <#--                    如果当前页码大于等于总页码 按钮失效       -->
                    <#if articlePage.pageNumber gte articlePage.totalPage>
                        <li class="next disabled">
                            <a href="javascript:void(0)"><i class="icon-chevron-right"></i></a>
                        </li>

                    <#--                        下一页传入当前页码 +1    -->
                    <#else>
                        <li class="next" onclick="getNewData('${articlePage.pageNumber+1}')">
                            <a href="javascript:void(0)"><i class="icon-chevron-right"></i></a>
                        </li>


                    <#--                        传入最后一页的页码           -->
                    </#if>
                    <li class="previous" onclick="getNewData('${articlePage.totalPage}')">
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



</#if>


<script type="text/javascript">


    function findType(articleType) {

        let articleTypeId = articleType;

        console.log(articleTypeId);


    }


    // 获取新数据
    function getNewData(pageNumber) {

        if (!checkNotNull(pageNumber)) {
            pageNumber = 1;
        }

        window.location.href
            = "/?pageNumber=" + pageNumber + "<#if (articleTitle?? && articleTitle?length>0)>&articleTitle=${articleTitle!}</#if>"
            + '<#if articleTypeDTO.articleTypeId??>&articleTypeId=${articleTypeDTO.articleTypeId!}</#if>';
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
        let totalPage = '${articlePage.totalPage}';
        if (parseInt(renderPageNumber) > parseInt(totalPage)) {
            renderPageNumber = totalPage;
        }
        getNewData(renderPageNumber);
    }


    // 获取所有的按钮
    function getAll() {
        window.location.href = '/';
    }

</script>


<#include "../import/bottom.ftl">

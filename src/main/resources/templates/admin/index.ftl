<#include "../import/top.ftl">

<div class="col-xs-6">
    <div class="panel">

        <div class="panel-body">

            <h5><i class="icon icon-desktop"></i> 系统类型：${osName!}</h5>
            <h5><i class="icon icon-server"></i> 服务器IP：${hostAddress!}</h5>


        </div>
    </div>
</div>

<div class="col-xs-6">
    <div class="panel">

        <div class="panel-body">

            <h5><i class="icon icon-stack"></i> 文章数量：${articleCount!}</h5>
            <h5><i class="icon icon-th-list"></i> 文章标签数量：${articleTagCount!}</h5>
            <h5><i class="icon icon-user"></i> 用户数量：${userCount!}</h5>

        </div>
    </div>
</div>


<#include "../import/bottom.ftl">

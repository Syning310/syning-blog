<#include "${springMacroRequestContext.contextPath}/import/top.ftl">


<div class="panel col-sm-2">

    <h5><i class="icon icon-tags"></i>标签</h5>

    <style>
        .labelDiv {

            cursor: pointer;

        }
    </style>

    <div class="panel-body" style="padding: 0;">

        <#if tagList?? && tagList?size gt 0>

            <#list tagList as tag>

                <div id="${tag.articleTagId}" class="labelDiv label"><span>${tag.articleTagName}</span></div>

            </#list>


        </#if>

    </div>

    <script>
        // label-info
        let labels = $('.labelDiv');

        for (let i = 0; i < labels.length; ++i) {
            let lab = labels[i];
            lab.addEventListener('click', function () {
                lab.classList.toggle('label-info');

            });

        }


    </script>


</div>


<div class="panel col-sm-10">


    <div class="panel-body">
        <button type="button" class="btn btn-success pull-right" onclick="sendSaveArticle()">发送</button>
        <br>
        <hr>

        <label for="addAdTitle" class="col-sm-1">标题:</label>
        <div class="col-sm-5">
            <input type="text" class="form-control" id="artcileTitle" placeholder="标题">
        </div>

        <label for="exampleInputAccount4" class="col-sm-1">类型:</label>
        <div class="col-sm-3">

            <select class="form-control" id="articleType">
                <option>{-- 无选择 --}</option>
                <#if typeList?? && typeList?size gt 0>
                    <#list typeList as type>
                        <option>${type.articleTypeName}</option>
                    </#list>

                <#else>

                </#if>

            </select>
        </div>


    </div>


    <div class="panel-body">

        <div id="toolbar-container" style="z-index: 101;">

        </div>
        <div id="editor-container" style="z-index: 100; height: 700px;">

        </div>

    </div>
</div>


<!-- 引入 css -->
<link href="https://unpkg.com/@wangeditor/editor@latest/dist/css/style.css" rel="stylesheet">
<!-- 引入 js -->
<script src="https://unpkg.com/@wangeditor/editor@latest/dist/index.js" type="text/javascript"></script>

<script type="text/javascript">

    const {createEditor, createToolbar} = window.wangEditor

    // 编辑器配置
    const editorConfig = {}
    editorConfig.placeholder = '请输入内容'
    editorConfig.onChange = (editor) => {
        // 当编辑器选区、内容变化时，即触发
        // console.log('content', editor.children)
        // console.log('html', editor.getHtml())
    }

    // 工具栏配置
    const toolbarConfig = {}


    // 创建编辑器
    const editor = createEditor({
        selector: '#editor-container',
        config: editorConfig,
        mode: 'simple' // 或 'simple' 'default' 参考下文
    })

    // 创建工具栏
    const toolbar = createToolbar({
        editor,
        selector: '#toolbar-container',
        config: toolbarConfig,
        mode: 'simple' // 或 'simple' 'default' 参考下文
    })


    function sendSaveArticle() {


        // 获取文章标题
        let articleTitle = $('#artcileTitle').val();

        // 获取富文本编辑器中的内容
        let articleCentext = editor.getHtml();

        // 获取选中的文章类型id
        let articleTypeName = $('#articleType').val();

        // 如果选中了无选择，则置为空
        if (articleTypeName === '{-- 无选择 --}') {
            articleTypeName = null;
        }

        // 收集选中的所有点亮的 tag 标签，添加到数据库
        let labels = $('.label-info');      // 获取所有点亮的标签
        let tagList = [];                   // 数组
        for (let i = 0; i < labels.length; ++i) {

            tagList.push(Number(labels[i].id));     // 将点亮的标签的 id 添加进数组
        }


        let article = {
            'articleTitle': articleTitle,
            'articleCentext': articleCentext,
            'articleTypeName': articleTypeName,
            'articleTagList': tagList
        }

        let request = JSON.stringify(article);

        $.ajax({
            url: '/article/saveArticle',
            type: 'post',
            data: request,
            contentType: 'application/json;charset=UTF-8',
            dataType: 'json',
            success: function (data) {

                resolveRep(data);
            },
            error: function (data) {
                zuiMsg(data.message);
            }
        });

    }


</script>


<#include "${springMacroRequestContext.contextPath}/import/bottom.ftl">

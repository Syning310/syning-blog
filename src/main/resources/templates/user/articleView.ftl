<#include "${springMacroRequestContext.contextPath}/import/top.ftl">


<div class="panel col-sm-2">

    <h5><i class="icon icon-tags"></i>标签</h5>

    <style>
        .labelDiv {

            cursor: pointer;

        }
    </style>

    <div class="panel-body" style="padding: 0;">

        <#--           文章的 id   -->
        <input type="hidden" id="articleId" value="${articleVO.articleId}">

        <#--            亮起的标签   -->
        <#list upTagVO as upTag>
            <div id="${upTag.tagId}" class="labelDiv label label-info"><span>${upTag.tagName}</span></div>
        </#list>

        <#--            不亮起的标签      -->
        <#list noTagVO as noTag>
            <div id="${noTag.tagId}" class="labelDiv label"><span>${noTag.tagName}</span></div>
        </#list>

    </div>

    <#--    <script>-->
    <#--        // label-info-->
    <#--        let labels = $('.labelDiv');-->

    <#--        for (let i = 0; i < labels.length; ++i) {-->
    <#--            let lab = labels[i];-->
    <#--            lab.addEventListener('click', function () {-->
    <#--                lab.classList.toggle('label-info');-->

    <#--            });-->

    <#--        }-->

    <#--    </script>-->


</div>


<div class="panel col-sm-10">

    <div class="panel-body">


        <article class="article">
            <!-- 文章头部 -->
            <header>
                <h1>${(articleVO.articleTitle)!}</h1>
                <!-- 文章属性列表 -->
                <dl class="dl-inline">
                    <dt>发布人: ${(articleVO.userName)!}</dt> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 文章类型:
                    <b>${(articleVO.articleTypeName)!}</b>
                    <dd></dd>
                </dl>
                <div class="abstract">
                    <p>发布时间: ${(articleVO.articleAddTime)!}</p>
                </div>
            </header>
            <!-- 文章正文部分 -->
            <section class="content">
                ${(articleVO.articleCentext)!}
            </section>
            <!-- 文章底部 -->
            <footer>
                <ul class="pager pager-justify">


                </ul>
            </footer>


            <div class="comments">
                <header>
                    <div class="pull-right"><a href="#commentReplyForm2" class="btn btn-primary"><i
                                    class="icon-comment-alt"></i> 发表评论</a></div>
                    <h3>所有评论</h3>
                </header>
                <#if commentVOList?? && commentVOList?size gt 0>

                    <#list commentVOList as commentvo>
                        <section class="comments-list">
                            <div class="comment">
                                <a href="###" class="avatar">
                                    <i class="icon-camera-retro icon-2x"></i>
                                </a>

                                <div class="content">
                                    <div class="pull-right text-muted">${(commentvo.timeEquation)!}</div>
                                    <div><a href="###"><strong>${commentvo.userName!}</strong></a></div>
                                    <div class="text">${commentvo.content!}</div>
                                    <div class="actions">
                                        <a onclick="openSaveReply(${commentvo.commentId}, ${commentvo.userId})">回复</a>
                                        <a onclick="delComment(${commentvo.commentId})">删除</a>
                                    </div>
                                </div>

                                <#if commentvo.replyVOList??>
                                    <#list commentvo.replyVOList as reply>

                                        <div class="comments-list">
                                            <div class="comment">
                                                <a href="###" class="avatar">
                                                    <i class="icon-user icon-2x"></i>
                                                </a>
                                                <div class="content">
                                                    <div class="pull-right text-muted">${(reply.timeEqt)!}</div>
                                                    <div><a href="###"><strong>${(reply.replyUserName)!}</strong>
                                                        </a> <span class="text-muted">回复</span> <a
                                                                href="###">${reply.commentUserName!}</a></div>
                                                    <div class="text">${(reply.replyContent)}</div>
                                                    <div class="actions">
                                                        <a onclick="openSaveReply(${commentvo.commentId}, ${commentvo.userId})">回复</a>
                                                        <a onclick="delReply(${reply.commentReplyId})">删除</a>
                                                    </div>
                                                </div>

                                            </div>

                                        </div>
                                    </#list>
                                </#if>


                            </div>


                        </section>

                    </#list>

                <#else>
                    <h4>暂无评论</h4>
                </#if>

                <footer>
                    <div class="reply-form" id="commentReplyForm2">
                        <a href="###" class="avatar"><i class="icon-user icon-2x"></i></a>
                        <form class="form">
                            <div class="form-group">
                                        <textarea style="resize:none;" class="form-control new-comment-text" rows="2"
                                                  id="content" placeholder="撰写评论..."></textarea>
                            </div>
                            <div class="form-group comment-user">
                                <div class="row">

                                    <div class="col-md-7">

                                    </div>
                                    <div class="col-md-2">
                                        <button style="margin-left: 205px;" type="button"
                                                class="btn btn-block btn-primary" onclick="sumbitComment()">
                                            <i class="icon-ok"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </footer>
            </div>


        </article>


    </div>

</div>


<div id="addReplyModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span
                            class="sr-only">关闭</span></button>
                <h4 class="modal-title">回复</h4>
            </div>
            <input type="hidden" id="repCommentId">
            <input type="hidden" id="repUserId">
            <div class="input-control has-label-left">
                <input type="text" class="form-control" placeholder="" id="replyContent">
                <label for="inputAccountExample3" class="input-control-label-left text-right">输入:</label>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="sendSaveReply()">发送</button>
            </div>
        </div>
    </div>
</div>


<!-- 引入 css -->
<link href="https://unpkg.com/@wangeditor/editor@latest/dist/css/style.css" rel="stylesheet">
<!-- 引入 js -->
<script src="https://unpkg.com/@wangeditor/editor@latest/dist/index.js" type="text/javascript"></script>

<script type="text/javascript">

    // 删除评论
    function delComment(commentId) {

        if (!confirm("是否删除?")) {
            returnl;
        }

        $.post('/comment/del', {
            commentId: commentId
        }, rep => {
            resolveRep(rep);
        });

    }



    // 删除回复
    function delReply(replyId) {
        if (!confirm("是否删除?")) {
            returnl;
        }

        // 发送到后端，删除这条回复
        $.post('/reply/del', {
            replyId: replyId
        }, rep => {
            resolveRep(rep);
        });

    }


    // 将回复内容发送到后端
    function sendSaveReply() {
        // 收集数据
        let commentId = $('#repCommentId').val();
        let userId = $('#repUserId').val();

        let replyContent = $('#replyContent').val();

        let request = {
            commentId: commentId,
            commentUserId: userId,
            replyContent: replyContent
        }

        request = JSON.stringify(request);

        $.ajax({
            url: '/reply/save',
            type: 'post',
            data: request,
            contentType: 'application/json',
            dataType: 'json',
            success: rep => {
                resolveRep(rep);
            },
            error: rep => {
                zuiMsg(rep.message);
            }
        });

    }


    // 打开回复模态框
    function openSaveReply(commentId, userId) {
        $('#repCommentId').val(commentId);
        $('#repUserId').val(userId);

        $('#addReplyModal').modal('show');
    }


    // 发送评论发送给后端
    function sumbitComment() {

        // 1、收集当前文章的id
        // 2、收集评论，封装起来发送给后端

        let articleId = ${(articleVO.articleId)!};
        let content = $('#content').val();

        if (!checkNotNull(content)) {
            zuiMsg('请输入内容!');
            return;
        }

        let comment = {
            articleId: articleId,
            content: content
        }


        comment = JSON.stringify(comment);

        $.ajax({
            url: '/comment/save',
            type: 'post',
            data: comment,
            contentType: 'application/json;charset=UTF-8',
            dataType: 'json',
            success: rep => {
                resolveRep(rep);
            },
            error: rep => {
                zuiMsg(rep.message);
            }
        });


    }


</script>


<#include "${springMacroRequestContext.contextPath}/import/bottom.ftl">

<#include "${springMacroRequestContext.contextPath}/import/top.ftl">

<div class="panel col-sm-2">

    <div class="panel-body" style="padding: 0;">

        <br>
        <form class="form-horizontal">
            <input type="hidden" name="adTypeId" id="adTypeIdUpdate">

            <div class="form-group">

                <div class="col-md-12 col-sm-10">
                    <input type="text" class="form-control" id="adTypeTitleUpdate" name="adTypeTitle"
                           placeholder="类型名称">
                </div>
            </div>
            <div class="form-group">

                <div class="col-md-12 col-sm-10">
                    <input type="text" class="form-control" id="adTypeTagUpdate" name="adTypeTag" placeholder="类型标识">
                </div>
            </div>

            <div class="form-group">
                <button type="button" onclick="sendUpdate()" class="btn btn-mini"
                        style="position: relative; right: -10px;">提交
                </button>
                <button type="button" onclick="sendAdd()" class="btn btn-mini"
                        style="position: relative; right: -10px;">添加
                </button>
            </div>

        </form>

    </div>


    <div class="panel-body" style="padding: 0;">
        <br>
        <ul class="list-group">
            <#if adTypeList?? && adTypeList?size gt 0>

                <#list adTypeList as adType>

                    <li class="list-group-item">
                        <a href="/ad/list?adTypeId=${adType.adTypeId}">
                            ${(adType.adTypeTitle)!}
                        </a>

                        <button class="btn btn-mini" type="button"
                                onclick="adTypeUpdate(${(adType.adTypeId)!}, '${(adType.adTypeTitle)!}', '${(adType.adTypeTag)!}')">
                            <i class="icon icon-paint-brush pull-right"></i>
                        </button>

                    </li>

                </#list>

            </#if>
        </ul>


    </div>

</div>


<div class="panel col-sm-10">


    <div class="panel-body">
        <form class="form-horizontal">

            <input type="hidden" id="addAdId">

            <div class="form-group">
                <label for="exampleInputAccount4" class="col-sm-2">广告类型:</label>
                <div class="col-sm-3">

                    <select class="form-control" id="addAdType" name="adType">
                        <#if adTypeList?? && adTypeList?size gt 0>
                            <#list adTypeList as adType>
                                <option>${(adType.adTypeId)}.${(adType.adTypeTitle)!}</option>

                            </#list>

                        <#else>
                        </#if>

                    </select>
                </div>

                <label for="addAdTitle" class="col-sm-2">广告标题:</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="addAdTitle" placeholder="广告标题">
                </div>

            </div>

            <div class="form-group">
                <label for="adUrl" class="col-sm-2">广告地址:</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="addAdSort" placeholder="广告地址">
                </div>

                <label for="adUrl" class="col-sm-2">图片地址:</label>
                <div class="col-sm-3">
                    <input type="text" class="form-control" id="addAdUrl" placeholder="图片地址">
                </div>

            </div>

            <div class="form-group">

                <label for="adUrl" class="col-sm-2">开始时间:</label>
                <div class="col-sm-3">
                    <input type="datetime-local" class="form-control" id="addBeginTime" placeholder="开始时间">
                </div>

                <label for="adUrl" class="col-sm-2">结束时间:</label>
                <div class="col-sm-3">
                    <input type="datetime-local" class="form-control" id="addEndTime" placeholder="结束时间">
                </div>

            </div>


            <button type="button" class="btn btn-group pull-right" onclick="sumbitAd()">提交</button>
        </form>


    </div>

    <hr>

    <div class="panel-body">
        <button type="button" class="btn btn-mini" style="margin-bottom: 10px;" onclick="addAd()">添加</button>

        <#if adList?? && adList?size gt 0>

            <table class="table table-hover table-bordered">
                <thead>
                <tr>
                    <th>广告</th>
                    <th>标题</th>
                    <th>类型</th>
                    <th>开始时间</th>
                    <th>结束时间</th>
                    <th>发布时间</th>
                    <th>操作</th>
                </tr>

                </thead>

                <#list adList as ad>

                    <tbody>
                    <tr>
                        <td>
                            <#if ad.adUrl?? && ad.adUrl?length gt 0>
                                <img src="${ad.adUrl}" width="30px" height="20px">

                            <#else>
                                <img src="/res/img/null_logo.png" class="img-thumbnail" width="30px" height="20px">
                            </#if>
                        </td>

                        <td>${(ad.adTitle)!}</td>
                        <td>${(ad.adTypeTitle)!}</td>
                        <td>${(ad.adBeginTime)!}</td>
                        <td>${(ad.adEndTime)!}</td>
                        <td>${(ad.adAddTime)!}</td>

                        <td>
                            <a target="_blank" class="btn btn-mini" href="${ad.adSort}">
                                <i class="icon icon-eye-open"></i>查看</a>


                            <button type="button" class="btn btn-mini"
                                    onclick="updateAd(${(ad.adId)!},
                                            '${(ad.adType)}.${(ad.adTypeTitle)!}',
                                            '${(ad.adTitle)!}',
                                            '${(ad.adUrl)!}',
                                            '${(ad.adSort)!}',
                                            '${(ad.adBeginTime)!}',
                                            '${(ad.adEndTime)!}')"
                            ><i class="icon icon-undo"></i>编辑
                            </button>

                            <button type="button" class="btn btn-mini" onclick="delAd(${ad.adId})">
                                <i class="icon icon-remove"></i>删除
                            </button>
                        </td>
                    </tr>

                    </tbody>

                </#list>

            </table>


        </#if>


    </div>
</div>


<script type="text/javascript">


    function sendAdd() {
        let adTypeTitle = $('#adTypeTitleUpdate').val();
        let adTypeTag = $('#adTypeTagUpdate').val();

        console.log(adTypeTitle);
        console.log(adTypeTag);

        if (!checkNotNull(adTypeTitle) || !checkNotNull(adTypeTag)) {
            zuiMsg('请完善参数!');
            return;
        }

        $.post('/ad/type/addOrUpdate', {
            adTypeTitle: adTypeTitle,
            adTypeTag: adTypeTag
        }, function (data) {
            resolveRep(data);
        });

    }


    function addAd() {
        $('#addAdId').val("")
        $('#addAdTypeId').val("");
        $('#addAdTitle').val("");
        $('#addAdUrl').val("");
        $('#addAdSort').val("");
        $('#addBeginTime').val("");
        $('#addEndTime').val("");
    }


    function sumbitAd() {

        let adId = $('#addAdId').val();
        let adType = $('#addAdType').val();
        // 截取字符串
        let str = adType.split('.');
        adType = str[0];    // adTypeId

        let adTitle = $('#addAdTitle').val();
        let adUrl = $('#addAdUrl').val();
        let adSort = $('#addAdSort').val();
        let beginTime = $('#addBeginTime').val();
        let endTime = $('#addEndTime').val();

        if (!checkNotNull(adType)
            || !checkNotNull(adTitle)
            || !checkNotNull(adUrl)
            || !checkNotNull(adSort)
            || !checkNotNull(beginTime)
            || !checkNotNull(endTime)) {
            zuiMsg('请完善参数!!!');
            return;
        }

        // 添加请求
        if (!checkNotNull(adId)) {
            console.log('add');

            $.post('/ad/addOrUpdate', {
                adType: adType,
                adTitle: adTitle,
                adUrl: adUrl,
                adSort: adSort,

                beginTime: beginTime,
                endTime: endTime
            }, function (data) {
                resolveRep(data);
            });
            return;
        }


        $.post('/ad/addOrUpdate', {
            adId: adId,
            adType: adType,
            adTitle: adTitle,
            adUrl: adUrl,
            adSort: adSort,

            beginTime: beginTime,
            endTime: endTime
        }, function (data) {
            resolveRep(data);
        });

    }


    // 填充修改类型的表单
    function adTypeUpdate(adTypeId, adTypeTitle, adTypeTag) {

        $('#adTypeIdUpdate').val(adTypeId);
        $('#adTypeTitleUpdate').val(adTypeTitle);
        $('#adTypeTagUpdate').val(adTypeTag);
    }

    // 发送给后端修改
    function sendUpdate() {
        let adTypeId = $('#adTypeIdUpdate').val();
        let adTypeTitle = $('#adTypeTitleUpdate').val();
        let adTypeTag = $('#adTypeTagUpdate').val();

        if (!checkNotNull(adTypeTitle) || !checkNotNull(adTypeTag)) {
            zuiMsg('请输入完整信息');
            return;
        }

        $.post('/ad/type/addOrUpdate', {
            adTypeId: adTypeId,
            adTypeTitle: adTypeTitle,
            adTypeTag: adTypeTag
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


    // 填充修改广告的表单
    function updateAd(adId, adType, adTitle, adUrl, adSort, adBeginTime, adEndTime) {

        $('#addAdId').val(adId);
        $('#addAdType').val(adType);
        $('#addAdTitle').val(adTitle);
        $('#addAdSort').val(adSort);
        $('#addAdUrl').val(adUrl);

        // datetime-local 必须是 2022-06-16T19:08:45 格式才能转换
        // adEndTime = adEndTime.replace('T', ' ');
        // adBeginTime = adBeginTime.replace('T', ' ');

        $('#addBeginTime').val(adBeginTime);
        $('#addEndTime').val(adEndTime);

    }

    function delAd(adId) {

        if( !confirm('是否删除？') ) {
            return;
        }

        if (!checkNotNull(adId)) {
            zuiMsg('出错了 请刷新页面重试');
            return;
        }


        $.post('/ad/del', {
            adId: adId
        }, function (data) {
            resolveRep(data);
        });

    }


</script>


<#include "${springMacroRequestContext.contextPath}/import/bottom.ftl">

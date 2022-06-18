
function checkNotNull(str) {
    if (str == null || str == "" || str.length < 1 || str == undefined) {
        return false;
    }
    return true;
}

function zuiMsg(msg) {
    new $.zui.Messager(msg, {
        type: 'warning',     // 定义颜色主题
        placement: 'center'
    }).show();
}

function resolveRep (data) {
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
        return;
    }
}










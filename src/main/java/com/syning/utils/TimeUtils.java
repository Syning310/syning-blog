package com.syning.utils;

import java.time.Duration;
import java.time.LocalDateTime;

public class TimeUtils {

    /**
     *  返回添加时间与当前时间的时差，如果小于1天，则显示小时级别；如果小于1小时，则按分钟显示
     * @param time
     * @return
     */
    public static String timeEquation(LocalDateTime time) {

        LocalDateTime now = LocalDateTime.now();

        Duration duration = Duration.between(time, now);

        if (duration.toDays() > 0) {
            return duration.toDays() + " 天前";
        } else if (duration.toHours() > 0) {
            return duration.toHours() + " 个小时前";
        } else if (duration.toMinutes() > 0) {
            return duration.toMinutes() + " 分钟前";
        } else {
            return "刚刚评论";
        }

    }

}

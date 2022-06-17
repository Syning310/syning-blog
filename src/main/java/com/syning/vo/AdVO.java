package com.syning.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.Date;


@AllArgsConstructor
@NoArgsConstructor
@Data
public class AdVO {
    /**
     * 广告id
     */
    private Integer adId;

    /**
     * 广告标题
     */
    private String adTitle;

    /**
     * 广告类型id
     */
    private Integer adType;

    /**
     *  广告类型名称
     */
    private String adTypeTitle;

    /**
     * 广告的url地址
     */
    private String adUrl;

    /**
     * 修改为，跳转的地址
     */
    private String adSort;

    /**
     * 广告开始时间
     */
    private LocalDateTime adBeginTime;

    /**
     * 广告结束时间
     */
    private LocalDateTime adEndTime;

    /**
     * 广告添加时间
     */
    private LocalDateTime adAddTime;

}

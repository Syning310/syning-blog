package com.syning.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * <p>
 * 
 * </p>
 *
 * @author jobob
 * @since 2022-06-14
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class TAd implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 广告id
     */
    @TableId(value = "ad_id", type = IdType.AUTO)
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
     * 广告的url地址
     */
    private String adUrl;

    /**
     * 广告排序，越小排在前面
     */
    private Integer adSort;

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

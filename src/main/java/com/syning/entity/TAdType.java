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
public class TAdType implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 广告类型id
     */
    @TableId(value = "ad_type_id", type = IdType.AUTO)
    private Integer adTypeId;

    /**
     * 广告类型名称
     */
    private String adTypeTitle;

    /**
     * 广告标识(首页顶部广告、轮播图广告、文章详情广告)
     */
    private String adTypeTag;

    /**
     * 广告类型排序，越小排在前面
     */
    private Integer adTypeSort;

    /**
     * 广告添加时间
     */
    private LocalDateTime adTypeAddTime;


}

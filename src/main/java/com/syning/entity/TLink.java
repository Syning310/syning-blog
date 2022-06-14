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
public class TLink implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 友情链接id
     */
    @TableId(value = "link_id", type = IdType.AUTO)
    private Integer linkId;

    /**
     * 友情链接标题
     */
    private String linkTitle;

    /**
     * 友情链接地址
     */
    private String linkUrl;

    /**
     * 友情链接logo
     */
    private String linkLogoUrl;

    /**
     * 添加链接的时间
     */
    private LocalDateTime linkAddTime;


}

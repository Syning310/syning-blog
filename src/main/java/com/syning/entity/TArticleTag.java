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
public class TArticleTag implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 文章标签id
     */
    @TableId(value = "article_tag_id", type = IdType.AUTO)
    private Integer articleTagId;

    /**
     * 标签名称
     */
    private String articleTagName;

    /**
     * 添加时间
     */
    private LocalDateTime articleTagAddTime;


}

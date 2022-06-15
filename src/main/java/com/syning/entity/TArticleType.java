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
 * @since 2022-06-15
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class TArticleType implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 文章分类id
     */
    @TableId(value = "article_type_id", type = IdType.AUTO)
    private Integer articleTypeId;

    /**
     * 文章分类父id
     */
    private Integer articleTypeParentId;

    /**
     * 文章分类名称
     */
    private String articleTypeName;

    /**
     * 分类排序，越小排前面
     */
    private Integer articleTypeSort;

    /**
     * 添加时间
     */
    private LocalDateTime articleTypeAddTime;


}

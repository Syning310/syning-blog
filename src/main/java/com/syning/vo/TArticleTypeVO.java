package com.syning.vo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 *
 * </p>
 *
 * @author jobob
 * @since 2022-06-15
 */
@Data
public class TArticleTypeVO implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 文章分类id
     */
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


    /**
     *  文章数量
     */
    @TableField(exist = false)
    private Integer articleCount;

}

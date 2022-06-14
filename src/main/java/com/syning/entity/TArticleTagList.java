package com.syning.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
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
public class TArticleTagList implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 文章对应标签id
     */
    @TableId(value = "article_tag_list_id", type = IdType.AUTO)
    private Integer articleTagListId;

    /**
     * 文章id
     */
    private Integer articleId;

    /**
     * 文章标签id
     */
    private Integer articleTagId;


}

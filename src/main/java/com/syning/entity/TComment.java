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
public class TComment implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 文章评论id
     */
    @TableId(value = "comment_id", type = IdType.AUTO)
    private Integer commentId;

    /**
     * 文章id
     */
    private Integer articleId;

    /**
     * 评论人(用户id)
     */
    private Integer userId;

    /**
     * 评论时间
     */
    private LocalDateTime commentTime;

    /**
     * 点赞次数
     */
    private Integer commentGoodNumber;


}

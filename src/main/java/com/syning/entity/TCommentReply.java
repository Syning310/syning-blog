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
public class TCommentReply implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 评论回复id
     */
    @TableId(value = "comment_reply_id", type = IdType.AUTO)
    private Integer commentReplyId;

    /**
     * 针对评论的id
     */
    private Integer commentId;

    /**
     * 被评论的人的id
     */
    private Integer commentUserId;

    /**
     * 评论用户的id
     */
    private Integer replyUserId;

    /**
     * 回复的时间
     */
    private LocalDateTime commentReplyAddTime;


}

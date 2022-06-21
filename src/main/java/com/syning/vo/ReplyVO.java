package com.syning.vo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
public class ReplyVO implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 评论回复id
     */
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
     *  被评论人的name
     */
    private String commentUserName;

    /**
     *  回复内容
     */
    private String replyContent;

    /**
     * 评论用户的id
     */
    private Integer replyUserId;

    /**
     * 评论人的name
     */
    private String replyUserName;

    /**
     * 回复的时间
     */
    private LocalDateTime commentReplyAddTime;


    /**
     *  时差
     */
    private String timeEqt;

}


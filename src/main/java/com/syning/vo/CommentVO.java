package com.syning.vo;


import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class CommentVO implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 文章评论id
     */
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
     *  评论用户的 name
     */
    private String userName;

    /**
     *  评论的内容
     */
    private String content;

    /**
     * 评论时间
     */
    private LocalDateTime commentTime;

    /**
     * 点赞次数
     */
    private Integer commentGoodNumber;


    /**
     *  该条评论的回复集合
     */
    private List<ReplyVO> replyVOList;


    /**
     *  时差
     */
    private String timeEquation;

}

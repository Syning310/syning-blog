package com.syning.service;

import com.syning.entity.TCommentReply;
import com.baomidou.mybatisplus.extension.service.IService;
import com.syning.vo.ReplyVO;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author jobob
 * @since 2022-06-14
 */
public interface ITCommentReplyService extends IService<TCommentReply> {

    /**
     *  根据评论的 id 获取这条评论的回复
     * @param commentId
     * @return
     */
    List<ReplyVO> getReplyVOList(Integer commentId);

}

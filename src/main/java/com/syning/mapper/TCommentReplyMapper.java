package com.syning.mapper;

import com.syning.entity.TCommentReply;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.syning.vo.ReplyVO;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author jobob
 * @since 2022-06-14
 */
public interface TCommentReplyMapper extends BaseMapper<TCommentReply> {

    /**
     *  根据评论id，获取ReplyVO
     * @param commentId
     * @return
     */
    List<ReplyVO> getReplyVOList(Integer commentId);

}

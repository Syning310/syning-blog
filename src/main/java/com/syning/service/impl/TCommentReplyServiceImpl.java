package com.syning.service.impl;

import com.syning.entity.TCommentReply;
import com.syning.mapper.TCommentReplyMapper;
import com.syning.service.ITCommentReplyService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.syning.vo.ReplyVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author jobob
 * @since 2022-06-14
 */
@Service
public class TCommentReplyServiceImpl extends ServiceImpl<TCommentReplyMapper, TCommentReply> implements ITCommentReplyService {

    @Resource
    private TCommentReplyMapper commentReplyMapper;

    @Override
    public List<ReplyVO> getReplyVOList(Integer commentId) {
        return commentReplyMapper.getReplyVOList(commentId);
    }
}

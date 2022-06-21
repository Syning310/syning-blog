package com.syning.mapper;

import com.syning.entity.TComment;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.syning.vo.CommentVO;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author jobob
 * @since 2022-06-14
 */
public interface TCommentMapper extends BaseMapper<TComment> {

    /**
     *  根据文章的id，获取该文章的所有评论
     * @param articleId
     * @return
     */
    List<CommentVO> getCommentVOList(Integer articleId);

}

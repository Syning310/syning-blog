package com.syning.service;

import com.syning.entity.TComment;
import com.baomidou.mybatisplus.extension.service.IService;
import com.syning.mapper.TCommentMapper;
import com.syning.vo.CommentVO;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author jobob
 * @since 2022-06-14
 */
public interface ITCommentService extends IService<TComment> {


    List<CommentVO> getCommentVOList(Integer articleId);

}

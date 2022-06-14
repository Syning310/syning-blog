package com.syning.service.impl;

import com.syning.entity.TComment;
import com.syning.mapper.TCommentMapper;
import com.syning.service.ITCommentService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author jobob
 * @since 2022-06-14
 */
@Service
public class TCommentServiceImpl extends ServiceImpl<TCommentMapper, TComment> implements ITCommentService {

}

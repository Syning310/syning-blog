package com.syning.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.syning.entity.TArticle;
import com.syning.mapper.TArticleMapper;
import com.syning.service.ITArticleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.syning.vo.ArticleVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author jobob
 * @since 2022-06-15
 */
@Service
public class TArticleServiceImpl extends ServiceImpl<TArticleMapper, TArticle> implements ITArticleService {

    @Resource
    private TArticleMapper articleMapper;

    /**
     *  文章列表
     * @param articlePage
     * @param articleTitle
     * @return
     */
    @Override
    public IPage<ArticleVO> articleList(IPage<ArticleVO> articlePage, String articleTitle) {

        IPage<ArticleVO> articleIPage = articleMapper.articleList(articlePage, articleTitle);

        return articleIPage;
    }

}

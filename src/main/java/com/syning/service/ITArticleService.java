package com.syning.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.syning.entity.TArticle;
import com.baomidou.mybatisplus.extension.service.IService;
import com.syning.vo.ArticleVO;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author jobob
 * @since 2022-06-15
 */
public interface ITArticleService extends IService<TArticle> {

    /**
     *
     * @param articlePage
     * @param articleTitle
     * @return
     */
    IPage<ArticleVO> articleList(IPage<ArticleVO> articlePage, String articleTitle);
}

package com.syning.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.syning.entity.TArticle;
import com.baomidou.mybatisplus.extension.service.IService;
import com.syning.utils.CommonResult;
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


    boolean isItMins(Integer articleId, String userName);

    /**
     *  修改信息
     * @param articleVO
     * @return
     */
    boolean updateByArticleVO(ArticleVO articleVO);

    /**
     *  通过文章id获取vo
     * @param articleId
     * @return
     */
    ArticleVO getArticleVOById(Integer articleId);


    /**
     *  保存文章内容到数据库
     * @return
     */
    boolean saveArticle(ArticleVO article);


    /**
     *
     * @param articlePage
     * @param articleTitle
     * @return
     */
    IPage<ArticleVO> articleList(IPage<ArticleVO> articlePage, String articleTitle, Integer articleTypeId);


    /**
     *
     * @param articlePage
     * @param articleTitle
     * @return
     */
    IPage<ArticleVO> articleList(IPage<ArticleVO> articlePage, String articleTitle);
}

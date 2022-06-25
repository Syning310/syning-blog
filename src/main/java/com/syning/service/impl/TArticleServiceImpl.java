package com.syning.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.syning.entity.TArticle;
import com.syning.mapper.TArticleMapper;
import com.syning.service.ITArticleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.syning.utils.CommonResult;
import com.syning.vo.ArticleVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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


    @Override
    public boolean isItMins(Integer articleId, String userName) {
        // 根据文章id和用户名，查询该文章是不是属于这个用户的，如果返回null，则说明不属于
        Integer id = articleMapper.isItMins(articleId, userName);

        return id != null;
    }

    @Override
    public boolean updateByArticleVO(ArticleVO articleVO) {
        return articleMapper.updateByArticleVO(articleVO);
    }

    @Override
    public ArticleVO getArticleVOById(Integer articleId) {
        return articleMapper.getArticleVO(articleId);
    }

    /**
     * 保存文章内容到数据库
     * @return
     */
    @Override
    public boolean saveArticle(ArticleVO article) {

        // 保存到数据库
        boolean saveBool = articleMapper.saveArticle(article);

        return saveBool;
    }

    /**
     *  文章列表
     * @param articlePage
     * @param articleTitle
     * @return
     */
    @Override
    public IPage<ArticleVO> articleList(IPage<ArticleVO> articlePage, String articleTitle) {

        IPage<ArticleVO> articleIPage = articleMapper.articleList(articlePage, articleTitle, null);

        return articleIPage;
    }


    @Override
    public IPage<ArticleVO> articleList(IPage<ArticleVO> articlePage, String articleTitle, Integer articleTypeId) {
        return articleMapper.articleList(articlePage, articleTitle, articleTypeId);
    }
}

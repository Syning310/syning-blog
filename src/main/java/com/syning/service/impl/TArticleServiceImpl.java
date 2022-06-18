package com.syning.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.syning.entity.TArticle;
import com.syning.mapper.TArticleMapper;
import com.syning.service.ITArticleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.syning.utils.CommonResult;
import com.syning.vo.ArticleVO;
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

    /**
     * 保存文章内容到数据库
     * @return
     */
    @Override
    @Transactional
    public CommonResult saveArticle(ArticleVO article) {

        // 保存到数据库
        boolean saveBool = articleMapper.saveArticle(article);

        if (saveBool) {
            return CommonResult.success("保存成功!");
        } else {

            return CommonResult.failed("保存失败!");
        }
    }

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

package com.syning.mapper;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.syning.entity.TArticle;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.syning.vo.ArticleVO;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author jobob
 * @since 2022-06-15
 */
public interface TArticleMapper extends BaseMapper<TArticle> {

    /**
     *  文章列表
     * @param articlePage
     * @param articleTitle
     */
    IPage<ArticleVO> articleList(@Param("articlePage") IPage<ArticleVO> articlePage, @Param("articleTitle") String articleTitle);


}

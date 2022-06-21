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
     *  根据 articleVO 修改
     * @param articleVO
     * @return
     */
    boolean updateByArticleVO(ArticleVO articleVO);



    /**
     *  文章列表
     * @param articlePage
     * @param articleTitle
     */
    IPage<ArticleVO> articleList(@Param("articlePage") IPage<ArticleVO> articlePage,
                                 @Param("articleTitle") String articleTitle,
                                 @Param("articleTypeId") Integer articleTypeId);

    /**
     *  保存
     * @param article
     * @return
     */
    boolean saveArticle(ArticleVO article);


    /**
     *  根据文章的 id 获取ArticleVO对象
     * @param articleId
     * @return
     */
    ArticleVO getArticleVO(Integer articleId);


//    /**
//     *  根据文章类型id获取
//     * @param articlePage
//     * @param articleTypeId
//     * @return
//     */
//    IPage<ArticleVO> articleListByArticleTypeId(@Param("articlePage") IPage<ArticleVO> articlePage,
//                                                @Param("articleTypeId") Integer articleTypeId );

}

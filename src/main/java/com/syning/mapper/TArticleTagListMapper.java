package com.syning.mapper;

import com.syning.entity.TArticleTagList;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.syning.vo.TagVO;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author jobob
 * @since 2022-06-14
 */
public interface TArticleTagListMapper extends BaseMapper<TArticleTagList> {

    /**
     *  通过文章id，获取不应该亮起的标签
     * @param articleId
     * @return
     */
    List<TagVO> getNoTagVOById(Integer articleId);

    /**
     *  通过文章id，获取应该亮起的标签
     * @param articleId
     * @return
     */
    List<TagVO> getUpTagVOById(Integer articleId);

    /**
     *  保存文章与标签之间的关系
     * @param list
     * @return
     */
    boolean saveAll(List<TArticleTagList> list);

}

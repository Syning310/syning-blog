package com.syning.service;

import com.syning.entity.TArticleTagList;
import com.baomidou.mybatisplus.extension.service.IService;
import com.syning.vo.TagVO;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author jobob
 * @since 2022-06-14
 */
public interface ITArticleTagListService extends IService<TArticleTagList> {

    boolean saveAll(List<TArticleTagList> list);

    List<TagVO> getUpTagVO(Integer article);

    List<TagVO> getNoTagVO(Integer article);

}

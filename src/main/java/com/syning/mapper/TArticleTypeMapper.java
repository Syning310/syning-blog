package com.syning.mapper;

import com.syning.entity.TArticleType;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.syning.vo.TArticleTypeVO;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author jobob
 * @since 2022-06-15
 */
public interface TArticleTypeMapper extends BaseMapper<TArticleType> {

    /**
     *  文章类型列表，包含文章数量
     */
    List<TArticleTypeVO> articleTypeList();
}

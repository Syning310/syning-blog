package com.syning.service;

import com.syning.entity.TArticleType;
import com.baomidou.mybatisplus.extension.service.IService;
import com.syning.vo.TArticleTypeVO;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author jobob
 * @since 2022-06-15
 */
public interface ITArticleTypeService extends IService<TArticleType> {

    List<TArticleTypeVO> articleTypeList();


}

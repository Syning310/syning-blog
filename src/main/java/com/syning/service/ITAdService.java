package com.syning.service;

import com.syning.entity.TAd;
import com.baomidou.mybatisplus.extension.service.IService;
import com.syning.vo.AdVO;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author jobob
 * @since 2022-06-14
 */
public interface ITAdService extends IService<TAd> {

    List<AdVO> getAdVOList(Integer adTypeId);

}

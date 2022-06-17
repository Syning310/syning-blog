package com.syning.mapper;

import com.syning.entity.TAd;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.syning.vo.AdVO;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author jobob
 * @since 2022-06-14
 */
public interface TAdMapper extends BaseMapper<TAd> {

    /**
     *  返回 AdVO 列表
     * @return
     */
    List<AdVO>  getAdVOList(Integer adTypeId);

}

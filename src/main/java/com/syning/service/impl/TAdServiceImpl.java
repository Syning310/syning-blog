package com.syning.service.impl;

import com.syning.entity.TAd;
import com.syning.mapper.TAdMapper;
import com.syning.service.ITAdService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.syning.vo.AdVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author jobob
 * @since 2022-06-14
 */
@Service
public class TAdServiceImpl extends ServiceImpl<TAdMapper, TAd> implements ITAdService {

    @Resource
    private TAdMapper adMapper;

    /**
     *  返回 AdVO 列表
     * @return
     */
    @Override
    public List<AdVO> getAdVOList(Integer adTypeId) {
        List<AdVO> adVOList = adMapper.getAdVOList(adTypeId);

        return adVOList;
    }

}

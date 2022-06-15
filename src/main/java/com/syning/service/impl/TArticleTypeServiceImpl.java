package com.syning.service.impl;

import com.syning.entity.TArticleType;
import com.syning.mapper.TArticleTypeMapper;
import com.syning.service.ITArticleTypeService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.syning.vo.TArticleTypeVO;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author jobob
 * @since 2022-06-15
 */
@Service
public class TArticleTypeServiceImpl extends ServiceImpl<TArticleTypeMapper, TArticleType> implements ITArticleTypeService {

    @Resource
    private TArticleTypeMapper articleTypeMapper;


    @Override
    public List<TArticleTypeVO> articleTypeList() {

        List<TArticleTypeVO> articleTypeVOList = articleTypeMapper.articleTypeList();

        return articleTypeVOList;
    }



}

package com.syning.service.impl;

import com.syning.entity.TArticleTagList;
import com.syning.mapper.TArticleTagListMapper;
import com.syning.service.ITArticleTagListService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.syning.vo.TagVO;
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
public class TArticleTagListServiceImpl extends ServiceImpl<TArticleTagListMapper, TArticleTagList> implements ITArticleTagListService {

    @Resource
    private TArticleTagListMapper articleTagListMapper;


    @Override
    public List<TagVO> getUpTagVO(Integer article) {
        return articleTagListMapper.getUpTagVOById(article);
    }

    @Override
    public List<TagVO> getNoTagVO(Integer article) {
        return articleTagListMapper.getNoTagVOById(article);
    }

    @Override
    public boolean saveAll(List<TArticleTagList> list) {
        return articleTagListMapper.saveAll(list);
    }
}

package com.syning.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.syning.entity.TArticleTag;
import com.syning.entity.TArticleTagList;
import com.syning.service.ITArticleTagListService;
import com.syning.service.ITArticleTagService;
import com.syning.utils.CommonResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/article")
public class ArticleTagController {

    @Autowired
    private ITArticleTagService articleTagService;

    @Autowired
    private ITArticleTagListService articleTagListService;

    /**
     * 删除文章标签
     * @param articleTagId  根据 id 删除
     * @return
     */
    @PostMapping("/tag/del")
    @ResponseBody
    public CommonResult articleTagDel(Integer articleTagId) {

        // 检查该标签有没有被文章使用
        LambdaQueryWrapper<TArticleTagList> eqArticleTagId =
                Wrappers.<TArticleTagList>lambdaQuery().eq(TArticleTagList::getArticleTagListId, articleTagId);
        int usedCount = articleTagListService.count(eqArticleTagId);

        // 如果有被使用过，则不能删除该标签
        if (usedCount > 0) {
            return CommonResult.failed("该标签和文章有关联，请先删除关联");
        }

        boolean delBool = articleTagService.removeById(articleTagId);

        if (delBool) {
            return CommonResult.success("删除成功!");
        }
        return CommonResult.failed("删除失败!");
    }




    /**
     *  修改文章标签名
     * @param articleTag    根据 id 修改
     * @return
     */
    @PostMapping("/tag/update")
    @ResponseBody
    public CommonResult articleTagUpdate(TArticleTag articleTag) {

        boolean updateBool = articleTagService.updateById(articleTag);

        if (updateBool) {
            return CommonResult.success("修改成功!");
        }
        return CommonResult.failed("修改失败!");
    }



    /**
     *  添加文章标签
     * @param articleTag
     * @return
     */
    @PostMapping("/tag/add")
    @ResponseBody
    public CommonResult articleTagAdd(TArticleTag articleTag) {

        // 设置创建时间
        LocalDateTime now = LocalDateTime.now();
        articleTag.setArticleTagAddTime(now);

        boolean saveBool = articleTagService.save(articleTag);

        if (saveBool) {
            return CommonResult.success("添加成功!");
        }

        return CommonResult.success("添加失败!");
    }



    /**
     *  文章标签列
     * @param model
     * @return
     */
    @GetMapping("/tag/list")
    public String tagList(Model model) {

        // 设置条件，按照创建标签的时间排序，后添加的排在前面
        LambdaQueryWrapper<TArticleTag> ruleWraps =
                Wrappers.<TArticleTag>lambdaQuery().orderByDesc(TArticleTag::getArticleTagAddTime);

        List<TArticleTag> articleTagList = articleTagService.list(ruleWraps);


        model.addAttribute("articleTagList", articleTagList);

        return "admin/articleTagList";
    }


}

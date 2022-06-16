package com.syning.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.syning.dto.article.ArticlePageDTO;
import com.syning.service.ITArticleService;
import com.syning.utils.CommonPage;
import com.syning.utils.CommonResult;
import com.syning.vo.ArticleVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@RequestMapping("/article")
@Controller
public class ArticleController {

    @Resource
    private ITArticleService articleService;


    /**
     *  根据文章id删除文章
     * @param articleId
     * @return
     */
    @ResponseBody
    @PostMapping("/del")
    public CommonResult articleDel(Integer articleId) {

        boolean removeBool = articleService.removeById(articleId);

        if (removeBool) {
            return CommonResult.success("删除成功!");
        } else {
            return CommonResult.failed("删除失败!");
        }
    }



    /**
     *  显示给视图，文章列表
     * @param articlePageDTO
     * @param model
     * @return
     */
    @GetMapping("/list")
    public String articleList(ArticlePageDTO articlePageDTO, Model model) {

        IPage<ArticleVO> articlePage =
                new Page<>(articlePageDTO.getPageNumber(), articlePageDTO.getPageSize());

        IPage<ArticleVO> articleIPage = articleService.articleList(articlePage, articlePageDTO.getArticleTitle());

        model.addAttribute("articleIPage", CommonPage.restPage(articleIPage));


        model.addAttribute("articleTitle", articlePageDTO.getArticleTitle());

        return "admin/articleList";
    }



}

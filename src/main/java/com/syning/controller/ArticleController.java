package com.syning.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.syning.dto.article.ArticlePageDTO;
import com.syning.entity.Admin;
import com.syning.entity.TArticle;
import com.syning.service.ITArticleService;
import com.syning.service.ITArticleTypeService;
import com.syning.utils.CommonPage;
import com.syning.utils.CommonResult;
import com.syning.vo.ArticleVO;
import com.syning.vo.TArticleTypeVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Slf4j
@RequestMapping("/article")
@Controller
public class ArticleController {

    @Resource
    private ITArticleService articleService;

    @Resource
    private ITArticleTypeService articleTypeService;

    @PostMapping("/saveArticle")
    @ResponseBody
    public CommonResult saveArticle(@RequestBody ArticleVO article, HttpSession session) {
//        log.info("**********{}", article);

        // 获取当前登录的用户
        Admin admin = (Admin)session.getAttribute(AdminController.USER);
        // 设置发布用户的id
        article.setUserId(admin.getId());
        article.setArticleAddTime(LocalDateTime.now());

        CommonResult result = articleService.saveArticle(article);

        return result;
    }


    @GetMapping("/publish")
    public String publishArticle(Model model) {

        // 这里取得数据库中的 t_article_type 额外取得各个类型的文章数量
        List<TArticleTypeVO> articleTypeVOList = articleTypeService.articleTypeList();

        // 放入数据模型中
        model.addAttribute("typeList", articleTypeVOList);


        return "user/publishActicle";
    }




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

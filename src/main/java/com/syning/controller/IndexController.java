package com.syning.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.syning.dto.article.ArticlePageDTO;

import com.syning.dto.article.ArticleTypeDTO;
import com.syning.entity.TArticleType;
import com.syning.entity.TUser;
import com.syning.service.ITArticleService;
import com.syning.service.ITArticleTagService;
import com.syning.service.ITArticleTypeService;
import com.syning.service.ITUserService;
import com.syning.utils.CommonPage;
import com.syning.vo.AdVO;
import com.syning.vo.ArticleVO;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Objects;

@Controller
public class IndexController {

    @Resource
    private ITArticleService articleService;

    @Resource
    private ITArticleTagService articleTagService;

    @Resource
    private ITUserService userService;

    @Resource
    private ITArticleTypeService articleTypeService;






    // 显示首页
    @GetMapping(value = "/")
    public String userIndex(Model model, ArticlePageDTO articlePageDTO, ArticleTypeDTO articleTypeDTO) {

//        // 系统信息
//        OsInfo osInfo = SystemUtil.getOsInfo();
//        HostInfo hostInfo = SystemUtil.getHostInfo();
//        model.addAttribute("osName", osInfo.getName());
//        model.addAttribute("hostAddress", hostInfo.getAddress());
//
//        // 文章数量
//        int articleCount = articleService.count();
//        int articleTagCount = articleTagService.count();
//        model.addAttribute("articleCount", articleCount);
//        model.addAttribute("articleTagCount", articleTagCount);
//
//
//        // 用户数量
//        int userCount = userService.count();
//        model.addAttribute("userCount", userCount);



        IPage<ArticleVO> articlePage
                = new Page<>(articlePageDTO.getPageNumber(), 8);    // 每页8条数据


        IPage<ArticleVO> articleVOIPage
                = articleService.articleList(articlePage, articlePageDTO.getArticleTitle(), articleTypeDTO.getArticleTypeId());



        // 获取所有的文章类型
        List<TArticleType> articleTypeList = articleTypeService.list();

        model.addAttribute("articlePage", CommonPage.restPage(articleVOIPage));

        model.addAttribute("articleTitle", articlePageDTO.getArticleTitle());

        model.addAttribute("articleTypeDTO", articleTypeDTO);

        model.addAttribute("articleTypeList", articleTypeList);

        return "admin/index";
    }










    // 测试接收 AdVO
    @PostMapping("/advo/test")
    @ResponseBody
    public AdVO vo(AdVO adVO,
                   @RequestParam(value = "beginTime", required = false) String beginTime,
                   @RequestParam(value = "endTime", required = false)String endTime) {

        DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");

        LocalDateTime begin = LocalDateTime.parse(beginTime, dateTimeFormatter);
        LocalDateTime end = LocalDateTime.parse(endTime, dateTimeFormatter);

        System.out.println("开始时间 = " + begin);
        System.out.println("结束时间时间 = " + end);



        return adVO;
    }








    // 测试
    @GetMapping("/getuser")
    @ResponseBody
    public List<TUser> getUser() {
        List<TUser> users = userService.list();
        return users;
    }


    @GetMapping("/index")
    @ResponseBody
    public String index() {
        return "hello world";
    }

}

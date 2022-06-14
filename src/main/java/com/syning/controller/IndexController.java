package com.syning.controller;

import cn.hutool.system.HostInfo;
import cn.hutool.system.OsInfo;
import cn.hutool.system.SystemUtil;
import com.syning.entity.TUser;
import com.syning.service.ITArticleService;
import com.syning.service.ITArticleTagService;
import com.syning.service.ITUserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@Controller
public class IndexController {

    @Resource
    private ITArticleService articleService;

    @Resource
    private ITArticleTagService articleTagService;

    @Resource
    private ITUserService userService;


    // 显示首页
    @GetMapping(value = "/")
    public String userIndex(Model model) {

        // 系统信息
        OsInfo osInfo = SystemUtil.getOsInfo();
        HostInfo hostInfo = SystemUtil.getHostInfo();
        model.addAttribute("osName", osInfo.getName());
        model.addAttribute("hostAddress", hostInfo.getAddress());

        // 文章数量
        int articleCount = articleService.count();
        int articleTagCount = articleTagService.count();
        model.addAttribute("articleCount", articleCount);
        model.addAttribute("articleTagCount", articleTagCount);


        // 用户数量
        int userCount = userService.count();
        model.addAttribute("userCount", userCount);


        return "admin/index";
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

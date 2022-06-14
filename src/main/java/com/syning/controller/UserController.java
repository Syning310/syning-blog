package com.syning.controller;


import cn.hutool.core.util.StrUtil;
import cn.hutool.system.HostInfo;
import cn.hutool.system.OsInfo;
import cn.hutool.system.SystemUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.syning.dto.user.UserListPageDTO;
import com.syning.entity.TArticle;
import com.syning.entity.TUser;
import com.syning.service.ITArticleService;
import com.syning.service.ITUserService;
import com.syning.utils.CommonPage;
import com.syning.utils.CommonResult;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping(value = "/user")
public class UserController {

    @Resource
    private ITUserService userService;

    @Resource
    private ITArticleService articleService;


    /**
     *  删除用户
     * @param userId
     * @return
     */
    @PostMapping("/del")
    @ResponseBody
    public CommonResult userDel(String userId) {

        if (StrUtil.isBlank(userId)) {
            return CommonResult.failed("参数错误！请刷新页面重试");
        }


        // 删除用户之前查询该用户有无文章，如果有无法删除
        LambdaQueryWrapper<TArticle> eqWarpper =
                Wrappers.<TArticle>lambdaQuery().eq(TArticle::getUserId, userId);

        int articleCount = articleService.count(eqWarpper);

        if (articleCount > 0) {
            return CommonResult.failed("改用户有文章，无法删除！");
        }

        boolean removeBool = userService.removeById(userId);

        if (removeBool) {
            return CommonResult.success("删除成功");
        }

        return CommonResult.failed("删除失败");
    }


    /**
     *  显示分页
     * @param userListPageDTO
     * @param model
     * @return
     */
    @RequestMapping(value = "/list")
    public String userList(UserListPageDTO userListPageDTO, Model model) {

        // 获取页码和显示条数
        Integer pageNumber = userListPageDTO.getPageNumber();
        Integer pageSize = userListPageDTO.getPageSize();

        // 获取页面传来的 userName 作为查询条件
        String userName = userListPageDTO.getUserName();

        // 分页插件
        IPage<TUser> userPage = new Page<>(pageNumber, pageSize);

        // 按照创建时间进行排序
        LambdaQueryWrapper<TUser> userLambdaQueryWrapper =  Wrappers.<TUser>lambdaQuery().orderByDesc(TUser::getUserRegisterTime);


        // 如果前台有传输 userName 来做查询
        if (StrUtil.isNotBlank(userName)) {
            userLambdaQueryWrapper.like(TUser::getUserName, userName);
            model.addAttribute("userName", userName);
        }


        // 获取分页查询的数据
        IPage<TUser> userIPage = userService.page(userPage, userLambdaQueryWrapper);


        model.addAttribute("userPage", CommonPage.restPage(userIPage));

        return "admin/userList";
    }



}

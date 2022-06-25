package com.syning.controller;



import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.syning.entity.TUser;
import com.syning.service.ITUserService;
import com.syning.utils.CommonResult;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {

    public static final String USER = "user";

    @Resource
    private ITUserService userService;


    /**
     *  修改密码
     * @param user
     * @return
     */
    @PostMapping("/resetPassword")
    @ResponseBody
    public CommonResult updatePassword(TUser user) {

        LambdaQueryWrapper<TUser> eqWrapper = Wrappers.<TUser>lambdaQuery().eq(TUser::getUserName, user.getUserName());

        TUser u = userService.getOne(eqWrapper);

        if (u == null) {
            return CommonResult.failed("用户不存在!!!");
        }

        boolean updateBool = userService.update(user, eqWrapper);

        if (updateBool) {
            return CommonResult.success("修改成功!");
        } else {
            return CommonResult.failed("修改失败!");
        }
    }




    /**
     *  登录验证，现在登录验证交给 Spring Security 处理了
     * @param session
     * @param admin
     * @return
     */
    /*@PostMapping("/verify")
    @ResponseBody
    public CommonResult verify(HttpSession session, Admin admin) {

        boolean verifyBool = adminService.verify(admin);

        if (verifyBool) {
            session.setAttribute(USER, admin);

            return CommonResult.success("登录成功!");
        } else {
            return CommonResult.failed("登陆失败!");
        }


    }*/





    /**
     *  退出登录
     * @param session
     * @return
     */
    //@GetMapping("/loginout")
    public String logout(HttpSession session) {

        // 废弃session
        session.invalidate();

        return "redirect:/admin/login";
    }


}

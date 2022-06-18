package com.syning.controller;



import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.syning.entity.Admin;
import com.syning.service.AdminService;
import com.syning.utils.CommonResult;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    public static final String USER = "user";

    @Resource
    private AdminService adminService;


    /**
     *  修改密码
     * @param admin
     * @return
     */
    @PostMapping("/resetPassword")
    @ResponseBody
    public CommonResult updatePassword(Admin admin) {

        LambdaQueryWrapper<Admin> eqWrapper = Wrappers.<Admin>lambdaQuery().eq(Admin::getAdminName, admin.getAdminName());
        List<Admin> admins = adminService.list(eqWrapper);

        if (admins.isEmpty() || admins.size() == 0) {
            return CommonResult.failed("用户不存在!!!");
        }

        Admin adm = admins.get(0);

        boolean updateBool = adminService.update(eqWrapper);

        if (updateBool) {
            return CommonResult.success("修改成功!");
        } else {
            return CommonResult.failed("修改失败!");
        }
    }


    /**
     *  登录验证
     * @param session
     * @param admin
     * @return
     */
    @PostMapping("/verify")
    @ResponseBody
    public CommonResult verify(HttpSession session, Admin admin) {

        boolean verifyBool = adminService.verify(admin);

        if (verifyBool) {
            session.setAttribute(USER, admin);

            return CommonResult.success("登录成功!");
        } else {
            return CommonResult.failed("登陆失败!");
        }


    }


    /**
     *  退出登录
     * @param session
     * @return
     */
    @GetMapping("/loginout")
    public String logout(HttpSession session) {

        // 废弃session
        session.invalidate();

        return "redirect:/";
    }


}

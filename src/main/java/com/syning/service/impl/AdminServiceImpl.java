package com.syning.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.syning.mapper.AdminMapper;
import com.syning.entity.Admin;
import com.syning.service.AdminService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Objects;

/**
 * (Admin)表服务实现类
 *
 * @author makejava
 * @since 2022-06-17 19:06:10
 */
@Service("adminService")
public class AdminServiceImpl extends ServiceImpl<AdminMapper, Admin> implements AdminService {

    @Resource
    private AdminMapper adminMapper;


    @Override
    public boolean verify(Admin admin) {

        LambdaQueryWrapper<Admin> eqWrapper = Wrappers.<Admin>lambdaQuery().eq(Admin::getAdminName, admin.getAdminName());

        List<Admin> adminList = super.list(eqWrapper);

        if (adminList == null || adminList.size() == 0) {
            return false;
        }

        // 取出
        Admin adminDB = adminList.get(0);

        admin.setId(adminDB.getId());

        // 拿数据库的用户的密码与视图输入的对比
        return Objects.equals(admin.getAdminPassword(), adminDB.getAdminPassword());
    }
}


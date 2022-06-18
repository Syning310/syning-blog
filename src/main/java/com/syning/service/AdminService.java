package com.syning.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.syning.entity.Admin;

/**
 * (Admin)表服务接口
 *
 * @author makejava
 * @since 2022-06-17 19:06:10
 */
public interface AdminService extends IService<Admin> {

    boolean verify(Admin admin);

}


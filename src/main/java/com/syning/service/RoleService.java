package com.syning.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.syning.entity.Role;
import com.syning.entity.TUser;

import java.util.List;

public interface RoleService extends IService<Role> {

    List<Role> getListByUserId(Integer userId);

    List<Role> getListByUserName(String userName);

}

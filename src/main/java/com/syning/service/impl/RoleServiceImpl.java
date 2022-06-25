package com.syning.service.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.syning.entity.Role;
import com.syning.entity.TUser;
import com.syning.mapper.RoleMapper;
import com.syning.service.RoleService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("roleService")
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {

    @Resource
    private RoleMapper roleMapper;

    @Override
    public List<Role> getListByUserName(String userName) {
        return roleMapper.getRoleList(userName);
    }

    @Override
    public List<Role> getListByUserId(Integer userId) {


        return roleMapper.getListByUserId(userId);
    }
}

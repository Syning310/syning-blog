package com.syning.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.syning.entity.Role;
import com.syning.entity.TUser;

import java.util.List;

public interface RoleMapper extends BaseMapper<Role> {

    /**
     *  传入 userName，返回它的所有角色
     * @param userName
     * @return
     */
    List<Role> getRoleList(String userName);


    /**
     *  通过 userId 获取角色，该用户应有的角色
     * @param userId
     * @return
     */
    List<Role> getListByUserId(Integer userId);

}

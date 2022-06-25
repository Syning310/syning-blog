package com.syning.security.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.syning.entity.Role;
import com.syning.entity.TUser;
import com.syning.service.ITUserService;
import com.syning.service.RoleService;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Component
public class MyUserDetailsService implements UserDetailsService {

    @Resource
    private ITUserService userService;

    @Resource
    private RoleService roleService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        // 通过用户名，从数据库中获取用户信息
        LambdaQueryWrapper<TUser> wrapper = Wrappers.lambdaQuery();
        wrapper.eq(TUser::getUserName, username);

        TUser u = userService.getOne(wrapper);

        if (u == null) {
            throw new UsernameNotFoundException("用户不存在......");
        }

        // 从数据库中读取该用户的角色
        List<Role> roleList = roleService.getListByUserId(u.getUserId());

        // 角色集合
        List<GrantedAuthority> auths = new ArrayList<>();

        // 角色必须以 Role_ 开头，数据库中没有则在这里添加
        for (Role r : roleList) {
            SimpleGrantedAuthority simpleAuth = new SimpleGrantedAuthority("ROLE_" + r.getRoleName());
            auths.add(simpleAuth);
        }


        // Security 管理的主体
        User user = new User(u.getUserName(),
                new BCryptPasswordEncoder().encode(u.getUserPassword()),
                auths);

        return user;
    }
}

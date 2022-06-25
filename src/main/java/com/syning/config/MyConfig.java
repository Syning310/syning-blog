package com.syning.config;

import com.syning.interceptor.LoginInterceptor;
import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import javax.annotation.Resource;


@Configuration(proxyBeanMethods = false)
public class MyConfig implements WebMvcConfigurer {

    @Resource
    private LoginInterceptor loginInterceptor;

//    @Override
//    public void addInterceptors(InterceptorRegistry registry) {
//        // 注释拦截器，改用 Security
//        registry.addInterceptor(loginInterceptor)
//                .addPathPatterns("/**")
//                // 排除访问 静态、登录请求、登录页面、退出登录、修改密码
//                .excludePathPatterns("/res/**", "/admin/verify", "/admin/login", "/admin/loginout", "/admin/resetPassword");
//    }


    @Override
    public void addViewControllers(ViewControllerRegistry registry) {

        registry.addViewController("/admin/login").setViewName("admin/login");

        registry.addViewController("/unauth").setViewName("error/unauth");



    }
}

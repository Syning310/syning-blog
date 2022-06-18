package com.syning.config;

import com.syning.interceptor.LoginInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration(proxyBeanMethods = false)
public class MyConfig implements WebMvcConfigurer {


    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns("/**")
                // 排除访问 静态、登录请求、登录页面、退出登录、修改密码
                .excludePathPatterns("/res/**", "/admin/verify", "/admin/login", "/admin/loginout", "/admin/resetPassword");
    }


    @Override
    public void addViewControllers(ViewControllerRegistry registry) {

        registry.addViewController("/admin/login").setViewName("admin/login");
    }
}

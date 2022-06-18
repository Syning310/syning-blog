package com.syning.interceptor;


import com.syning.controller.AdminController;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * 登录拦截器
 * <p>
 * 1、配置好要拦截哪些请求
 * 2、在配置类中把拦截器注册到容器中
 */
public class LoginInterceptor implements HandlerInterceptor {


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        // 检查登录逻辑
        HttpSession session = request.getSession();

        Object user = session.getAttribute(AdminController.USER);

        // 如果会话中存在user，说明已经登录，直接放行
        if (user != null) {
            return true;
        }

        // 拦截，未登录，跳转到登录页面
        request.getRequestDispatcher("/admin/login").forward(request, response);
        return false;

    }


    // 控制器方法之后，页面渲染之前
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        HandlerInterceptor.super.postHandle(request, response, handler, modelAndView);
    }


    // 页面渲染之后
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
    }
}

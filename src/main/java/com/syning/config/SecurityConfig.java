package com.syning.config;


import com.syning.security.service.MyUserDetailsService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Bean;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@Slf4j
@EnableGlobalMethodSecurity(securedEnabled = true, prePostEnabled = true)
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    /**
     * 加载 User 的方法
     */
    @Resource
    private MyUserDetailsService userDetailsService;

    @Override
    protected void configure(HttpSecurity http) throws Exception {

        // 403无权限进入
        http.exceptionHandling().accessDeniedHandler(new AccessDeniedHandler() {
            /**
             *  判断当前请求是 Ajax 请求，还是同步的 Http 请求
             * @param request
             * @param response
             * @param accessDeniedException
             * @throws IOException
             * @throws ServletException
             */
            @Override
            public void handle(HttpServletRequest request, HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {

                // 1、获取请求头
                String accept = request.getHeader("Accept");
                String xRequestHeader = request.getHeader("X-Requested-With");

                if ((accept != null && accept.contains("application/json"))
                        || (xRequestHeader != null && xRequestHeader.equals("XMLHttpRequest"))) {
//                    log.info("***** {} 该请求是 ajax 请求", request.getRequestURL());
                    response.setContentType("application/json;charset=utf-8");
                    PrintWriter out = response.getWriter();
                    out.write("{\"code\":\"403\",\"message\":\"没有权限！\"}");
                    out.flush();
                    out.close();

                } else {
//                    log.info("***** {} 该请求是同步请求", request.getRequestURL());
                    response.sendRedirect("/unauth");
                }



            }
        });

        // 表单登录相关设置
        http.formLogin()
                .usernameParameter("user")
                .passwordParameter("password")
                .loginPage("/admin/login")              // 跳转登录页面的url
                .loginProcessingUrl("/admin/verify")    // 提交登录验证的url
                //.defaultSuccessUrl("/")                 // 登录成功后跳转的url
                .successHandler(new AuthenticationSuccessHandler() {
                    @Override
                    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
                        response.setContentType("application/json;charset=utf-8");
                        PrintWriter out = response.getWriter();
                        out.write("{\"code\":\"200\",\"message\":\"登录成功\"}");
                        out.flush();
                        out.close();
                    }
                })

//                .failureForwardUrl("/admin/loginFail")  // 登录失败跳转的url
                .failureHandler(new AuthenticationFailureHandler() {
                    @Override
                    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
                        response.setContentType("application/json;charset=utf-8");
                        PrintWriter out = response.getWriter();
                        out.write("{\"code\":\"1000\",\"message\":\"登录失败\"}");
                        out.flush();
                        out.close();
                    }
                })
                .permitAll()    // 以上路径都许可访问
        ;


        http.logout().logoutUrl("/logout")          // 退出登录提交的url
                .logoutSuccessUrl("/admin/login");  // 退出登录成功后，重定向的url

        // 首页所有人都可以访问
        http.authorizeRequests().antMatchers("/").permitAll();
        // 静态资源所有人都可以访问
        http.authorizeRequests().antMatchers("/res/**").permitAll();
//        http.authorizeRequests().antMatchers("//cdn**").permitAll();


        http
                .authorizeRequests().antMatchers("/article/**").hasRole("普通用户")      // 访问文章相关的请求，需要管理员角色
                .antMatchers("/ad/**").hasRole("普通用户")  // 访问广告相关的请求，需要管理员角色


                .anyRequest().authenticated()      // 访问任何请求都需要鉴权认证
        ;

        http.csrf().disable();  // 关闭 csrf
    }


    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {

        auth
                .userDetailsService(userDetailsService)     // 从数据库中读取的身份认证
                .passwordEncoder(passwordEncoder());        // 用户加密的规则
    }


    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

}

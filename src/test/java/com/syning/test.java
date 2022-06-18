package com.syning;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.LineCaptcha;
import cn.hutool.core.io.resource.ClassPathResource;
import com.syning.entity.TUser;
import com.syning.service.ITUserService;
import org.apache.ibatis.annotations.Param;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import javax.sql.DataSource;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@SpringBootTest
public class test {

    @Resource
    DataSource dataSource;

    @Test
    public void testDatasource() {

        System.out.println(dataSource.getClass());

    }


    @Resource
    private ITUserService userService;

    void contextLoads() {



    }


    @Test
    void testLocalDateTime() {

        LocalDateTime time = LocalDateTime.now();

        System.out.println(time.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));


    }


    ThreadLocal local = new ThreadLocal();

    @Test
    public void getCaptcha() {
        // 定义图形验证码的长和宽
        LineCaptcha lineCaptcha = CaptchaUtil.createLineCaptcha(200, 100);

        // 图形验证码写出，可以写到文件，也可以写到流中
        String code = lineCaptcha.getCode();

        local.set(code);

        String c = (String)local.get();
        System.out.println(c);


        String path = new ClassPathResource("static/img").getFile().getPath();
        System.out.println(path);

    }


    @Test
    public void listRemove() {

        List<Integer> list1 = new ArrayList<>();
        List<Integer> list2 = new ArrayList<>();

        list1.add(1);
        list1.add(2);
        list1.add(3);
        list1.add(4);
        list1.add(5);

        list2.add(2);
        list2.add(3);


        list1.removeAll(list2);
        System.out.println(list1);

    }

}

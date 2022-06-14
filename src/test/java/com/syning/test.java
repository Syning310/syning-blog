package com.syning;

import com.syning.entity.TUser;
import com.syning.service.ITUserService;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import javax.sql.DataSource;

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



}

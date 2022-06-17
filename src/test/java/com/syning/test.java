package com.syning;

import com.syning.entity.TUser;
import com.syning.service.ITUserService;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.annotation.Resource;
import javax.sql.DataSource;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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

}

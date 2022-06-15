package com.syning.dto.user;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class UserDTO {

    /**
     *  用户id
     */
    private Integer userId;

    /**
     *  用户名
     */
    private String userName;

    /**
     *  用户密码
     */
    private String userPassword;



}

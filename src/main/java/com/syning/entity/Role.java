package com.syning.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@AllArgsConstructor
@NoArgsConstructor
@Data
@TableName("role")
public class Role implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     *  角色表中的id
     */
    private Integer roleId;

    /**
     *  角色名
     */
    private String roleName;


}

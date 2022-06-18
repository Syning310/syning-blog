package com.syning.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.extension.activerecord.Model;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * (Admin)表实体类
 *
 * @author makejava
 * @since 2022-06-17 19:06:10
 */
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Admin extends Model<Admin>  implements Serializable {

    private static final long serialVersionUID = 1L;

    //id
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    //管理员名称
    private String adminName;
    //管理员密码
    private String adminPassword;






}


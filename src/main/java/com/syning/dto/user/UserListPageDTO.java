package com.syning.dto.user;


import com.syning.dto.base.BasePageDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class UserListPageDTO extends BasePageDTO {

    /**
     *  用户名
     */
    private String userName;


}

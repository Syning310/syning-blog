package com.syning.dto.base;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BasePageDTO {

    /**
     *  当前页码，默认 1
     */
    @NotNull(message = "未获取到当前页码")
    private Integer pageNumber = 1;

    /**
     *  每页显示多少条数据，默认 20
     */
    private Integer pageSize = 5;


}

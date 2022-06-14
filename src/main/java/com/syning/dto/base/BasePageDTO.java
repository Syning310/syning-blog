package com.syning.dto.base;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class BasePageDTO {

    /**
     *  当前页码，默认 1
     */
    private Integer pageNumber = 1;

    /**
     *  每页显示多少条数据，默认 20
     */
    private Integer pageSize = 5;


}

package com.syning.dto.article;

import com.syning.dto.base.BasePageDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@AllArgsConstructor
@NoArgsConstructor
@Data
public class ArticlePageDTO extends BasePageDTO {

    /**
     *  文章标题
     */
    private String articleTitle;



}

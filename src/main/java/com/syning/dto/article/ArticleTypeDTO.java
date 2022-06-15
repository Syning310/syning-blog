package com.syning.dto.article;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.syning.utils.AddArticleInterface;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;


@AllArgsConstructor
@NoArgsConstructor
@Data
public class ArticleTypeDTO {

    /**
     * 文章分类id
     */
    private Integer articleTypeId;


    /**
     * 文章分类名称
     */
    private String articleTypeName;

    /**
     * 分类排序，越小排前面
     */
    private Integer articleTypeSort;



}

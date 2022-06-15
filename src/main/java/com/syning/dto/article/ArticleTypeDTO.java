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
    @NotBlank(message = "文章分类名称 不能为空", groups = {AddArticleInterface.class})
    private String articleTypeName;

    /**
     * 分类排序，越小排前面
     */
    @NotBlank(message = "文章分类排序 不能为空", groups = {AddArticleInterface.class})
    private Integer articleTypeSort;



}

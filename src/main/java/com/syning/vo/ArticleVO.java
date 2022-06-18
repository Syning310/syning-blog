package com.syning.vo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ArticleVO implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 文章id
     */
    private Integer articleId;

    /**
     * 发布用户id
     */
    private Integer userId;

    /**
     *  发布用户名
     */
    private String userName;

    /**
     * 文章标题
     */
    @JsonProperty(value = "articleTitle")
    private String articleTitle;

    /**
     * 创建时间
     */
    private LocalDateTime articleAddTime;

    /**
     * 文章内容
     */
    @JsonProperty(value = "articleCentext")
    private String articleCentext;

    /**
     * 点赞次数
     */
    private Integer articleGoodNumber;

    /**
     * 观看次数
     */
    private Integer articleLookNumber;

    /**
     * 收藏次数
     */
    private Integer articleCollectionNumber;

    /**
     * 文章类型id
     */
    private Integer articleTypeId;

    /**
     *  文章类型名称
     */
    @JsonProperty(value = "articleTypeName")
    private String articleTypeName;


}

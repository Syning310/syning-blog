package com.syning.controller;



import com.syning.dto.article.ArticleTypeDTO;
import com.syning.entity.TArticleType;
import com.syning.service.ITArticleTypeService;
import com.syning.utils.CommonResult;
import com.syning.vo.TArticleTypeVO;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;


@RequestMapping("/article")
@Controller
public class ArticleTypeController {

    @Resource
    private ITArticleTypeService articleTypeService;


    /**
     *  根据视图传来的id，删除articleType数据
     * @param articleTypeId
     * @return
     */
    @PostMapping("/type/del")
    @ResponseBody
    public CommonResult articleTypeDel(Integer articleTypeId) {

        boolean delBool = articleTypeService.removeById(articleTypeId);

        if (delBool) {
            return CommonResult.success("删除成功!");
        }
        return CommonResult.success("删除失败!");
    }



    /**
     *  添加文章类型
     * @param articleTypeDTO
     * @return
     */
    @PostMapping("/type/add")
    @ResponseBody
    public CommonResult articleTypeAdd(ArticleTypeDTO articleTypeDTO) {
        TArticleType articleType = new TArticleType();

        // 将视图传来的对象，属性拷贝给 articleType
        BeanUtils.copyProperties(articleTypeDTO, articleType);

        // 设置时间
        articleType.setArticleTypeAddTime(LocalDateTime.now());

        boolean saveBool = articleTypeService.save(articleType);

        if (saveBool) {
            return CommonResult.success("保存成功!");
        }

        return CommonResult.success("保存失败!");
    }


    /**
     *  修改文章的类型
     * @param articleTypeDTO
     * @return
     */
    @PostMapping("/type/update")
    @ResponseBody
    public CommonResult articleTypeypeUpdate(ArticleTypeDTO articleTypeDTO) {

        TArticleType articleType = new TArticleType();

        // 将视图传来的对象，属性拷贝给 articleType
        BeanUtils.copyProperties(articleTypeDTO, articleType);

        // 按id修改，返回是否修改成功
        boolean updateBool = articleTypeService.updateById(articleType);

        if (updateBool) {
            return CommonResult.success("修改成功!");
        }

        return CommonResult.failed("修改失败!");
    }




    /**
     *  文章类型列表，包含文章数量
     * @param model
     * @return
     */
    @GetMapping("/type/list")
    public String articleTypeList(Model model) {

//        // 设置按照创建时间排序的条件
//        Wrapper<TArticleType> articleWrapper
//                = Wrappers.<TArticleType>lambdaQuery().orderByAsc(TArticleType::getArticleTypeAddTime);
//
//        // 得到列表
//        List<TArticleType> articleTypeList = articleTypeService.list(articleWrapper);


        // 这里取得数据库中的 t_article_type 额外取得各个类型的文章数量
        List<TArticleTypeVO> articleTypeVOList = articleTypeService.articleTypeList();


        // 放入数据模型中
        model.addAttribute("articleTypeList", articleTypeVOList);

        return "admin/articleTypeList";
    }






}

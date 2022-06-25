package com.syning.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.syning.entity.TAd;
import com.syning.entity.TAdType;
import com.syning.service.ITAdService;
import com.syning.service.ITAdTypeService;
import com.syning.utils.CommonResult;
import com.syning.vo.AdVO;
import org.springframework.beans.BeanUtils;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;


@RequestMapping("/ad")
@Controller
public class AdController {

    @Resource
    private ITAdTypeService adTypeService;

    @Resource
    private ITAdService adService;


    @Secured({"ROLE_管理员"})
    @PostMapping("/del")
    @ResponseBody
    public CommonResult delAd(@RequestParam("adId") Integer id) {

        boolean removeBool = adService.removeById(id);

        if (removeBool) {
            return CommonResult.success("删除成功!");
        } else {
            return CommonResult.failed("删除失败!");
        }

    }

    /**
     * 广告添加或修改
     */
    @Secured({"ROLE_管理员"})
    @PostMapping("/addOrUpdate")
    @ResponseBody
    public CommonResult adAddOrUpdate(AdVO adVO,
                                      @RequestParam("beginTime") String beginTime,
                                      @RequestParam("endTime") String endTime) {

        TAd ad = new TAd();
        BeanUtils.copyProperties(adVO, ad);

        if (beginTime != null && endTime != null) {
            // 转换成日期
            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");

            LocalDateTime begin = LocalDateTime.parse(beginTime, dateTimeFormatter);
            LocalDateTime end = LocalDateTime.parse(endTime, dateTimeFormatter);
            ad.setAdBeginTime(begin);
            ad.setAdEndTime(end);
        }


        Integer adId = adVO.getAdId();

        // 如果前端传来 id 为空，则说明是添加指令
        if (adId == null) {
            ad.setAdAddTime(LocalDateTime.now());
            boolean saveBool = adService.save(ad);
            if (saveBool) {
                return CommonResult.success("保存成功!");
            } else {
                return CommonResult.failed("保存失败!");
            }
        }

        // 前端传来的 id 不为空，说明是修改指令
        boolean updateBool = adService.updateById(ad);

        if (updateBool) {
            return CommonResult.success("修改成功!");
        } else {
            return CommonResult.failed("修改失败!");
        }
    }


    /**
     * 删除广告类型
     *
     * @param adTypeId
     * @return
     */
    @Secured({"ROLE_管理员"})
    @PostMapping("/type/del")
    @ResponseBody
    public CommonResult delAdType(Integer adTypeId) {

        LambdaQueryWrapper<TAd> eqWrapper = Wrappers.<TAd>lambdaQuery().eq(TAd::getAdType, adTypeId);
        int adCount = adService.count(eqWrapper);

        // 如果通过该类型的id，查询到了与之有关的文章，说明这个类型被关联，就不能删除
        if (adCount > 0) {
            return CommonResult.failed("请先删除与该类型关联的广告!");
        }

        boolean removeBool = adTypeService.removeById(adTypeId);

        if (removeBool) {
            return CommonResult.success("删除成功!");
        } else {
            return CommonResult.failed("删除失败!");
        }
    }

    /**
     * 广告类型，添加或者删除
     *
     * @param adType
     * @return
     */
    @Secured({"ROLE_管理员"})
    @PostMapping("/type/addOrUpdate")
    @ResponseBody
    public CommonResult adTypeAddOrUpdate(TAdType adType) {

        Integer adTypeId = adType.getAdTypeId();

        // 前端没有传入id，则说明是添加
        if (adTypeId == null) {
            // 添加
            adType.setAdTypeAddTime(LocalDateTime.now());
            boolean saveBool = adTypeService.save(adType);
            if (saveBool) {
                return CommonResult.success("添加成功!");
            } else {
                return CommonResult.failed("添加失败!");
            }
        }


        // 前端有传入id，说明是修改
        boolean updateBool = adTypeService.updateById(adType);

        if (updateBool) {
            return CommonResult.success("修改成功!");
        } else {

            return CommonResult.failed("修改失败!");
        }
    }


    /**
     * 跳转到广告页面
     *
     * @param model
     * @return
     */
    @GetMapping("/list")
    public String adTypeList(Model model, @RequestParam(value = "adTypeId", required = false) Integer adTypeId) {

        // 类型按照sort排序
        LambdaQueryWrapper<TAdType> typeWrapper =
                Wrappers.<TAdType>lambdaQuery().orderByAsc(TAdType::getAdTypeSort);
        List<TAdType> adTypeList = adTypeService.list(typeWrapper);

        model.addAttribute("adTypeList", adTypeList);

        // 广告按照sort排序
        List<AdVO> adVOList = adService.getAdVOList(adTypeId);
        model.addAttribute("adList", adVOList);

        return "admin/adList";
    }


}

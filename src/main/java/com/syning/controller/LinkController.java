package com.syning.controller;


import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.syning.entity.TLink;
import com.syning.service.ITLinkService;
import com.syning.utils.CommonResult;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;

@RequestMapping("/link")
@Controller
public class LinkController {

    @Resource
    private ITLinkService linkService;


    @PostMapping("/del")
    @ResponseBody
    public CommonResult linkDel(Integer linkId) {

        boolean removeBool = linkService.removeById(linkId);

        if (removeBool) {
            return CommonResult.success("删除成功!");
        } else {
            return CommonResult.failed("删除失败!");
        }
    }


    @PostMapping("/addLinkOrUpdate")
    @ResponseBody
    public CommonResult linkAddOrUpdate(TLink link) {

        // 如果前端有传linkId过来，说明这是修改
        Integer linkId = link.getLinkId();

        // 判断id是否为空，如果为空，则是添加
        if (linkId == null) {
            // 添加
            link.setLinkAddTime(LocalDateTime.now());
            boolean saveBool = linkService.save(link);
            if (saveBool) {
                return CommonResult.success("保存成功!");
            } else {
                return CommonResult.failed("保存失败!");
            }
        }


        // 前端视图有传过来id，说明这是条修改的指令
        boolean updateBool = linkService.updateById(link);

        if (updateBool) {
            return CommonResult.success("修改成功!");
        } else {
            return CommonResult.failed("修改失败!");
        }
    }


    /**
     * 显示友情链接链表页面
     *
     * @return
     */
    @GetMapping("/list")
    public String linkList(Model model) {

        LambdaQueryWrapper<TLink> wrapper =
                Wrappers.<TLink>lambdaQuery().orderByAsc(TLink::getLinkAddTime);

        List<TLink> linkList = linkService.list(wrapper);

        model.addAttribute("linkList", linkList);

        return "admin/linkList";
    }


}

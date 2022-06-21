package com.syning.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.syning.entity.Admin;
import com.syning.entity.TCommentReply;
import com.syning.service.ITCommentReplyService;
import com.syning.utils.CommonResult;
import com.syning.vo.ReplyVO;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;

@Controller
@RequestMapping("/reply")
public class ReplyController {


    @Resource
    private ITCommentReplyService commentReplyService;


    @PostMapping("/del")
    @ResponseBody
    public CommonResult delReply(Integer replyId) {

        boolean removeBool = commentReplyService.removeById(replyId);

        if (removeBool) {
            return CommonResult.success("删除成功!");
        } else {
            return CommonResult.failed(("删除失败!"));
        }

    }


    /**
     * 接收前端传来的数据，保存reply
     *
     * @param replyVO
     * @param session
     * @return
     */
    @PostMapping("/save")
    @ResponseBody
    public CommonResult saveReply(@RequestBody ReplyVO replyVO, HttpSession session) {

        TCommentReply reply = new TCommentReply();

        BeanUtils.copyProperties(replyVO, reply);

        Admin admin = (Admin) session.getAttribute(AdminController.USER);

        if (admin == null) {
            return CommonResult.failed("请先登录!");
        }

        reply.setReplyUserId(admin.getId());

        reply.setCommentReplyAddTime(LocalDateTime.now());

        boolean saveBool = commentReplyService.save(reply);

        if (saveBool) {
            return CommonResult.success("回复成功!");
        } else {
            return CommonResult.failed("回复失败!");
        }
    }


}

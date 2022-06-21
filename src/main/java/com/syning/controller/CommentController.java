package com.syning.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.syning.entity.Admin;
import com.syning.entity.TComment;
import com.syning.entity.TCommentReply;
import com.syning.service.ITCommentReplyService;
import com.syning.service.ITCommentService;
import com.syning.utils.CommonResult;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;

@Controller
@RequestMapping("/comment")
public class CommentController {

    @Resource
    private ITCommentService commentService;

    @Resource
    private ITCommentReplyService commentReplyService;


    @PostMapping("/del")
    @ResponseBody
    public CommonResult delComment(Integer commentId) {

        // 首先删除与这条评论有关的子回复
        LambdaQueryWrapper<TCommentReply> eqCommentIdWraps
                = Wrappers.<TCommentReply>lambdaQuery().eq(TCommentReply::getCommentId, commentId);
        commentReplyService.remove(eqCommentIdWraps);

        boolean removeBool = commentService.removeById(commentId);

        if (removeBool) {
            return CommonResult.success("删除成功!");
        } else {
            return CommonResult.failed("删除失败!");
        }


    }


    @ResponseBody
    @PostMapping("/save")
    public CommonResult saveComment(@RequestBody TComment comment, HttpSession session) {

        // 从会话域中取出用户的 id，就是当前评论的用户id
        // 创建添加时间
        Admin admin = (Admin)session.getAttribute(AdminController.USER);

        if (admin == null) {
            return CommonResult.failed("请先登录!");
        }


        comment.setUserId(admin.getId());
        comment.setCommentTime(LocalDateTime.now());

        boolean saveBool = commentService.save(comment);


        if (saveBool) {
            return CommonResult.success("发送成功!");
        } else {

            return CommonResult.failed("发送失败!");
        }
    }


}

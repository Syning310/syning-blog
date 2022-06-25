package com.syning.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.syning.dto.article.ArticlePageDTO;
import com.syning.entity.*;
import com.syning.service.*;
import com.syning.utils.CommonPage;
import com.syning.utils.CommonResult;
import com.syning.utils.TimeUtils;
import com.syning.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Slf4j
@RequestMapping("/article")
@Controller
public class ArticleController {

    @Resource
    private ITArticleService articleService;

    @Resource
    private ITArticleTypeService articleTypeService;

    @Resource
    private ITArticleTagService articleTagService;

    @Resource
    private ITArticleTagListService articleTagListService;

    @Resource
    private ITCommentService commentService;

    @Resource
    private ITCommentReplyService commentReplyService;

    @Resource
    private ITUserService userService;

    @Resource
    private RoleService roleService;

    /**
     * 跳转到文章展示页面
     *
     * @param model
     * @param articleId
     * @return
     */
    @GetMapping("/view/{articleId}")
    public String viewArticle(Model model, @PathVariable("articleId") Integer articleId) {

        // 获取所有标签放入模型
        // 根据 articleId 获取文章，放入模型
        // 获取与该文章有关联的 tagId 回显它

        // 通过id，填充 ArticleVO 对象
        ArticleVO articleVO = articleService.getArticleVOById(articleId);

        // 获取应该亮起来的标签集合
        List<TagVO> upTagVO = articleTagListService.getUpTagVO(articleId);

        // 获取不亮起的标签集合
        List<TagVO> noTagVO = articleTagListService.getNoTagVO(articleId);


        // 通过文章id，获取所有评论
        List<CommentVO> commentVOList = commentService.getCommentVOList(articleId);

        for (CommentVO cmt : commentVOList) {

            // 得到时差
            cmt.setTimeEquation(TimeUtils.timeEquation(cmt.getCommentTime()));

            // 根据评论的id，获得该评论的所有回复
            List<ReplyVO> replyVOList = commentReplyService.getReplyVOList(cmt.getCommentId());

            // 获取评论与现在的时差
            for (ReplyVO reply : replyVOList) {
                reply.setTimeEqt(TimeUtils.timeEquation(reply.getCommentReplyAddTime()));
            }

            // 将replyVOList集合设置到该条评论的属性中
            cmt.setReplyVOList(replyVOList);

        }


        model.addAttribute("articleVO", articleVO);
        model.addAttribute("upTagVO", upTagVO);
        model.addAttribute("noTagVO", noTagVO);
        model.addAttribute("commentVOList", commentVOList);

        return "user/articleView";
    }


    /**
     * 跳转到修改文章的页面，并且回显
     *
     * @param model
     * @param articleId
     * @return
     */
    @GetMapping(value = {"/edit/{articleId}"})
    public String editArticle(Model model, @PathVariable("articleId") Integer articleId) {

        // 获取当前登录的主体，然后判断当前点击点文章id，属不属于当前登录的主体
        // 注：如果是管理员身份，那么可以直接修改
        User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        // 判断当前登录的用户有无管理员角色，如果没有的话，需要检查这篇文章是不是它的
        List<Role> roleList = roleService.getListByUserName(user.getUsername());    // 通过用户名获取该用户的角色列表

        // 判断该角色列表中有无 管理员角色，返回 true 说明存在
        boolean contBool = roleList.contains(new Role(1, "管理员"));

        if (!contBool) {
            boolean isMinsBool = articleService.isItMins(articleId, user.getUsername());

            // 如果是false，说明这个篇文章不属于当前主体用户
            if (isMinsBool == false) {
                model.addAttribute("message", "不能修改别人的文章！");
                return "redirect:/unauth";
            }
        }


        // 获取所有标签放入模型
        // 根据 articleId 获取文章，放入模型
        // 获取与该文章有关联的 tagId 回显它

        // 通过id，填充 ArticleVO 对象
        ArticleVO articleVO = articleService.getArticleVOById(articleId);

        // 获取应该亮起来的标签集合
        List<TagVO> upTagVO = articleTagListService.getUpTagVO(articleId);

        // 获取不亮起的标签集合
        List<TagVO> noTagVO = articleTagListService.getNoTagVO(articleId);

        // 获取所有文章类型
        List<TArticleType> typeList = articleTypeService.list();

        model.addAttribute("articleVO", articleVO);
        model.addAttribute("upTagVO", upTagVO);
        model.addAttribute("noTagVO", noTagVO);
        model.addAttribute("typeList", typeList);


        return "user/editArticle";
    }


    /**
     * 将标签与文章id关联的关系放入 t_article_tag_list 表中
     *
     * @param article
     * @return
     */
    private boolean addTagList(ArticleVO article) {

        boolean saveBatchBool = false;

        List<TArticleTagList> tagLists = new ArrayList<>();

        for (int i = 0; i < article.getArticleTagList().size(); ++i) {

            // 创建一个标签与文章的关联对象
            TArticleTagList articleTagList = new TArticleTagList();

            // 从标签集合中取出标签的 id
            Integer tagId = article.getArticleTagList().get(i);

            // 将标签的id和文章的id关联起来
            articleTagList.setArticleTagId(tagId);
            articleTagList.setArticleId(article.getArticleId());

            tagLists.add(articleTagList);
        }

        if (!tagLists.isEmpty()) {
            saveBatchBool = articleTagListService.saveAll(tagLists);
        }


        return saveBatchBool;
    }


    /**
     * 保存文章或修改文章
     *
     * @param article
     * @param session
     * @return
     */
    @PostMapping("/saveArticle")
    @ResponseBody
    @Transactional(rollbackFor = Exception.class)      // 事务回滚
    public CommonResult saveArticle(@RequestBody ArticleVO article, HttpSession session) {
//        log.info("**********{}", article);

        boolean result = false;

        // 如果该文章有id，说明是修改的，如果没有则说明是保存文章
        Integer articleId = article.getArticleId();

        if (articleId != null) {
            // 修改

            // 1、修改文章的类型 article_type_id 和 文章内容 和 文章的标题
            result = articleService.updateByArticleVO(article);

            // 根据文章id删除所有与之有关的标签关联
            articleTagListService.remove(Wrappers.<TArticleTagList>lambdaQuery()
                    .eq(TArticleTagList::getArticleId, article.getArticleId()));

            // 修改文章

        } else {


            /**     获取当前的主体
             *  [Username=wuxia, Password=[PROTECTED], Enabled=true,
             *  AccountNonExpired=true, credentialsNonExpired=true, AccountNonLocked=true,
             *  Granted Authorities=[ROLE_普通用户]]
             */
            User principal = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

            // 获取当前登录的用户的id
            // 获取当前主体的 id
            TUser user = userService.getOne(Wrappers.<TUser>lambdaQuery()
                    .eq(TUser::getUserName, principal.getUsername()));


            // 设置发布用户的id
            article.setUserId(user.getUserId());
            article.setArticleAddTime(LocalDateTime.now());


            // 保存文章
            result = articleService.saveArticle(article);

        }



        // 将文章与标签关联起来
        boolean addTagBool = addTagList(article);

        if (result) {
            return CommonResult.success("操作成功!");
        } else {
            return CommonResult.failed("操作失败!");
        }
    }


    /**
     * 跳转到发布文章的页面
     *
     * @param model
     * @return
     */
    @GetMapping("/publish")
    public String publishArticle(Model model) {

        // 这里取得数据库中的 t_article_type 额外取得各个类型的文章数量
        List<TArticleTypeVO> articleTypeVOList = articleTypeService.articleTypeList();

        // 放入数据模型中
        model.addAttribute("typeList", articleTypeVOList);

        // 获取所有的标签，放入模型中
        List<TArticleTag> tagList = articleTagService.list();

        model.addAttribute("tagList", tagList);


        return "user/publishArticle";
    }


    /**
     * 根据文章id删除文章
     *
     * @param articleId
     * @return
     */
    @Secured({"ROLE_管理员"})
    @ResponseBody
    @PostMapping("/del")
    public CommonResult articleDel(Integer articleId) {

        boolean removeBool = articleService.removeById(articleId);

        if (removeBool) {
            return CommonResult.success("删除成功!");
        } else {
            return CommonResult.failed("删除失败!");
        }
    }


    /**
     * 显示给视图，文章列表
     *
     * @param articlePageDTO
     * @param model
     * @return
     */
    @GetMapping("/list")
    public String articleList(ArticlePageDTO articlePageDTO, Model model) {

        IPage<ArticleVO> articlePage =
                new Page<>(articlePageDTO.getPageNumber(), articlePageDTO.getPageSize());

        IPage<ArticleVO> articleIPage = articleService.articleList(articlePage, articlePageDTO.getArticleTitle());

        model.addAttribute("articleIPage", CommonPage.restPage(articleIPage));


        model.addAttribute("articleTitle", articlePageDTO.getArticleTitle());

        return "admin/articleList";
    }


}

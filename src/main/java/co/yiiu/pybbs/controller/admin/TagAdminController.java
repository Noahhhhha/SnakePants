package co.yiiu.pybbs.controller.admin;

import co.yiiu.pybbs.model.AdminUser;
import co.yiiu.pybbs.model.Tag;
import co.yiiu.pybbs.model.User;
import co.yiiu.pybbs.service.ITagService;
import co.yiiu.pybbs.service.impl.AdminUserService;
import co.yiiu.pybbs.service.impl.AdminUserTagService;
import co.yiiu.pybbs.service.impl.TopicService;
import co.yiiu.pybbs.util.FileUtil;
import co.yiiu.pybbs.util.Result;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@Controller
@RequestMapping("/admin/tag")
public class TagAdminController extends BaseAdminController {

    @Autowired
    private ITagService tagService;
    @Autowired
    private FileUtil fileUtil;
    @Autowired
    private AdminUserTagService adminUserTagService;
    @Autowired
    private AdminUserService adminUserService;
    @Autowired
    private TopicService topicService;

    @RequiresPermissions("tag:list")
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") Integer pageNo, String name, Model model) {
        if (StringUtils.isEmpty(name)) name = null;
        IPage<Tag> page = tagService.selectAll(pageNo, null, name);
        model.addAttribute("page", page);
        model.addAttribute("name", name);
        return "admin/tag/list";
    }


    // 解禁用户
    @GetMapping("/add")
    @ResponseBody
    public Result jiejin(String tagName) {
        List<Tag> havetags = tagService.selectAll();
        List<String> havetagsString = new ArrayList<>();
        for(int i=0;i < havetags.size(); i++){
            havetagsString.add(havetags.get(i).getName());
        }
        if (havetagsString.contains(tagName)){
            return error("已经有这个分区了");
        }
        System.out.println(tagName);
        tagService.insertTag(tagName);
        return success();
    }



    @RequiresPermissions("tag:edit")
    @GetMapping("/edit")
    public String edit(Integer id, Model model) {
        model.addAttribute("tag", tagService.selectById(id));
        return "admin/tag/edit";
    }

    @RequiresPermissions("tag:edit")
    @PostMapping("/edit")
    public String update(Integer id, String name, String description, Integer topicCount, MultipartFile file) {
        Tag tag = tagService.selectById(id);
        tag.setName(name);
        tag.setDescription(description);
        tag.setTopicCount(topicCount);
        String path = fileUtil.upload(file, null, "tag");
        tag.setIcon(path);
        tagService.update(tag);
        return redirect("/admin/tag/list");
    }

    @RequiresPermissions("tag:delete")
    @GetMapping("/delete")
    @ResponseBody
    public Result delete(Integer id) {
        Tag tag = tagService.selectById(id);
        if (tag.getTopicCount() > 0) return error("标签还关联着话题，要先把相关联的话题都删了，这个标签才能删除");
        tagService.delete(id);
        return success();
    }

    // 同步标签的话题数
    @RequiresPermissions("tag:async")
    @GetMapping("/async")
    @ResponseBody
    public Result async() {
        tagService.async();
        return success();
    }
}

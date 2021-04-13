package co.yiiu.pybbs.controller.admin;

import co.yiiu.pybbs.exception.ApiAssert;
import co.yiiu.pybbs.model.AdminUser;
import co.yiiu.pybbs.model.AdminUserTag;
import co.yiiu.pybbs.model.Tag;
import co.yiiu.pybbs.service.IAdminUserService;
import co.yiiu.pybbs.service.IRoleService;
import co.yiiu.pybbs.service.impl.AdminUserTagService;
import co.yiiu.pybbs.service.impl.TagService;
import co.yiiu.pybbs.util.StringUtil;
import co.yiiu.pybbs.util.bcrypt.BCryptPasswordEncoder;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@Controller
@RequestMapping("/admin/admin_user")
public class AdminUserAdminController extends BaseAdminController {

    @Autowired
    private IAdminUserService adminUserService;
    @Autowired
    private IRoleService roleService;
    @Autowired
    private AdminUserTagService adminUserTagService;
    @Autowired
    private TagService tagService;

    @RequiresPermissions("admin_user:list")
    @GetMapping("/list")
    public String list(Model model) {
        model.addAttribute("adminUsers", adminUserService.selectAll());
        return "admin/admin_user/list";
    }

    @GetMapping("/error")
    public String error(Model model) {
        return "admin/admin_user/error";
    }

    @RequiresPermissions("admin_user:add")
    @GetMapping("/add")
    public String add(Model model) {
        // 查询所有的角色
        model.addAttribute("roles", roleService.selectAll());
        return "admin/admin_user/add";
    }

    @RequiresPermissions("admin_user:add")
    @PostMapping("/add")
    public String save(AdminUser adminUser,String tags) throws Exception {
        adminUser.setInTime(new Date());
        adminUser.setPassword(new BCryptPasswordEncoder().encode(adminUser.getPassword()));
        if (adminUser.getRoleId() == 3){
            String[] strings = StringUtils.commaDelimitedListToStringArray(tags);
            Set<String> set = StringUtil.removeEmpty(strings);
            ApiAssert.notTrue(set.isEmpty(), "请输入板块标签");

            List<Tag> havetags = tagService.selectAll();
            List<String> havetagsString = new ArrayList<>();
            for(int i=0;i < havetags.size(); i++){
                havetagsString.add(havetags.get(i).getName());
            }
            for (String s : set){
                if(!havetagsString.contains(s)){
                    return redirect("/admin/admin_user/error");
                }
            }
        }
        adminUserService.insert(adminUser, tags);
        return redirect("/admin/admin_user/list");
    }

    @RequiresPermissions("admin_user:edit")
    @GetMapping("/edit")
    public String edit(Integer id, Model model) {
        AdminUser adminUser = getAdminUser();
        //    Assert.isTrue(adminUser.getId().equals(id), "谁给你的权限让你修改别人的帐号的？");
        // 查询所有的角色
        model.addAttribute("roles", roleService.selectAll());
        model.addAttribute("adminUser", adminUserService.selectById(id));
        List<Tag> tagList = tagService.selectByAdminUserId(id);
        String tags = StringUtils.collectionToCommaDelimitedString(tagList.stream().map(Tag::getName).collect(Collectors
                .toList()));
        model.addAttribute("tags",tags);
        return "admin/admin_user/edit";
    }

    @RequiresPermissions("admin_user:edit")
    @PostMapping("/edit")
    public String edit(AdminUser adminUser,String tags) {
        AdminUser _adminUser = getAdminUser();
        //    Assert.isTrue(_adminUser.getId().equals(adminUser.getId()), "谁给你的权限让你修改别人的帐号的？");
        if (StringUtils.isEmpty(adminUser.getPassword())) {
            adminUser.setPassword(null);
        } else {
            adminUser.setPassword(new BCryptPasswordEncoder().encode(adminUser.getPassword()));
        }
        if (adminUser.getRoleId() == 3){
            String[] strings = StringUtils.commaDelimitedListToStringArray(tags);
            Set<String> set = StringUtil.removeEmpty(strings);
            ApiAssert.notTrue(set.isEmpty(), "请输入板块标签");
        }
        adminUserService.update(adminUser, tags);
        return redirect("/admin/admin_user/list");
    }

    @GetMapping("/delete")
    public String delete(Integer id) {
        adminUserTagService.delete(id);
        adminUserService.delete(id);
        return redirect("/admin/admin_user/list");
    }
}

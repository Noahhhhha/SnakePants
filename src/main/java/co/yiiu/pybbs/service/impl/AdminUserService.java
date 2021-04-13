package co.yiiu.pybbs.service.impl;

import co.yiiu.pybbs.mapper.AdminUserMapper;
import co.yiiu.pybbs.model.AdminUser;
import co.yiiu.pybbs.model.AdminUserTag;
import co.yiiu.pybbs.model.Tag;
import co.yiiu.pybbs.service.IAdminUserService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Map;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@Service
@Transactional
public class AdminUserService implements IAdminUserService {

    @Autowired
    private AdminUserMapper adminUserMapper;
    @Autowired
    private AdminUserTagService adminUserTagService;
    @Autowired
    private TagService tagService;

    // 根据用户名查询用户
    @Override
    public AdminUser selectByUsername(String username) {
        QueryWrapper<AdminUser> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(AdminUser::getUsername, username);
        return adminUserMapper.selectOne(wrapper);
    }

    // 查询所有的后台用户
    @Override
    public List<Map<String, Object>> selectAll() {
        return adminUserMapper.selectAll();
    }

    @Override
    public void update(AdminUser adminUser, String tags) {
        adminUserMapper.updateById(adminUser);
        if (!StringUtils.isEmpty(tags)) {
            // 保存标签
            List<Tag> tagList = tagService.insertTag(Jsoup.clean(tags, Whitelist.none()));
            // 处理标签与话题的关联
            adminUserTagService.insert(adminUser.getId(), tagList);
        }
    }

    @Override
    public int insert(AdminUser adminUser,String tags) {
        if (!StringUtils.isEmpty(tags)) {
            // 保存标签
            List<Tag> tagList = tagService.insertTag(Jsoup.clean(tags, Whitelist.none()));
            // 处理标签与话题的关联
            adminUserTagService.insert(adminUser.getId(), tagList);
        }
        return adminUserMapper.insert(adminUser);
    }

    @Override
    public void delete(Integer id) {
        adminUserTagService.delete(id);
        adminUserMapper.deleteById(id);
    }

    @Override
    public AdminUser selectById(Integer id) {
        return adminUserMapper.selectById(id);
    }

    // 根据角色id查询后台关联的用户
    @Override
    public List<AdminUser> selectByRoleId(Integer roleId) {
        QueryWrapper<AdminUser> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(AdminUser::getRoleId, roleId);
        return adminUserMapper.selectList(wrapper);
    }
}

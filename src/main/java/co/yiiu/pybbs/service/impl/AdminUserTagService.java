package co.yiiu.pybbs.service.impl;

import co.yiiu.pybbs.mapper.AdminUserTagMapper;
import co.yiiu.pybbs.mapper.TopicTagMapper;
import co.yiiu.pybbs.model.AdminUserTag;
import co.yiiu.pybbs.model.Tag;
import co.yiiu.pybbs.model.TopicTag;
import co.yiiu.pybbs.model.UserTopicCost;
import co.yiiu.pybbs.service.IAdminUserTagService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by Noahhhhha
 * on 2021/3/24 15:46.
 */
@Service
@Transactional
public class AdminUserTagService implements IAdminUserTagService {
    @Autowired
    private AdminUserTagMapper adminUserTagMapper;

    @Override
    public List<AdminUserTag> selectByAdminUserId(Integer adminUserId) {
        QueryWrapper<AdminUserTag> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(AdminUserTag::getAdminUserId, adminUserId);
        return adminUserTagMapper.selectList(wrapper);
    }

    @Override
    public void insert(Integer adminUserId, List<Tag> tagList) {
        // 先删除topicId对应的所有记录
        this.delete(adminUserId);
        // 循环保存对应关联
        tagList.forEach(tag -> {
            AdminUserTag adminUserTag = new AdminUserTag();
            adminUserTag.setAdminUserId(adminUserId);
            adminUserTag.setTagId(tag.getId());
            adminUserTagMapper.insert(adminUserTag);
        });
    }

    @Override
    public void delete(Integer adminUserId) {
        QueryWrapper<AdminUserTag> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(AdminUserTag::getAdminUserId, adminUserId);
        adminUserTagMapper.delete(wrapper);
    }
}

package co.yiiu.pybbs.service;

import co.yiiu.pybbs.model.AdminUserTag;
import co.yiiu.pybbs.model.Tag;
import co.yiiu.pybbs.model.TopicTag;
import co.yiiu.pybbs.model.UserTopicCost;

import java.util.List;

/**
 * Created by Noahhhhha
 * on 2021/3/24 15:30.
 */
public interface IAdminUserTagService {
    List<AdminUserTag> selectByAdminUserId (Integer adminUserId); // 查看管理员可以查看的标签模块

    void insert(Integer adminUserId, List<Tag> tagList); // 增添以及更新管理员管理标签模块

    void delete(Integer adminUserId); // 删除管理员
}

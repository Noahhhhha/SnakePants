package co.yiiu.pybbs.service.impl;

import co.yiiu.pybbs.mapper.UserTopicCostMapper;
import co.yiiu.pybbs.model.TopicTag;
import co.yiiu.pybbs.model.UserTopicCost;
import co.yiiu.pybbs.service.IUserTopicCostService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Noahhhhha
 * on 2021/3/20 12:07.
 */
@Service
@Transactional
public class UserTopicCostService implements IUserTopicCostService {
    @Autowired
    private UserTopicCostMapper utcmapper;

    public UserTopicCost selectByUserId(Integer userId, Integer topicId){
        QueryWrapper<UserTopicCost> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(UserTopicCost::getUserId, userId).eq(UserTopicCost::getTopicId, topicId);
        return utcmapper.selectOne(wrapper);
    }

    public void insertUserTopic(Integer userId, Integer topicId){
        UserTopicCost userTopicCost = new UserTopicCost();
        userTopicCost.setTopicId(topicId);
        userTopicCost.setUserId(userId);
        utcmapper.insert(userTopicCost);
    }

    public void deleteUserTopic(Integer userId, Integer topicId){
//        Map<String, Object> map = new HashMap();
//        map.put("userId",userId);
//        map.put("topicId", topicId);
//        utcmapper.deleteByMap(map);
        QueryWrapper<UserTopicCost> wrapper = new QueryWrapper<>();
        wrapper.lambda().eq(UserTopicCost::getUserId, userId)
                        .eq(UserTopicCost::getTopicId, topicId);
        utcmapper.delete(wrapper);
    }
}

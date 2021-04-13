package co.yiiu.pybbs.service;

import co.yiiu.pybbs.model.UserTopicCost;

/**
 * Created by Noahhhhha
 * on 2021/3/20 12:04.
 */

public interface IUserTopicCostService {
    UserTopicCost selectByUserId(Integer userId, Integer topicId);

    void insertUserTopic(Integer userId, Integer topicId);

    void deleteUserTopic(Integer userId, Integer topicId);
}

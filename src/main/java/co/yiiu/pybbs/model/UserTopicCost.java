package co.yiiu.pybbs.model;

import lombok.Data;

import java.io.Serializable;

/**
 * Created by Noahhhhha
 * on 2021/3/20 11:48.
 */
@Data
public class UserTopicCost implements Serializable {
    private static final long serialVersionUID = 1L;
    private Integer userId;
    private Integer topicId;
}

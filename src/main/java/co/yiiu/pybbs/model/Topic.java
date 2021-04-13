package co.yiiu.pybbs.model;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@Data
public class Topic implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(type = IdType.AUTO)
    private Integer id;
    private String title;
    private String content;
    private Date inTime;
    private Date modifyTime;
    private Integer userId;
    // 评论数
    private Integer commentCount;
    // 收藏数
    private Integer collectCount;
    // 浏览数
    private Integer view;
    // 置顶
    private Boolean top;
    // 加精
    private Boolean good;
    // 点赞用户的id英文,隔开的，要计算被多少人点赞过，可以通过英文,分隔这个字符串计算数量
    private String upIds;
    // 其他用户想看，需要花费的积分数
    private Integer costpoints;

    private Integer category;
    private Integer isJubao;
}

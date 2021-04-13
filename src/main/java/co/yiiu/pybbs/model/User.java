package co.yiiu.pybbs.model;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@Data
public class User implements Serializable {

    private static final long serialVersionUID = -5051120337175047163L;

    @TableId(type = IdType.AUTO)
    private Integer id;
    private String username;
    private String telegramName;
    private String avatar; // 头像
    @JsonIgnore
    private String password;
    private String email;
    private String mobile;
    // 个人网站
    private String website;
    // 个人简介
    private String bio;
    private Integer score;
    private Date inTime;
    @JsonIgnore
    private String token;
    // 有消息通知是否通过邮箱收取
    private Boolean emailNotification;
    // 帐号是否激活
    private Boolean active;

    private Integer isJinyan;
    private Integer isJubao;

    // 有消息通知是否通过telegram收取
    // 文档上写的可以通过username跟userId发送消息，但测试结果是只能通过userId发送
    // 难道我调接口的姿势不对？待我后面再收拾它。。
    // private Boolean telegramNotification;
}

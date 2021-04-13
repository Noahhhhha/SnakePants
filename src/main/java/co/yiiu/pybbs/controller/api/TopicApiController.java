package co.yiiu.pybbs.controller.api;

import co.yiiu.pybbs.exception.ApiAssert;
import co.yiiu.pybbs.exception.ApiException;
import co.yiiu.pybbs.model.Collect;
import co.yiiu.pybbs.model.Tag;
import co.yiiu.pybbs.model.Topic;
import co.yiiu.pybbs.model.User;
import co.yiiu.pybbs.model.vo.CommentsByTopic;
import co.yiiu.pybbs.service.*;
import co.yiiu.pybbs.util.IpUtil;
import co.yiiu.pybbs.util.Result;
import co.yiiu.pybbs.util.SensitiveWordUtil;
import co.yiiu.pybbs.util.StringUtil;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Created by tomoya.
 * Copyright (c) 2018, All Rights Reserved.
 * https://yiiu.co
 */
@RestController
@RequestMapping("/api/topic")
public class TopicApiController extends BaseApiController {

    @Autowired
    private ITopicService topicService;
    @Autowired
    private ITagService tagService;
    @Autowired
    private ICommentService commentService;
    @Autowired
    private IUserService userService;
    @Autowired
    private ICollectService collectService;
    @Autowired
    private IUserTopicCostService userTopicCostService;


    // 举报帖子
    @GetMapping("/jubao")
    @ResponseBody
    public Result jubao(Integer id) {
        Topic topic = topicService.selectById(id);
        topic.setIsJubao(topic.getIsJubao()+1);
        topicService.update(topic, StringUtils.collectionToCommaDelimitedString(tagService.selectByTopicId(id).stream().map(Tag::getName).collect(Collectors
                .toList())));
        return success();
    }

    // 话题详情
    @GetMapping("/{id}")
    public Result detail(@PathVariable Integer id, HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>();
        // 查询话题详情
        Topic topic = topicService.selectById(id);
        // 查询话题关联的标签
        List<Tag> tags = tagService.selectByTopicId(id);
        // 查询话题的评论
        List<CommentsByTopic> comments = commentService.selectByTopicId(id);
        // 查询话题的作者信息
        User topicUser = userService.selectById(topic.getUserId());
        // 查询话题有多少收藏
        List<Collect> collects = collectService.selectByTopicId(id);
        // 如果自己登录了，查询自己是否收藏过这个话题
        User user = getUser();
        // 这里有个判断积分的逻辑，所以没办法走token，走的session
        int costType = 1; // 0表示第一次购买，1表示已经购买过了或者不用购买
        int cost = topic.getCostpoints();
        if (user != null) {
            Collect collect = collectService.selectByTopicIdAndUserId(id, user.getId());
            map.put("collect", collect);
            if (cost != 0){
                if (userTopicCostService.selectByUserId(user.getId(),id)==null){
                    if (user.getScore() >= cost){
                        costType=0;
                        user.setScore(user.getScore()-cost);
                        topicUser.setScore(topicUser.getScore()+cost);
                        userService.update(user);
                        userService.update(topicUser);
                        userTopicCostService.insertUserTopic(user.getId(), id);
                    }else {
                        throw new ApiException("没积分了您，请多发帖或者参与讨论赚取积分");
                    }
                }
            }
        }else{
            if(cost != 0){
                throw new ApiException("此话题需要积分哦，请您先登陆");
            }
        }
        // 话题浏览量+1
        String ip = IpUtil.getIpAddr(request);
        ip = ip.replace(":", "_").replace(".", "_");
        topic = topicService.updateViewCount(topic, ip);
        topic.setContent(SensitiveWordUtil.replaceSensitiveWord(topic.getContent(), "*", SensitiveWordUtil.MinMatchType));


        map.put("costpoints",topic.getCostpoints());
        map.put("costType", costType);
//        map.put("topic", topic);
//        map.put("tags", tags);
//        map.put("comments", comments);
//        map.put("topicUser", topicUser);
//        map.put("collects", collects);
        return success(map);
    }

    // 创建话题
    @PostMapping
    public Result create(@RequestBody Map<String, String> body, HttpSession session) {
        User user = getApiUser();
        if (user.getIsJinyan() == 1)
            throw new ApiException("您已被禁言，无法创建帖子哦");
        ApiAssert.isTrue(user.getActive(), "你的帐号还没有激活，请去个人设置页面激活帐号");
        String title = body.get("title");
        String content = body.get("content");
        String tags = body.get("tags");

        Integer costpoints = Integer.valueOf(body.get("costpoints"));
        Integer category = Integer.valueOf(body.get("category"));

        ApiAssert.notEmpty(title, "请输入标题");
        ApiAssert.isNull(topicService.selectByTitle(title), "话题标题重复");
        String[] strings = StringUtils.commaDelimitedListToStringArray(tags);
        Set<String> set = StringUtil.removeEmpty(strings);
        ApiAssert.notTrue(set.isEmpty() || set.size() > 5, "请输入标签且标签最多5个");

        List<Tag> havetags = tagService.selectAll();
        List<String> havetagsString = new ArrayList<>();
        for(int i=0;i < havetags.size(); i++){
            havetagsString.add(havetags.get(i).getName());
        }
        for (String s : set){
            if(!havetagsString.contains(s)){
                return error("请检查所投的分区是否存在");
            }
        }

        // 保存话题
        // 再次将tag转成逗号隔开的字符串
        tags = StringUtils.collectionToCommaDelimitedString(set);
        Topic topic = topicService.insert(title, content, tags, user, costpoints, category, session);
        topic.setContent(SensitiveWordUtil.replaceSensitiveWord(topic.getContent(), "*", SensitiveWordUtil.MinMatchType));
        userTopicCostService.insertUserTopic(getUser().getId(),topic.getId()); // 创建作者与自己话题的积分关系
        return success(topic);
    }

    // 更新话题
    @PutMapping(value = "/{id}")
    public Result edit(@PathVariable Integer id, @RequestBody Map<String, String> body) {
        User user = getApiUser();
        if (user.getIsJinyan() == 1)
            throw new ApiException("您已被禁言，无法更新帖子哦");
        String title = body.get("title");
        String content = body.get("content");
        String tags = body.get("tags");

        String[] strings = StringUtils.commaDelimitedListToStringArray(tags);
        Set<String> set = StringUtil.removeEmpty(strings);
        List<Tag> havetags = tagService.selectAll();
        List<String> havetagsString = new ArrayList<>();
        for(int i=0;i < havetags.size(); i++){
            havetagsString.add(havetags.get(i).getName());
        }
        for (String s : set){
            if(!havetagsString.contains(s)){
                return error("没有此分区");
            }
        }


        Integer costpoints = Integer.valueOf(body.get("costpoints"));
        ApiAssert.notEmpty(title, "请输入标题");
        // 更新话题
        Topic topic = topicService.selectById(id);
        ApiAssert.isTrue(topic.getUserId().equals(user.getId()), "谁给你的权限修改别人的话题的？");
        topic.setTitle(Jsoup.clean(title, Whitelist.none().addTags("video")));
        topic.setContent(content);
        topic.setCostpoints(costpoints);
        topic.setModifyTime(new Date());
        topicService.update(topic, tags);
        topic.setContent(SensitiveWordUtil.replaceSensitiveWord(topic.getContent(), "*", SensitiveWordUtil.MinMatchType));
        return success(topic);
    }

    // 删除话题
    @DeleteMapping("{id}")
    public Result delete(@PathVariable Integer id, HttpSession session) {
        User user = getApiUser();
        Topic topic = topicService.selectById(id);
        userTopicCostService.deleteUserTopic(user.getId(),id);
        ApiAssert.isTrue(topic.getUserId().equals(user.getId()), "谁给你的权限删除别人的话题的？");
        topicService.delete(topic, session);
        return success();
    }

    @GetMapping("/{id}/vote")
    public Result vote(@PathVariable Integer id, HttpSession session) {
        User user = getApiUser();
        Topic topic = topicService.selectById(id);
        ApiAssert.notNull(topic, "这个话题可能已经被删除了");
        ApiAssert.notTrue(topic.getUserId().equals(user.getId()), "给自己话题点赞，脸皮真厚！！");
        int voteCount = topicService.vote(topic, getApiUser(), session);
        return success(voteCount);
    }
}

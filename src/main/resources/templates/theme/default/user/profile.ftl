<#include "../layout/layout.ftl"/>
<@html page_title=user.username + " 的个人主页" page_tab="user">
    <div class="row">
        <div class="col-md-9">
            <div class="card">
                <div class="card-body">
                    <div class="media">
                        <img src="${user.avatar!}" class="mr-3 avatar avatar-lg" alt="avatar"/>
                        <div class="media-body">
                            <h3 style="margin-top: 0">${user.username!}</h3>
                            <#if user.isJinyan == 1>
                                <p class="text-danger">该用户已被禁言</p>
                            </#if>
                            <button onclick="jubao('${user.id}')" class="btn btn-xs btn-danger">举报</button>
                            <div>积分：<a href="/top100">${user.score}</a></div>
                            <#if user.bio??>
                                <div><i class="gray">${user.bio!}</i></div>
                            </#if>
                            <div>收藏话题: <a href="/user/${user.username}/collects">${collectCount!0}</a></div>
                            <div>入驻时间: ${model.formatDate(user.inTime)}</div>
                        </div>
                    </div>
                </div>
                <#if user.githubName?? || user.telegramName?? || user.website??>
                    <div class="card-footer" style="background-color: #fff;">
                        <#if user.website?? && user.website != "">
                            <a href="${user.website!}" class="social_label" target="_blank"><i class="fa fa-home"
                                                                                               style="color: #91c330;"></i> ${user.website!}
                            </a>
                        </#if>
                        <#if user.githubName?? && user.githubName != "">
                            <a href="https://github.com/${user.githubName!}" class="social_label" target="_blank"><i
                                        class="fa fa-github" style="color: black;"></i> ${user.githubName!}</a>
                        </#if>
                        <#if user.telegramName?? && user.telegramName != "">
                            <a href="https://telegram.me/${user.telegramName!}" class="social_label" target="_blank"><i
                                        class="fa fa-telegram" style="color: #61a7e2;"></i> ${user.telegramName!}</a>
                        </#if>
                    </div>
                </#if>
            </div>
            <#include "../components/user_topics.ftl"/>
            <@user_topics pageNo=1 pageSize=10 username=username isFooter=true/>

            <#include "../components/user_comments.ftl"/>
            <@user_comments pageNo=1 pageSize=10 username=username isFooter=true/>
        </div>
        <div class="col-md-3 hidden-xs">
            <div class="card"><p></p></div>
            <#if githubLogin??>
                <#include "../components/github_repos.ftl"/>
            </#if>
        </div>
    </div>
    <script>
        function jubao(id) {
            if (confirm("确定要举报这个用户吗？我们将对其言行进行监督。")) {
                $.get("/api/user/jubao?id=" + id, function (data) {
                    if (data.code === 200) {
                        toast("举报成功", "success");
                        // setTimeout(function () {
                        //     window.location.reload();
                        // }, 700);
                    } else {
                        toast(data.description);
                    }
                })
            }
        }
    </script>
</@html>

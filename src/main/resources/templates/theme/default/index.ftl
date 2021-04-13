<#include "layout/layout.ftl"/>
<@html page_title="首页" page_tab="index">
    <#if active?? && active>
        <div class="alert alert-success">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
            <strong>激活成功</strong>
        </div>
    </#if>
<#--    <div class="input-group">-->
<#--        <input class="form-control" type="search" name="keyword" placeholder="回车搜索" value="${keyword!}"-->
<#--               required aria-label="Search">-->
<#--        <div class="input-group-append">-->
<#--            <button class="btn btn-outline-success" type="submit">${i18n.getMessage("search")}</button>-->
<#--        </div>-->
<#--    </div>-->
    <div class="row">
        <div class="col-md-9">
            <div class="card">
                <#include "category.ftl">
                <div class="card-body">
                    <@tag_topics pageNo=pageNo!1 tab=tab!"all" tag=tag!"all" keyword=keyword!"none">
                        <#include "components/topics.ftl"/>
                        <@topics page=page/>
                        <#include "components/paginate.ftl"/> <#-- 分页器 -->
                        <@paginate currentPage=page.current totalPage=page.pages actionUrl="/" urlParas="&tab=${tab!}"/>
                    </@tag_topics>
                </div>
            </div>
        </div>
        <div class="col-md-3 d-none d-md-block">
            <#if _user??>
                <#include "components/user_info.ftl"/>
            <#else>
                <#include "components/welcome.ftl"/>
            </#if>
            <#include "components/score.ftl"/>
            <@score limit=10/>
        </div>
    </div>
</@html>

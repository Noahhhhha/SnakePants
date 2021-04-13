
<#--<form class="form-inline my-2 my-lg-0 ml-2 d-none d-md-block" >-->
<#--    <div class="input-group">-->
<#--        <input class="form-control" id="searchbox" type="search" name="keyword" placeholder="回车搜索" value="${keyword!}" required aria-label="Search">-->
<#--        <div class="input-group-append">-->
<#--            <button class="btn btn-outline-success" id="searchboxclick">${i18n.getMessage("search")}</button>-->
<#--        </div>-->
<#--    </div>-->
<#--</form>-->

<div class="card-header">
    <ul class="nav nav-pills">
        <li class="nav-item"><a class="nav-link <#if tab=="all">active</#if>" href="/?tab=all&tag=${tag}">综合排序</a></li>
        <li class="nav-item"><a class="nav-link <#if tab=="good">active</#if>" href="/?tab=good&tag=${tag}">精华</a></li>
        <li class="nav-item"><a class="nav-link <#if tab=="hot">active</#if>" href="/?tab=hot&tag=${tag}">最热</a></li>
        <li class="nav-item"><a class="nav-link <#if tab=="newest">active</#if>" href="/?tab=newest&tag=${tag}">最新</a></li>
        <li class="nav-item"><a class="nav-link <#if tab=="noanswer">active</#if>" href="/?tab=noanswer&tag=${tag}">无人问津</a></li>
    </ul>
    <div style="height:10px; width:100%"></div>
    <@tag_tags pageNo=pageNo pageSize=40>
        <ul class="nav nav-pills">
            <li class="nav-item"><a class="nav-link <#if tag == "all">active</#if>" href="/?tab=${tab}&tag=all"+keyword>全部分区</a></li>
            <#list page.records as tag2>
                <li class="nav-item"><a class="nav-link <#if tag == tag2.name>active</#if>" href="/?tab=${tab}&tag=${tag2.name}"+keyword>${tag2.name}</a></li>
            </#list>
        </ul>
    </@tag_tags>
    <#include "tag/tagsList.ftl"/>
</div>

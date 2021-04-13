<div class="row">
    <div class="card-body">
        <@tag_tags pageNo=pageNo pageSize=40>
            <div class="row" style="overflow: hidden;">
                <#list page.records as tag>
                   <div class="tag-item-list">
                        <#if tag.icon??>
                            <img src="${tag.icon}" width="24" class="sponsor-tag-img" alt="${tag.name}">
                        </#if>
                        <a href="/topic/tag/${tag.name}">
                            <span class="badge badge-info">#${tag.name} ${tag.topicCount}#</span>
                        </a>
<#--                        <small class="excerpt text-muted" style="">${tag.description!}</small>-->
                   </div>
                </#list>
            </div>
        </@tag_tags>
    </div>
</div>


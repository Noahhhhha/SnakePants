<#macro html page_title page_tab>
    <!doctype html>
    <html lang="zh-CN">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>${page_title!}</title>
        <link rel="icon" href="https://yiiu.co/favicon.ico">
        <#--css-->
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/css/bootstrap.min.css"/>
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
        <link rel="stylesheet" href="/static/theme/default/css/app.css"/>
        <#--javascript-->
        <script src="/static/ui/jquery.min.js"></script>
<#--        <script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>-->
        <script src="/static/theme/default/libs/layer/layer.js"></script>
        <script src="/static/theme/default/js/app.js"></script>

<#--     板娘特效-->
<#--        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/font-awesome/css/font-awesome.min.css">-->
        <script src="/static/live2d-widget-master/autoload.js"></script>

    </head>
    <body>
<#--    粒子特效-->
    <script type="text/javascript" src="https://cdn.bootcss.com/canvas-nest.js/1.0.1/canvas-nest.min.js"></script>

<#--    <div class="wrapper">-->
    <div>
        <#include "header.ftl"/>
        <@header page_tab=page_tab/>
        <div class="container">
            <#nested />
        </div>
    </div>
    <#include "footer.ftl"/>
    <#include "../components/websocket.ftl"/>
    </body>
    </html>
</#macro>


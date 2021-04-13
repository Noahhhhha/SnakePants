<#--投票结果的界面-->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta content="IE=edge" http-equiv="X-UA-Compatible">
    <meta content="width=device-width, initial-scale=1" name="viewport">

    <title>Vote for : ${title}</title>

    <link href="/static/vote/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom stylesheet -->
    <link href="/static/vote/css/vote/vote.css" rel="stylesheet">
    <link href="/static/vote/fontawesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="/static/vote/css/pub/sticky_footer_navbar.css" rel="stylesheet">

    <!-- QR Code -->
    <!-- JQuery -->
    <script src="/static/vote/jquery/jquery-3.4.1.min.js"></script>
    <!-- Generate Modal -->
    <#include "modal/QR_cn.ftl"/>
<#--    <#include "/vote/modal/QR_cn.html"/>-->
    <!-- Import QR Generator -->
    <script src="/static/vote/js/vote/jquery.qrcode.min.js"></script>
    <!-- Generate QR -->
    <script src="/static/vote/js/generateQR.js"></script>
</head>

<body>
<nav class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button aria-controls="navbar" aria-expanded="false" class="navbar-toggle collapsed" data-target="#navbar"
                    data-toggle="collapse" type="button">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand logo" href="/">${site.name!}</a>
<#--            <a class="navbar-brand logo" data-target="#mainPage" data-toggle="modal">Voter</a>-->
        </div>
        <div class="collapse navbar-collapse" id="navbar">
            <ul class="nav navbar-nav">
                <li class="active"><a href="javascript: void(0);">为 VoteID ${voteId} 投票</a></li>
                <li><a data-target="#toVoteID" data-toggle="modal" href="javascript: void(0);">前往 VoteId ..</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container" style="padding: 0 5px 0;">
    <div class="title">
<#--        <a class="pull-left" href="javascript: void(0);" onclick="switchLang()">English</a>-->
        <br>
        <h2>${title}</h2>
        <span>${describe}</span>
        <#if type == 0>
            <p class="text-danger" style="font-size: 16px;">请做 <b>多项选择</b> : )</p>
        </#if>
        <#if type == 1>
            <p class="text-danger" style="font-size: 16px;">请做 <b>单项选择</b> : )</p>
        </#if>
        <#if limit != -1>
            <p >
                <i class="fa fa-info"></i>&nbsp;<span>最多选择选项${limit}</span>
            </p>
        </#if>
    </div>
</div>

<div class="text">
    <div class="container">
        <#list selection as entries>
            <div>
                <div class="row">
                    <!-- Progress -->
                    <div class="col-xs-5" id="divProgress">
                        <div class="progress progress-striped active">
                            <div aria-valuemax="100" aria-valuemin="0" aria-valuenow="60"
                                 class="progress-bar progress-bar-success" role="progressbar"
                                 id="progress${entries.num}"
                                 style="width: ${entries.percent}%;">
                                <div class="count">${(entries.count)!}</div>
                            </div>
                        </div>
                    </div>

                    <!-- Selection -->
                    <div class="col-xs-5" id="divSelection">${(entries.selectionText)!}</div>

                    <!-- Vote -->
                    <div class="col-xs-2" id="divVote">
                        <div class="vote">
                            <#if type == 0>
                                <div class="checkbox">
                                    <label>
                                        <input class="selections" name="optionsCheckbox" id= "${entries.num}"
                                               type="checkbox">
                                    </label>
                                </div>
                            </#if>
                            <#if type == 1>
                                <div class="radio">
                                    <label>
                                        <input class="selections" name="optionsRadios" id= "${entries.num}" type="radio">
                                    </label>
                                </div>
                            </#if>
                        </div>
                    </div>
                </div>
            </div>
        </#list>
    </div>
    <br>
    <!-- Submit button -->
    <div aria-label="..." class="btn-group" role="group">
        <button class="btn btn-default" id="submitButton" onclick = "submitVote(${type}, ${voteId})" type="button"><i
                class="fa fa-hand-stop-o"></i> 确定提交
        </button>
        <button class="btn btn-default" data-target="#shareQR" data-toggle="modal" type="button"><i
                class="fa fa-qrcode"></i> 分享二维码
        </button>
    </div>
    <!-- Alert window, controlled by JS -->
    <br>
    <div class="alert"></div>
</div>

<footer class="footer">
    <div class="container">
        <br>
        <span class="text-muted">© ️${year}</span><span>&nbsp;<a href=https://github.com/AdlerED/Voter>Voter</a>
        <img height="32" src="/static/vote/images/china.png" width="32"/></span>
    </div>
</footer>
<#include "modal/toIndex_cn.ftl"/>
<#include "modal/toVoteID_cn.ftl"/>

<script src="/static/vote/bootstrap/js/bootstrap.min.js"></script>
<script src="/static/vote/bootstrap/js/icheck.min.js"></script>

<!-- Custom JS -->
<script src="/static/vote/js/vote/submit_cn.js"></script>
<script src="/static/vote/js/vote/toVoteID_cn.js"></script>
<script>
    eventOnSelect([[${limit}]]);
</script>
<script src="/static/vote/js/vote/switchLanguage.js"></script>
<script>
    function switchLang() {
        switchLanguage("en", [[${voteId}]]);
    }
</script>
</body>
</html>
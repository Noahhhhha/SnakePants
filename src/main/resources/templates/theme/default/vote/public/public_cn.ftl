<#--发起投票的界面-->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <meta content="IE=edge" http-equiv="X-UA-Compatible">
    <meta content="width=device-width, initial-scale=1" name="viewport">

    <title>发起投票 - Voter</title>

    <link href="/static/vote/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom stylesheet -->
    <link href="/static/vote/fontawesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="/static/vote/css/pub/sticky_footer_navbar.css" rel="stylesheet">
    <link href="/static/vote/progress/css/component.css" rel="stylesheet" type="text/css"/>

    <!-- Custom script -->
    <script src="/static/vote/progress/js/modernizr.custom.js"></script>
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
<#--            <a class="navbar-brand logo" data-target="#mainPage" data-toggle="modal" style="cursor:pointer;">Voter</a>-->
        </div>
        <div class="collapse navbar-collapse" id="navbar">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">发起投票</a></li>
                <li><a data-target="#toVoteID" data-toggle="modal" href="javascript: void(0);">前往 VoteID ..</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container" role="main">
    <h1 class="mt-5">发起投票</h1>
    <p class="lead">填写下方选项来发起一次投票, 无需登录。</p>
    <p class="text-info"><b>如果你提交了下方的内容，你<font color="red">不能再对该投票进行编辑/删除</font>。</b>
    </p>
    <!-- Options -->
    <!-- TITLE -->
    <div class="input-group" id="borderTitle">
        <span class="input-group-addon"><i class="fa fa-quote-left"></i></span>
        <input aria-describedby="basic-addon1" class="form-control" id="voteTitle" placeholder="投票标题" type="text">
    </div>
    <br>
    <!-- DESCRIBE -->
    <div class="input-group" id="borderDescribe">
        <textarea class="form-control" id="voteDescribe" name=textarea placeholder="投票描述，支持 HTML 代码插入元素" rows="3"></textarea>
        <span class="input-group-addon"><i class="fa fa-quote-right"></i></span>
    </div>
    <br>
    <!-- MODE AND MAXIMUM -->
    <div class="input-group" id="status">
        <div class="input-group-btn">
            <button aria-expanded="false" aria-haspopup="true" class="btn btn-default dropdown-toggle"
                    data-toggle="dropdown" id="mode"
                    type="button">选择模式 <span class="caret"></span></button>
            <ul class="dropdown-menu">
                <li><a href="javascript: void(0);" onclick="singleElection()">单项选择</a></li>
                <li><a href="javascript: void(0);" onclick="multipleSelection()">多项选择</a></li>
            </ul>
        </div>
        <input class="form-control" id="modeInput" placeholder="( '-1' 为不限制 ) 最多可选择的选项"
               type="text">
    </div>
    <!-- LINE -->
    <p class="page-header"></p>
    <!-- OPTIONS -->
    <div class="option1">
        <div class="input-group">
            <span class="input-group-addon">选项 1</span>
            <input class="form-control" id="option1" type="text">
        </div>
    </div>
    <br>
    <div class="option2">
        <div class="input-group">
            <span class="input-group-addon">选项 2</span>
            <input class="form-control" id="option2" type="text">
        </div>
    </div>
    <br>
    <div class="option3">
        <div class="input-group">
            <span class="input-group-addon">选项 3</span>
            <input class="form-control" id="option3" type="text">
            <div class="cls"></div>
            <span class="input-group-btn" id="close3">
                <button class="btn btn-default" onclick="delOption()" type="button">
                    <i class="fa fa-close"></i>
                </button>
            </span>
        </div>
        <br>
    </div>
    <!-- More selection -->
    <div class="add"></div>
    <!-- Add button -->
    <button class="btn btn-default pull-right" onclick="addOption()" type="button">
        <i class="fa fa-plus"></i>
    </button>
    <!-- Submit button -->
    <p>
    <div class="isError"></div>
    </p>
    <section>
        <button class="progress-button" data-horizontal data-perspective data-style="rotate-side-up"
                onclick="submitVote()">确定提交
        </button>
    </section>
    <br>
</div>

<br>

<footer class="footer">
    <div class="container">
        <br>
        <span class="text-muted">${YEAR}</span><span>&nbsp;<a href=https://github.com/AdlerED/Voter>Voter</a>
        <img height="32" src="/static/vote/images/china.png" width="32"/></span>
    </div>
</footer>

<script src="/static/vote/jquery/jquery-3.4.1.min.js"></script>
<script src="/static/vote/bootstrap/js/bootstrap.min.js"></script>
<script src="/static/vote/bootstrap/js/icheck.min.js"></script>

<!-- Custom JS -->
<script src="/static/vote/progress/js/classie.js"></script>
<script src="/static/vote/progress/js/progressButton.js"></script>
<script>
    [].slice.call(document.querySelectorAll('button.progress-button')).forEach(function (bttn) {
        new ProgressButton(bttn, {
            callback: function (instance) {
                var progress = 0,
                    interval = setInterval(function () {
                        progress = Math.min(progress + Math.random() * 0.1, 1);
                        instance._setProgress(progress);

                        if (progress === 1) {
                            instance._stop(1);
                            clearInterval(interval);
                        }
                    }, 100);
            }
        });
    });
</script>
<script src="/static/vote/js/pub/action_cn.js"></script>

<#include "../vote/modal/toIndex_cn.ftl"/>
<#include "../vote/modal/toVoteID_cn.ftl"/>

<script src="/static/vote/js/vote/toVoteID.js"></script>
</body>
</html>
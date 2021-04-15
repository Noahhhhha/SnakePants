<#include "../layout/layout.ftl">
<@html page_title="话题编辑" page_tab="topic">
    <section class="content-header">
        <h1>
            话题
            <small>编辑</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li><a href="/admin/topic/list">话题</a></li>
            <li class="active">编辑</li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">公告编辑</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
                <form action="" onsubmit="return;" id="form">
                    <div class="form-group">
                        <label for="title">标题</label>
                        <input type="text" name="title" id="title" class="form-control"
                               placeholder="标题"/>
                    </div>
                    <div class="form-group">
                        <label for="content">内容</label>
                        <textarea name="content" id="content" class="form-control"
                                  placeholder="内容，支持Markdown语法"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="tags">标签</label>
                        <input type="text" name="tags" id="tags" value="${tags!}" class="form-control"
                               placeholder="标签, 多个标签以 英文逗号 隔开"/>
                    </div>
                    <div class="form-group">
                        <button type="button" id="btn" class="btn btn-primary">保存公告</button>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.47.0/codemirror.min.css" rel="stylesheet">
    <style>
        .CodeMirror {
            border: 1px solid #ddd;
        }
    </style>
    <script src="/static/theme/default/js/codemirror.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.47.0/mode/markdown/markdown.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.47.0/addon/display/placeholder.min.js"></script>
    <script>
        $(function () {
            CodeMirror.keyMap.default["Shift-Tab"] = "indentLess";
            CodeMirror.keyMap.default["Tab"] = "indentMore";
            var editor = CodeMirror.fromTextArea(document.getElementById("content"), {
                lineNumbers: true,     // 显示行数
                indentUnit: 4,         // 缩进单位为4
                tabSize: 4,
                matchBrackets: true,   // 括号匹配
                mode: 'markdown',     // Markdown模式
                lineWrapping: true,    // 自动换行
            });

            $("#btn").click(function () {
                var title = $("#title").val();
                var content = editor.getDoc().getValue();
                var tags = $("#tags").val();
                // if (!title || title.length > 120) {
                //     toast("请输入标题，且最大长度在120个字符以内");
                //     return;
                // }
                // if (!tags || tags.split(",").length > 5) {
                //     toast("请输入标签，且最多只能填5个");
                //     return;
                // }
                $.post("/admin/topic/informCreate", {
                    <#--id: ${topic.id},-->
                    title: title,
                    content: content,
                    tags: tags,
                }, function (data) {
                    if (data.code === 200) {
                        toast("保存成功", "success");
                        setTimeout(function () {
                            window.location.href = "/admin/topic/inform";
                        }, 700);
                    } else {
                        toast(data.description);
                    }
                })
            })
        })
    </script>
</@html>

<#include "../layout/layout.ftl">
<@html page_title="用户添加" page_tab="auth_admin_user">
    <section class="content-header">
        <h1>
            用户
            <small>添加</small>
        </h1>
        <ol class="breadcrumb">
            <li><a href="/admin/index"><i class="fa fa-dashboard"></i> 首页</a></li>
            <li><a href="/admin/user/list">用户</a></li>
            <li class="active">添加</li>
        </ol>
    </section>
    <section class="content">
        <div class="box box-info">
            <div class="box-header with-border">
                <h3 class="box-title">用户添加</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
                <div class="row">
                    <div class="col-sm-6">
                        <form id="form" action="/admin/admin_user/add" method="post">
                            <div class="form-group">
                                <label>用户名</label>
                                <input type="text" id="username" name="username" class="form-control" placeholder="用户名">
                            </div>
                            <div class="form-group">
                                <label>密码</label>
                                <input type="password" id="password" name="password" class="form-control"
                                       placeholder="密码">
                            </div>
                            <div class="form-group">
                                <label>角色</label>
                                <div>
                                    <#list roles as role>
                                        <p>
                                            <#--                                        小圆圈-->
                                            <input clsss="guaiyoubingde" type="radio" name="roleId" value="${role.id}" id="role_${role.id}">&nbsp;

                                            <label for="role_${role.id}">${role.name!}</label>

                                            <div class="divtagsclass" id="divtags_${role.id}" >
                                                <label for="tags">标签</label>
                                                <input type="text" name="tags" id="tags_${role.id}" value="${tags!}" class="form-control"
                                                       placeholder="标签, 多个标签以 英文逗号 隔开"/>
                                            </div>
                                        </p>
                                    </#list>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-xs btn-primary">保存</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script>
        $(function () {
            $(".divtagsclass").hide();
            $("#role_3").click(function () { // 3是分区管理员
                $("#divtags_3").show();
            })
            $("#role_1").click(function () { // 3是分区管理员
                $("#divtags_3").hide();
            })
            $("#role_2").click(function () { // 3是分区管理员
                $("#divtags_3").hide();
            })

            $("#form").submit(function () {
                var username = $("#username").val();
                var password = $("#password").val();
                var roleId = $("input[name='roleId']:checked").val();
                var tags = $("#tags_3").val();
                if (!username) {
                    toast('用户名不能为空');
                    return false;
                }
                if (!password) {
                    toast('密码不能为空');
                    return false;
                }
                $.ajax({
                    url: '/admin/admin_user/add',
                    async: true,
                    cache: false,
                    type: 'post',
                    dataType: 'json',
                    data: {
                        username: username,
                        password: password,
                        roleId: roleId,
                        tags:tags,
                    },
                    // success: function (data) {
                    //     if (data.code === 200) {
                    //         suc('添加成功');
                    //         setTimeout(function () {
                    //             window.location.href = '/admin/admin_user/list';
                    //         }, 1000);
                    //     } else {
                    //         toast(data.description);
                    //     }
                    // }
                })
                return false;
            })
        })
    </script>
</@html>

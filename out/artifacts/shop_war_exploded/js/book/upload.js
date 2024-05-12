//注册表单验证
$(function(){
    var form=$("#uploadForm").Validform({
        tiptype:2,//validform初始化
    });

    form.addRule([
        {
            ele:"#1_userName",
            datatype:"*2-15",
            ajaxurl:"jsp/admin/UserManageServlet?action=find",
            nullmsg:"*请输入用户名！",
            errormsg:"*用户名为2-15个字符，请重新输入！"
        }

    ]);

});
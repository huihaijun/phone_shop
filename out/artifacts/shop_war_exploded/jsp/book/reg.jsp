<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();  
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	pageContext.setAttribute("basePath", basePath);
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<base href="${basePath}">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>手机商城</title>
	<link rel="stylesheet" href="bs/css/bootstrap.css">
	<script type="text/javascript" src="bs/js/jquery.min.js"></script>
	<script type="text/javascript" src="bs/js/bootstrap.js"></script> 

	<link rel="stylesheet" type="text/css" href="bs/validform/style.css">
	<script type="text/javascript" src="bs/validform/Validform_v5.3.2_min.js"></script>

	<script type="text/javascript" src="js/book/user_reg_login.js"></script> 
	<script type="text/javascript" src="js/book/landing.js"></script>

	<link href="css/book/head_footer.css" rel="stylesheet" type="text/css">
	<link href="css/book/user_reg_login.css" rel="stylesheet" type="text/css">
	
</head>
<style>
	.nav-tabs > li {
		width: 310px;
	}
	.wrapper .main ul li a {
		width: 310px;
	}

</style>
<body>
<c:if test="${!empty infoList}">
	<c:forEach items="${infoList}" var="i">
		<script type="text/javascript">
			alert("${i}")
		</script>
	</c:forEach>
</c:if>
	<div class="container-fullid">
		<%@include file="header.jsp" %>
		<div class="wrapper">
			<!-- main start -->
			<div class="main container">
				<div class="title">
					<ul class="nav nav-tabs" id="myTab">
						<li role="presentation" class="active"><a href="#tab_login" data-toggle="tab">登&nbsp&nbsp录</a></li>
					  	<li role="presentation" ><a href="#tab_reg" data-toggle="tab">新用户点此注册</a></li>

					</ul>
				</div>
				<!-- 注册表单 -->
				<div id="myTabContent" class="tab-content">

					<div id="tab_reg" class="tab-pane fade">
						<form id="regForm" action="UserServlet?action=reg" method="post" class="form-horizontal">
							<div class="form-group" style="width:95%;margin-left: 80px ">
								<label for="userName" class="col-md-2  control-label"style="width: 100px">用户名：</label>
								<div class="col-md-6" style="width: 213px">
									<input name="userName" id="userName" type="text" class="form-control" >
								</div>
								<div class="col-md-4"style="width: 217px">
									<span class="Validform_checktip">*以字母开头，4-8个字符</span>
								</div>	
							</div>
							<div class="form-group"style="width:95%;margin-left: 80px ">
								<label for="passWord" class="col-md-2 control-label"style="width: 100px">密码：</label>
								<div class="col-md-6"style="width: 213px">
									<input type="password" name="passWord" id="passWord" class="form-control">
								</div>
								<div class="col-md-4"style="width: 217px">
									<span class="Validform_checktip">*密码为4~8位字符</span>
								</div>
							</div>
							<div class="form-group"style="width:95%;margin-left: 80px ">
								<label for="c_passWord" class="col-md-2 control-label"style="width: 100px">确认密码：</label>
								<div class="col-md-6"style="width: 213px">
									<input type="password" name="c_passWord" id="c_passWord" class="form-control">
								</div>
								<div class="col-md-4"style="width: 217px">
									<span class="Validform_checktip"></span>
								</div>
							</div>
							<div class="form-group"style="width:95%;margin-left: 80px ">
								<label for="name" class="col-md-2 control-label"style="width: 100px">姓名：</label>
								<div class="col-md-6"style="width: 213px">
									<input type="text" id="name" name="name" class="form-control">
								</div>
								<div class="col-md-4"style="width: 217px">
									<span class="Validform_checktip">*请输入您的真实姓名</span>
								</div>
							</div>
							<div class="form-group"style="width:95%;margin-left: 80px ">
								<label class="col-md-2 control-label"style="width: 100px">性别：</label>
								<div class="col-md-6 "style="width: 213px">
									<label class="radio-inline">
										<input type="radio" name="sex" id="sex" class="pr1" value="男">男
									</label>
									<label class="radio-inline">
										<input type="radio" name="sex"  class="pr1"  value="女">女
									</label>
								</div>
								<div class="col-md-4"style="width: 217px">
									<label>
										<span class="Validform_checktip"></span>
									</label>
								</div>
							</div>
							<div class="form-group"style="width:95%;margin-left: 80px ">
								<label for="age" class="col-md-2 control-label"style="width: 100px">年龄：</label>
								<div class="col-md-6"style="width: 213px">
									<input type="text" id="age" name="age" class="form-control">
								</div>
								<div class="col-md-4"style="width: 217px">
									<span class="Validform_checktip"></span>
								</div>
							</div>
							<div class="form-group" style="width:95%; margin-left: 80px;">
								<label for="tell" class="col-md-2 control-label" style="width: 100px;">电话：</label>
								<div class="col-md-6" style="width: 213px;">
									<input type="text" id="tell" name="tell" class="form-control">
								</div>
								<div class="col-md-2" style="padding-left: 5px;">
									<button type="button" id="sendVerification" class="btn btn-primary btn-block">发送验证码</button>
								</div>
								<div class="col-md-4" style="width: 217px;">
									<span class="Validform_checktip"></span>
								</div>
							</div>
							<div class="form-group"style="width:95%;margin-left: 80px ">
								<label for="address" class="col-md-2 control-label"style="width: 100px">地址：</label>
								<div class="col-md-6"style="width: 213px">
									<input type="text" id="address" name="address" class="form-control">
								</div>
								<div class="col-md-4"style="width: 217px">
									<span class="Validform_checktip"></span>
								</div>
							</div>
							<div class="form-group" style="width: 95%; margin-left: 80px;">
								<label for="verificationCode" class="col-md-2 control-label" style="width: 100px;">验证码：</label>
								<div class="col-md-6" style="width: 213px;">
									<input type="text" id="verificationCode" name="verificationCode" class="form-control">
								</div>
								<div class="col-md-4" style="width: 217px;">
									<span class="Validform_checktip"></span>
								</div>
							</div>
							<div class="form-group"style="width:95%;margin-left: 80px ">
								<label class="col-md-2  control-label col-md-offset-2">
									<input class="btn btn-success btn-block" type="submit" value="注册">
								</label>
								<label class="col-md-2 control-label">
									<input class="btn btn-warning btn-block" type="reset" value="重置">
								</label>
							</div>
						</form>
					</div>
					<!-- 登录表单 -->
					<div id="tab_login" class="tab-pane fade in active">
						<form id="loginForm" action="UserServlet?action=login" method="post" class="form-horizontal">
							<div class="form-group">
								<label for="l_userName" class="col-md-4 control-label">用户名：</label>
								<div class="col-md-6">
									<input name="userName" id="l_userName" type="text" class="form-control" >
									<span class="Validform_checktip">&nbsp</span>
								</div>

							</div>
							<div class="form-group">
								<label for="l_passWord" class="col-md-4  control-label">密码：</label>
								<div class="col-md-6">
									<input type="password" name="passWord" id="l_passWord" class="form-control">
									<span class="Validform_checktip">&nbsp</span>
								</div>

							</div>

							<div class="form-group">
								<label for="ck_code" class="col-md-4  control-label">验证码：</label>
								<div class="col-md-3" >
									<input class="form-control" type="text" name="code" id="ck_code" >
									<span class="Validform_checktip">&nbsp</span>
								</div>

								<div class="col-md-4" style="padding:0;">
									<img class="col-md-8" id="imgCode" src="CodeServlet?action=code" alt="" style="padding:0;width:100px;height:38px;" />
									<span onclick="reCode()" class="col-md-4 glyphicon glyphicon-refresh " aria-hidden="true" style="padding:0 0 0 5px;font-size: 24px;"></span>
								</div>

							</div>
							<div class="form-group">
								<label class="col-md-2 control-label col-md-offset-4">
									<input class="btn btn-success btn-block" type="submit" value="登录">
								</label>
								<label class="col-md-2 control-label">
									<input class="btn btn-warning btn-block" type="reset" value="重置">
								</label>

							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<%@include file="footer.jsp" %>
	</div>
	
		
<script type="text/javascript">
/* tab标签显示控制通过url参数 */
	var ur=location.href;
	var para=ur.split('?')[1];
	var type="login";//默认
	if(para!=null){
		type=para.split("type=")[1];
	}
	switch (type){
	   case 'reg':
	       $('#myTab a[href="#tab_reg"]').tab('show')
	       break;
	   case 'login':
	       $('#myTab a[href="#tab_login"]').tab('show')
	       break;
	}   
	
	//验证码 
	function reCode(){
		$("#imgCode").prop("src","CodeServlet?action=code&"+new Date().getTime());
	}
//注册表单验证
$(function(){
	var form=$("#regForm").Validform({
		tiptype:2,//validform初始化
	});

	form.addRule([
		{
			ele:"#userName",
			datatype:"*2-15",
			ajaxurl:"UserServlet?action=find",
			nullmsg:"*请输入用户名！",
			errormsg:"要求2-15个字符，请重新输入！"
		},
		{
			ele:"#passWord",
			datatype:"*4-8",
			nullmsg:"*请输入密码！",
			errormsg:"要求4-8位字符，请重新输入！"
		},
		{
			ele:"#c_passWord",
			datatype:"*",
			recheck:"passWord",
			nullmsg:"*请输入确认密码！",
			errormsg:"两次输入的密码不一致！"
		},
		{
			ele:"#name",
			datatype:"*2-15",
			nullmsg:"请输入姓名！",
			errormsg:"要求2-15个字符,请重新输入！"
		},
		{
			ele:"#sex",
			datatype:"*",
			nullmsg:"请选择性别！",
			errormsg:"请选择性别！"
		},
		{
			ele:"#age",
			datatype:"n1-2",
			nullmsg:"请输入年龄",
			errormsg:"要求1-2位数字，请重新输入！"
		},
		{
			ele:"#tell",
			datatype:"/^13[0-9]{9}$|17[0-9]{9}$|14[0-9]{9}&|15[0-9]{9}$|18[0-9]{9}$/",
			ajaxurl:"UserServlet?action=findNumber",
			nullmsg:"请输入电话号码",
			errormsg:"请确认格式，请重新输入！"
		},

		{
			ele:"#address",
			datatype:"*",
			nullmsg:"请输入地址！",
			errormsg:"请输入地址！"
		}

	]);

});

//登录验证
$(function(){

	var form=$("#loginForm").Validform({
		tiptype:3
	});

	form.addRule([
		{
			ele:"#l_userName",
			datatype:"*",
			nullmsg:"*请输入用户名！",
			errormsg:"*用户名输入不正确，请重新输入！"
		},
		{
			ele:"#l_passWord",
			datatype:"*",
			nullmsg:"*请输入密码！",
			errormsg:"*密码输入不正确，请重新输入"
		},
		{
			ele:"#ck_code",
			datatype:"*",
			ajaxurl:"CodeServlet?action=ckCode",
			nullmsg:"*请输入验证码！",
			errormsg:"*验证码输入不正确"
		}
	]);
});

</script>
<script type="text/javascript">
	$(function() {
		$("#sendVerification").click(function() {

			// 表单验证
			var isValid = $("#regForm").Validform().check(false);

			// 如果验证不通过，则阻止按钮点击
			if (!isValid) {
				alert("请按照要求填写完整信息，再请求验证码！");
				return;
			}

			var number = $("#tell").val(); // 获取电话号码输入框的值
			// 发送 Ajax 请求到 UserServlet
			$.ajax({
				type: "POST",
				url: "UserServlet?action=yanzheng",
				data: {
					action: "sendVerification",
					number: number // 将电话号码作为参数传递
				},
				success: function(response) {
					console.log(response);
					// 判断是否需要显示手机号码已被注册的提示信息
					if (response.includes("n")) {
						alert("该号码已被注册，请更换号码");
					} else {
						// 如果号码未被注册，则继续原有的逻辑
						alert("验证码已发送，请注意查收！");
					}
				},
				error: function(xhr, status, error) {
					// 处理错误响应
					alert("发送验证码失败：" + error);
				}
			});
		});
	});

	$(function() {
		$("#regForm").submit(function(event) {
			// 阻止表单默认提交行为
			event.preventDefault();
			// 发送 AJAX 请求到后端
			$.ajax({
				type: "POST",
				url: "UserServlet?action=reg",
				data: $(this).serialize(), // 表单数据
				success: function(response) {
					// 如果后端返回了错误信息，则弹出提示框
					console.log("Response from backend:", response);
					if (response === "验证码错误，请重新输入！")  {
						alert(response);
					} else {
						alert("注册成功！现在你可以正常登录！");
						window.location.href = "jsp/book/reg.jsp?type=login";
					}
				},
				error: function(xhr, status, error) {
					// 处理错误响应
					alert("注册失败：" + error);
				}
			});
		});
	});

</script>
</body>
</html>
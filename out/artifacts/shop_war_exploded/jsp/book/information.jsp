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
	<title>我的资料</title>
	<link rel="stylesheet" href="bs/css/bootstrap.css">
	<script type="text/javascript" src="bs/js/jquery.min.js"></script>
	<script type="text/javascript" src="bs/js/bootstrap.js"></script>

	<link rel="stylesheet" type="text/css" href="bs/validform/style.css">
	<script type="text/javascript" src="bs/validform/Validform_v5.3.2_min.js"></script>
	<script type="text/javascript" src="js/book/user_reg_login.js"></script>
	<script type="text/javascript" src="js/book/landing.js"></script>

	<link href="css/book/head_footer.css" rel="stylesheet" type="text/css">
	<link href="css/book/user_reg_login.css" rel="stylesheet" type="text/css">
<script>
	$(function(){
		$(".adminName").mouseover(function(){
			$(".dropdown-menu").css("display","inline-block");
		})
		$(".adminName").mouseout(function(){
			$(".dropdown-menu").css("display","none");
		})
	});
	$(function(){
	var form=$("#editinfoForm").Validform({
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
			ele:"#userPassWord",
			datatype:"*4-8",
			nullmsg:"*请输入密码！",
			errormsg:"要求4-8位字符，请重新输入!"
		},
		{
			ele:"#c_passWord",
			datatype:"*",
			recheck:"userPassWord",
			nullmsg:"*请再次输入密码！",
			errormsg:"两次输入的密码不一致！"
		},
		{
			ele:"#name",
			datatype:"*2-15",
			nullmsg:"请输入姓名！",
			errormsg:"要求2-15个字符,请重新输入！"
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
</script>
<style>
	body {
		background-color: white; /* 设置背景颜色 */
	}
	.wrapper .tab-content {
		width:620px;
	}

	.nav-tabs > li {
		width: 310px;
	}
	.wrapper .main ul li a {
		width: 310px;
	}

</style>
</head>
<body>
<c:if test="${!empty infoList}">
	<c:forEach items="${infoList}" var="i">
		<script type="text/javascript">
			alert("${i}")
		</script>
	</c:forEach>
</c:if>
<%@include file="header.jsp" %>
<div class="container-fullid">
	<div class="wrapper">
		<!-- main start -->
		<div class="main container">
			<div class="title">
				<ul class="nav nav-tabs" id="myTab" style="width: 621px">
					<li role="presentation" class="active"><a href="#tab_information" data-toggle="tab">个人信息</a></li>
					<li role="presentation" ><a href="#tab_editinfo" data-toggle="tab">信息更改</a></li>
<%--					<li role="presentation" ><a href="#tab_reserve" data-toggle="tab">我的预约</a></li>--%>
				</ul>
			</div>

			<div id="myTabContent" class="tab-content">

				<!-- 个人信息修改表单 -->
				<div id="tab_editinfo" class="tab-pane fade">
					<form id="editinfoForm" action="jsp/book/UserEditServlet?action=update" method="post" class="form-horizontal">
						<div class="form-group"style="display: none;">
							<label for="userId" class="col-md-2 control-label"style="width: 100px">密码：</label>
							<div class="col-md-6"style="width: 213px">
								<input type="userId" name="userId" id="userId" class="form-control"value="${userInfo.userId}">
							</div>

						</div>
						<div class="form-group" style="width:95%;margin-left: 90px ">
							<label class="col-md-2  control-label"style="width: 100px">用户名：</label>
							<div class="col-md-6" style="width: 213px">
								<p class="form-control-static">${userInfo.userName}</p>
							</div>
						</div>

						<div class="form-group"style="width:95%;margin-left: 90px ">
							<label for="userPassWord" class="col-md-2 control-label"style="width: 100px">密码：</label>
							<div class="col-md-6"style="width: 213px">
								<input type="userPassWord" name="userPassWord" id="userPassWord" class="form-control"value="${userInfo.userPassWord}">
							</div>
							<div class="col-md-4"style="width: 217px">
								<span class="Validform_checktip">*密码为4~8位字符</span>
							</div>
						</div>

						<div class="form-group"style="width:95%;margin-left: 90px ">
							<label for="c_passWord" class="col-md-2 control-label"style="width: 100px">确认密码：</label>
							<div class="col-md-6"style="width: 213px">
								<input type="password" name="c_passWord" id="c_passWord" class="form-control" value="${userInfo.userPassWord}">
							</div>
							<div class="col-md-4"style="width: 217px">
								<span class="Validform_checktip"></span>
							</div>
						</div>

						<div class="form-group"style="width:95%;margin-left: 90px ">
							<label for="name" class="col-md-2 control-label"style="width: 100px">姓名：</label>
							<div class="col-md-6"style="width: 213px">
								<input type="text" id="name" name="name" class="form-control" value="${userInfo.name}">
							</div>
							<div class="col-md-4"style="width: 217px">
								<span class="Validform_checktip">*请输入您的真实姓名</span>
							</div>
						</div>
						<div class="form-group"style="width:95%;margin-left: 90px ">
							<label class="col-md-2 control-label"style="width: 100px">性别：</label>
							<div class="col-md-6 "style="width: 213px">
								<c:choose>
									<c:when test="${userInfo.sex eq '男'}">
										<label class="radio-inline">
											<input type="radio" name="sex" id="sex" checked="checked" class="pr1" value="男">男
										</label>
										<label class="radio-inline">
											<input type="radio" name="sex"  class="pr1"  value="女">女
										</label>
									</c:when>
									<c:otherwise>
										<label class="radio-inline">
											<input type="radio" name="sex" id="sex" class="pr1" value="男">男
										</label>
										<label class="radio-inline">
											<input type="radio" name="sex" checked="checked"  class="pr1"  value="女">女
										</label>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="form-group"style="width:95%;margin-left: 90px ">
							<label for="age" class="col-md-2 control-label"style="width: 100px">年龄：</label>
							<div class="col-md-6"style="width: 213px">
								<input type="text" id="age" name="age" class="form-control" value="${userInfo.age}">
							</div>
							<div class="col-md-4"style="width: 217px">
								<span class="Validform_checktip"></span>
							</div>
						</div>
						<div class="form-group"style="width:95%;margin-left: 90px ">
							<label for="tell" class="col-md-2 control-label"style="width: 100px">电话：</label>
							<div class="col-md-6"style="width: 213px">
								<input type="text" id="tell" name="tell" class="form-control"value="${userInfo.tell }">
							</div>
							<div class="col-md-4"style="width: 217px">
								<span class="Validform_checktip"></span>
							</div>
						</div>
						<div class="form-group"style="width:95%;margin-left: 90px ">
							<label for="address" class="col-md-2 control-label"style="width: 100px">地址：</label>
							<div class="col-md-6"style="width: 213px">
								<input type="text" id="address" name="address" class="form-control" value="${userInfo.address}">
							</div>
							<div class="col-md-4"style="width: 217px">
								<span class="Validform_checktip"></span>
							</div>
						</div>
						<div class="form-group"style="width:95%;margin-left: 90px ">
							<label class="col-md-2  control-label col-md-offset-2">
								<input class="btn btn-success btn-block" type="submit" value="更新">
							</label>
							<label class="col-md-2 control-label">
								<input class="btn btn-warning btn-block" type="reset" value="重置">
							</label>
						</div>
					</form>
				</div>

				<!-- 个人信息表单 -->
				<div id="tab_information" class="tab-pane fade in active">
					<form id="informationForm" action="InformationServlet?userId=${landing.userId}" method="post" class="form-horizontal">
						<div class="form-group">
							<label class="col-md-4 control-label">用户名：</label>
							<div class="col-md-4" style=" padding-top: 7px;">
								${userInfo.userName}
							</div>
						</div>

						<div class="form-group">
							<label class="col-md-4  control-label">密码：</label>
							<div class="col-md-4" style=" padding-top: 7px; width: 70px;">
<%--								${userInfo.userPassWord}--%>
								<div id="passwordField">******</div>
							</div>
							<button type="button" onclick="togglePasswordVisibility();" style="display: inline-block; margin-left: 5px;">👁</button>
						</div>

						<div class="form-group">
							<label class="col-md-4  control-label">姓名：</label>
							<div class="col-md-6"  style=" padding-top: 7px;">
								${userInfo.name}
							</div>
						</div>

						<div class="form-group">
							<label class="col-md-4  control-label">地址：</label>
							<div class="col-md-6"  style=" padding-top: 7px;">
								${userInfo.address}
							</div>
						</div>

						<div class="form-group">
							<label class="col-md-4  control-label">账户状态：</label>
								<div class="col-md-6"  style=" padding-top: 7px;">
									<c:choose>
										<c:when test="${userInfo.enabled eq 'y'}">
											<span style="background:green;color:#fff">✅启用</span>
										</c:when>
										<c:otherwise>
											<span style="background:#ff7069;color:#fff">❌禁用</span>
										</c:otherwise>
									</c:choose>
								</div>
						</div>

						<div class="form-group">
							<label class="col-md-4  control-label">信誉分：</label>
							<div class="col-md-6"  style=" padding-top: 7px;">
								${userInfo.credit}
							</div>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>

	<%@include file="footer.jsp" %>
</div>
<script>
	var originalPassword = "${userInfo.userPassWord}";
	var isPasswordVisible = false;

	function togglePasswordVisibility() {
		var passwordField = document.getElementById("passwordField");
		if (!isPasswordVisible) {
			passwordField.textContent = ${userInfo.userPassWord};
			isPasswordVisible = true;
		} else {
			passwordField.textContent = "******";
			isPasswordVisible = false;
		}
	}
</script>

<script>
	var ur=location.href; // 获取当前 URL
	var para=ur.split('?')[1]; // 提取 URL 的查询字符串部分
	var type="information"; // 默认值设置

	if(para!=null){
		type=para.split("type=")[1]; // 从查询字符串中提取 'type' 参数的值
	}

	switch (type){
		case 'editinfo':
			$('#myTab a[href="#tab_editinfo"]').tab('show'); // 如果 type 是 'reg'，则显示注册标签页
			break;
		case 'information':
			$('#myTab a[href="#tab_information"]').tab('show'); // 如果 type 是 'login'，则显示登录标签页
			break;

	}
</script>>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();  
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<title>用户修改</title>
	<link rel="stylesheet" href="bs/css/bootstrap.css">
	<script type="text/javascript" src="bs/js/jquery.min.js"></script>
	<script type="text/javascript" src="bs/js/bootstrap.js"></script>
	<link rel="stylesheet" type="text/css" href="bs/validform/style.css">
	<script type="text/javascript" src="bs/validform/Validform_v5.3.2_min.js"></script> 
	<script type="text/javascript" src="js/admin/userManage/userEdit.js"></script>
	<link rel="stylesheet" type="text/css" href="bs/nav/css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="bs/nav/css/htmleaf-demo.css">
	<link rel="stylesheet" type="text/css" href="bs/nav/css/style.css">
</head>
<style type="text/css">
	body{
		background:url("${pageContext.request.contextPath}/images/admin/adit.jpg");
		background-attachment: fixed;
		background-size: cover;
		color: black;
		font-size: small;
	}
	.header {
		background:#2c83cd;
		color:black;
		height:60px;
		padding:0 20px;
	}
	.header .title {
		color:white;
		display:inline-block;
		font-size:24px;
		height:60px;
		line-height:60px;
		padding-left:60px;
		text-decoration:none;
		width:330px;
		margin-left: -70px;
	}
	a {
		text-decoration:none;
	}

	.header .adminName {
		display:inline-block;
		position: absolute;
		top:26px;
		right:50px;
	}
	.threed{
		color: #fafafa;
		letter-spacing: 0;
		text-shadow: 0px 1px 0px #999, 0px 2px 0px #888, 0px 3px 0px #777, 0px 4px 0px #666, 0px 5px 0px #555, 0px 6px 0px #444, 0px 7px 0px #333, 0px 8px 7px #001135 }
	.dropdown-menu{
		margin:0;}
	.login-wrapper {
		background-color: #fff;
		width: 725px;
		height: 551px;
		border-radius: 15px;
		padding: 0 50px;
		position: absolute;
		left: 50%;
		top: 65%;
		transform: translate(-50%, -50%);
	}
</style>
<body>
	<c:if test="${!empty userMessage}">
		<h3 class="text-center">${userMessage}</h3>
	</c:if>
	<div class="header container-fluid">
		<a class="title" href="jsp/admin/main.jsp" >手机商城后台管理系统</a>
		<nav>
			<ul id="main" style="color: white">
				<li>个人信息
					<ul class="drop">
						<div>
							<li><a href="jsp/book/UserEditServlet?action=edit&userId=${userInfo.userId}" >信息查看/修改</a></li>
						</div>
					</ul>
				</li>
				<li>我的订单
					<ul class="drop">
						<div>
							<li><a href="OrderServlet?action=list" >查看订单</a></li>
						</div>
					</ul>
				</li>
				<li>我的上传
					<ul class="drop">
						<div>
							<li><a href="#">查看上传</a></li>
							<li><a href="#" >新增上传</a></li>
						</div>
					</ul>
				</li>
				<li>其他
					<ul class="drop">
						<div>
							<li><a href="UserServlet?action=off">退出登录</a></li>
							<li><a href="jsp/book/index.jsp">返回主页</a></li>
						</div>
					</ul>
				</li>
			</ul>
		</nav>
		<div class="btn-group adminName">
			<button type="button" class="btn btn-default dropdown-toggle">
				${adminUser.userName} <span class="caret"></span>
			</button>
			<ul class="dropdown-menu dropdown-menu-right">
				<li><a href="LoginOutServlet" target="_top" onClick="return confirm('确定要退出系统了么？')">退出登录</a></li>
			</ul>
		</div>
		<h2 class="threed">用户修改</h2>
	</div>
	<div class="login-wrapper" >
	<div class="container" style="padding-right: 450px;    padding-top: 50px;">
		<form id="myForm" action="jsp/book/UserEditServlet?action=update" method="post" class="form-horizontal">
			<input type="hidden" name="userId" value="${userInfo.userId}">
			<div class="form-group">
				<label for="userName" class="col-md-2 col-md-offset-2 control-label">用户名：</label>
				<div class="col-md-4">
					<p class="form-control-static">${userInfo.userName}</p>
				</div>
				
			</div>
			<div class="form-group">
				<label for="passWord" class="col-md-2 col-md-offset-2 control-label">密码：</label>
				<div class="col-md-4">
					<input type="password" name="passWord" id="passWord" class="form-control" value="${userInfo.userPassWord }">
				</div>
				<div class="col-md-4">
					<span class="Validform_checktip"></span>
				</div>
			</div>
			<div class="form-group">
				<label for="c_passWord" class="col-md-2 col-md-offset-2 control-label">确认密码：</label>
				<div class="col-md-4">
					<input type="password" name="c_passWord" id="c_passWord" class="form-control" value="${userInfo.userPassWord }">
				</div>
				<div class="col-md-4">
					<span class="Validform_checktip"></span>
				</div>
			</div>
			<div class="form-group">
				<label for="name" class="col-md-2 col-md-offset-2 control-label">姓名：</label>
				<div class="col-md-4">
					<input type="text" id="name" name="name" class="form-control" value="${userInfo.name }">
				</div>
				<div class="col-md-4">
					<span class="Validform_checktip"></span>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-2 col-md-offset-2 control-label">性别：</label>
				<div class="col-md-4 ">
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
			<div class="form-group">
				<label for="age" class="col-md-2 col-md-offset-2 control-label">年龄：</label>
				<div class="col-md-4">
					<input type="text" id="age" name="age" class="form-control" value="${userInfo.age }">
				</div>
				<div class="col-md-4">
					<span class="Validform_checktip"></span>
				</div>
			</div>
			<div class="form-group">
				<label for="tell" class="col-md-2 col-md-offset-2 control-label">电话：</label>
				<div class="col-md-4">
					<input type="text" id="tell" name="tell" class="form-control" value="${userInfo.tell }">
				</div>
				<div class="col-md-4">
					<span class="Validform_checktip"></span>
				</div>
			</div>
			<div class="form-group">
				<label for="address" class="col-md-2 col-md-offset-2 control-label">地址：</label>
				<div class="col-md-4">
					<input type="text" id="address" name="address" class="form-control" value="${userInfo.address }">
				</div>
				<div class="col-md-4">
					<span class="Validform_checktip"></span>
				</div>
			</div>
			<div class="form-group">
				<label for="enabled" class="col-md-2 col-md-offset-2 control-label">启用状态</label>
				<div class="col-md-4">
					<select class="form-control" name="enabled" id="enabled" disabled>
						<c:choose>
							<c:when test="${userInfo.enabled eq 'y'}">
								<option value="y" selected="selected">启用</option>
								<option value="n">禁用</option>
							</c:when>
							<c:otherwise>
								<option value="y">启用</option>
								<option value="n" selected="selected">禁用</option>
							</c:otherwise>
						</c:choose>
					</select>
					<input type="hidden" name="enabled" value="${userInfo.enabled}" />
				</div>
			</div>
			<div class="bitch" style="margin-left:62px">
				<label class="col-md-2  control-label col-md-offset-2">
					<input class="btn btn-success btn-block" type="submit" value="更改"  style="width: 100px;background-color: #2fa8ec">
				</label>
<%--				<label class="col-md-2 control-label">--%>
<%--					<input class="btn btn-warning btn-block" type="reset" value="重置" style="width: 100px;background-color: #2766ec">--%>
<%--				</label>--%>
			</div>
		</form>
	</div>
	</div>
</body>
<script>
	$(".adminName").mouseover(function(){
		$(".dropdown-menu").css("display","inline-block");
	})
	$(".adminName").mouseout(function(){
		$(".dropdown-menu").css("display","none");
	}	)
</script>
</html>
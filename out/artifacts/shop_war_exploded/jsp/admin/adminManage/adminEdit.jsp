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
	<link rel="stylesheet" href="bs/css/bootstrap.css">
	<script type="text/javascript" src="bs/js/jquery.min.js"></script>
	<script type="text/javascript" src="bs/js/bootstrap.js"></script>
	<link rel="stylesheet" type="text/css" href="bs/validform/style.css">
	<script type="text/javascript" src="bs/validform/Validform_v5.3.2_min.js"></script> 
	<script type="text/javascript" src="js/admin/adminManage/adminEdit.js"></script>
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
		/*font-size: small;*/
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
		padding-left:90px;
		text-decoration:none;
		width:330px;
		/*margin-left: -70px;*/
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
		font: revert-layer;
		font-size: 35px;
		margin-top: 50px;
		text-shadow: 0px 1px 0px #999, 0px 2px 0px #888, 0px 3px 0px #777, 0px 4px 0px #666, 0px 5px 0px #555, 0px 6px 0px #444, 0px 7px 0px #333, 0px 8px 7px #001135 }
	.dropdown-menu{
		margin:0;}
	.login-wrapper {
		background-color: #fff;
		width: 725px;
		height: 382px;
		border-radius: 15px;
		padding: 0 50px;
		position: absolute;
		left: 50%;
		top: 55%;
		transform: translate(-50%, -50%);
	}
</style>
<body>
	<c:if test="${!empty adminMessage}">
		<h3 class="text-center">${adminMessage}</h3>
	</c:if>
	<div class="header container-fluid">
		<a class="title" href="jsp/admin/main.jsp" >手机商城后台管理系统</a>
		<a class="rtitle" style="float:right; margin-top: 18px;" href="jsp/book/index.jsp">返回商城👉</a>
		<nav>
			<ul id="main" style="color: white">
				<li>用户管理
					<ul class="drop">
						<div>
							<li><a href="jsp/admin/AdminManageServlet?action=list" >管理员管理</a></li>
							<li><a href="jsp/admin/UserManageServlet?action=list" >用户管理</a></li>
						</div>
					</ul>
				</li>
				<li>商品管理
					<ul class="drop">
						<div>
							<li><a href="jsp/admin/BookManageServlet?action=list" >商品列表</a></li>
							<li><a href="jsp/admin/CatalogServlet?action=list">分类管理</a></li>
						</div>
					</ul>
				</li>
				<li>订单管理
					<ul class="drop">
						<div>
							<li><a href="jsp/admin/OrderManageServlet?action=list">订单列表</a></li>
							<li><a href="jsp/admin/OrderManageServlet?action=processing" >订单处理</a></li>
						</div>
					</ul>
				</li>
				<li>预约管理
					<ul class="drop">
						<div>
							<li><a href="jsp/admin/ReserveManageServlet?action=list">查看预约</a></li>
							<li><a href="jsp/admin/reserveManage/reserveAdd.jsp">开放预约</a></li>
						</div>
					</ul>
				</li>
				<div id="marker"></div>
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
		<h2 class="threed">管理员修改</h2>
	</div>
	<div class="login-wrapper" >
	<div class="container" style="padding-right: 569px;  background-color: transparent;  padding-top: 40px;font-size: small;">

		<form action="jsp/admin/AdminManageServlet?action=update" method="post" class="form-horizontal" onsubmit="javascript:return checkAdd();" style="padding-top: 20px">
			<!---这里的admininfo 是从adminEdit方法里传来的
			修改按钮→action edit→adminEdit 获取admininfo→跳转adminedit.jsp
			→确定按钮→adminupdate方法-->
			<input type="hidden" name="id" value="${adminInfo.id}">
				<div class="form-group">
					<label for="userName" class="col-sm-2 col-sm-offset-2 control-label">用户名：</label>
					<div class="col-sm-4">
						<span>${adminInfo.userName}</span>
					</div>
				</div>
				<div class="form-group">
					<label for="passWord" class="col-sm-2 col-sm-offset-2 control-label">密码：</label>
					<div class="col-sm-4">
						<input type="password" name="passWord" id="passWord" class="form-control" value="${adminInfo.passWord}">
					</div>
					<div class="col-sm-4">
						<span class="Validform_checktip">密码为4~8位字符</span>
					</div>
				</div>
				<div class="form-group">
					<label for="passWord_ck" class="col-sm-2 col-sm-offset-2 control-label">确认密码：</label>
					<div class="col-sm-4">
						<input type="password" name="passWord_ck" id="passWord_ck" class="form-control" value="${adminInfo.passWord}">
					</div>
					<div class="col-sm-4">
						<span class="Validform_checktip"></span>
					</div>
				</div>
				<div class="form-group">
					<label for="name" class="col-sm-2 col-sm-offset-2 control-label">姓名：</label>
					<div class="col-sm-4">
						<input type="text" id="name" name="name" class="form-control" value="${adminInfo.name}">
					</div>
					<div class="col-sm-4">
						<span class="Validform_checktip">姓名为2~8位字符</span>
					</div>
				</div>
				<div class="bitch" style="margin-left:62px">
					<label class="col-sm-2 col-sm-offset-2 control-label">
						<input class="btn btn-success btn-block" type="submit" value="更新" style="width: 100px;background-color: #2fa8ec">
					</label>
					<label class="col-sm-23 control-label">
						<input class="btn btn-warning btn-block" type="reset" value="重置" style="width: 100px;background-color: #2766ec">
					</label>
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
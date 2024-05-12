<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();  
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
	<meta charset="UTF-8">
	<title>主页</title>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<link rel="stylesheet" href="bs/css/bootstrap.css">
	<script type="text/javascript" src="bs/js/jquery.min.js"></script>
	<script type="text/javascript" src="bs/js/bootstrap.js"></script>
	<link rel="stylesheet" type="text/css" href="bs/nav/css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="bs/nav/css/htmleaf-demo.css">
	<link rel="stylesheet" type="text/css" href="bs/nav/css/style.css">
	<style type="text/css">
		*{
		margin:0;
		padding:0;
		}
		.header {
			background:#2c83cd;
			color:#fff;
			height:60px;
			padding:0 20px;
		}
		.header .title {
			color:#fff;
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
		.dropdown-menu{
			margin:0;
		}

		body{
			font-family:"Microsoft YaHei";
			background:url("${pageContext.request.contextPath}/images/admin/adinx.jpg");
			background-attachment: fixed;
			background-size: cover;
		}
		h2{
			text-align:center;
			position:absolute;
			left:0;
			right:0;
			top:40%;
			color: #ebebeb;
		}
		rtitle{
			float: right;
			font-size: 15px;
		}
	</style>
</head>
<body>
<div class="header container-fluid">
	<a class="title">手机商城后台管理系统</a>
	<a class="rtitle" style="float:right; margin-top: 18px;" href="jsp/book/index.jsp">返回商城👉</a>
	<nav>
		<ul id="main">
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

</div>
	<h2>欢迎你，${adminUser.name}~🥰</h2>
</body>

<script type="text/javascript">
	//点击跳出LoginOut的js
	$(".adminName").mouseover(function(){
		$(".dropdown-menu").css("display","inline-block");
	})
	$(".adminName").mouseout(function(){
		$(".dropdown-menu").css("display","none");
	})
</script>
</html>
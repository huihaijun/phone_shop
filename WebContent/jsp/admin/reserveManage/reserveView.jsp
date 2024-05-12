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
	<meta charset="UTF-8">
	<title>商品详情页</title>
	<link rel="stylesheet" href="bs/css/bootstrap.css">
	<link rel="stylesheet" type="text/css" href="bs/nav/css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="bs/nav/css/htmleaf-demo.css">
	<link rel="stylesheet" type="text/css" href="bs/nav/css/style.css">
	<style type="text/css">
		body{
			background:url("${pageContext.request.contextPath}/images/admin/adit.jpg");
			background-attachment: fixed;
			background-size: cover;
			color: black;

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
			width: 60%;
			height: auto;
			border-radius: 15px;
			padding: 20px 50px;
			position: absolute;
			left: 50%;
			top: 57%;
			transform: translate(-50%, -50%);
		}
		.container .row{
			line-height: 30px;
			htight:30px;
		}
		/* 弹窗的样式 */
		.popup {
			display: none; /* 默认隐藏 */
			position: fixed; /* 固定在屏幕上 */
			height:150px;
			width:500px;
			border-radius: 20px;
			top: 50%; /* 使其垂直居中 */
			left: 50%; /* 使其水平居中 */
			transform: translate(-50%, -50%); /* 居中 */
			background-color: #ffffff;
			padding: 20px;
			border: 1px solid #000000;
			box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
			z-index: 9999; /* 使其位于其他元素之上 */
		}
		.popup h3{
			top: 50%; /* 使其垂直居中 */
			left: 50%; /* 使其水平居中 */
		}
		/* 遮罩层的样式 */
		.overlay {
			display: none;
			position: fixed;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			background-color: rgba(0, 0, 0, 0.5); /* 半透明黑色 */
			z-index: 9998; /* 比弹窗层低一层 */}
		
	</style>
</head>
<body>
<div class="overlay" id="overlay" onclick="closePopup()"></div>

<div class="popup" id="popup">
	<h3 class="text-center" id="popupMessage"></h3>
	<button class="btn-white-text" style="width: 100px; background-color: #2fa8ec;font-size: 14px;
    color:white;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    margin-top: 15px;
    height: 30px;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    background-image: none;
    border: 1px solid transparent;
    border-radius: 4px;"onclick="closePopup()">关闭</button>
</div>

<c:if test="${!empty reserveMessage}">
	<script>
		// 显示弹窗函数
		function openPopup(message) {
			document.getElementById("popupMessage").innerText = message;
			document.getElementById("popup").style.display = "block";
			document.getElementById("overlay").style.display = "block";
		}
		function closePopup() {
			document.getElementById("popup").style.display = "none";
			document.getElementById("overlay").style.display = "none";
		}
	</script>
	<c:choose>
		<c:when test="${!empty reserveMessage}">
			<script>
				openPopup("${reserveMessage}");
			</script>
		</c:when>
	</c:choose>
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
	<h2 class="threed">预约详情</h2>
</div>
<div class="login-wrapper" >
	<div class="container" style="font-size: small;width: 80%">
		<div class="row" style="padding-right: 0px;padding-top: 30px;">
			<div class="col-md-2 text-right"style="font-weight: bold;">日期</div>
			<div class="col-md-10">${date}</div>
		</div>
		<div class="row">
			<div class="col-md-2 text-right"style="font-weight: bold;">时间段</div>
			<div class="col-md-10">${period}</div>
		</div>
		<div class="row">
			<div class="col-md-12 text-left"style="font-weight: bold;">当前时间段预约用户如下：</div>
			<div class="col-md-12">
				<table class="table table-bordered">
					<tr class="info">
						<th class="col-md-2"style="text-align: center;width:10%">用户名</th>
						<th class="col-md-6"style="text-align: center;width:10%">姓名</th>
						<th class="col-md-6"style="text-align: center;width:25%">手机号</th>
						<th class="col-md-2"style="text-align: center;width:10%">状态</th>
						<th class="col-md-2"style="text-align: center;">操作</th>
					</tr>
					<c:forEach items="${viewList}" var="v" varStatus="vs">
						<tr class="pro-list">
								<td>${v.userName}</td>
								<td>${v.name}</td>
								<td>${v.tell}</td>
								<td>
									<c:choose>
									<c:when test="${v.state eq 0}">
										<span style="background:greenyellow;color:#fff">📝已预约</span>
									</c:when>
									<c:when test="${v.state eq 1}">
										<span style="background:green;color:#fff">✅已到店</span>
									</c:when>
									<c:otherwise>
										<span style="background:red;color:#fff">❌已违约</span>
									</c:otherwise>
									</c:choose>
								</td>
								<td>
									<c:choose>
										<c:when test="${v.state eq 0}">
											<a class="btn btn-danger btn-sm" href="jsp/admin/ReserveManageServlet?action=judge&reid=${v.reid}&date=${date}&period=${period}">已到店</a>
										</c:when>
										<c:otherwise>
											<a class="btn btn-danger btn-sm" disabled>已到店</a>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${v.state eq 0}">
											<a class="btn btn-danger btn-sm" href="jsp/admin/ReserveManageServlet?action=judge2&reid=${v.reid}&date=${date}&period=${period}">未到店</a>
										</c:when>
										<c:otherwise>
											<a class="btn btn-danger btn-sm" disabled>未到店</a>
										</c:otherwise>
									</c:choose>
									</td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
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
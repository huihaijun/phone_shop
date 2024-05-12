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
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>新增预约</title>
	<link rel="stylesheet" type="text/css" href="bs/css/bootstrap.css">
	<script type="text/javascript" src="bs/js/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="bs/validform/style.css">
	<script type="text/javascript" src="bs/validform/Validform_v5.3.2_min.js"></script> 
	<script type="text/javascript" src="js/admin/bookManage/bookAdd.js"></script>
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
			font: revert-layer;
			font-size: 35px;
			margin-top: 50px;
			letter-spacing: 0;
			text-shadow: 0px 1px 0px #999, 0px 2px 0px #888, 0px 3px 0px #777, 0px 4px 0px #666, 0px 5px 0px #555, 0px 6px 0px #444, 0px 7px 0px #333, 0px 8px 7px #001135 }

		.dropdown-menu{
			margin:0;}


		.login-wrapper {
			background-color: #fff;
			width: 725px;
			height: 430px;
			border-radius: 15px;
			padding: 0 50px;
			position: absolute;
			left: 50%;
			top: 58%;
			transform: translate(-50%, -50%);
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
			z-index: 9998; /* 比弹窗层低一层 */
		}
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
		<h2 class="threed">新增预约</h2>
		</div>
		<div class="login-wrapper" >
		<div class="container" style="padding-right: 569px;  background-color:transparent; padding-top: 80px;margin-left: 40px;font-size: small">

			<form id="myForm" class="form-horizontal" action="jsp/admin/ReserveManageServlet?action=add" enctype="multipart/form-data">
			<div class="form-group">
				<label for="currentDate" class="col-sm-2 col-sm-offset-2 control-label">今日日期</label>
				<div class="col-sm-4 ">
					<input type="text" name="currentDate" id="currentDate" class="form-control" readonly/>
				</div>
				<div class="col-sm-4 Validform_checktip"></div>
			</div>

			<div class="form-group">
				<label for="date" class="col-sm-2 col-sm-offset-2 control-label">选择日期</label>
				<div class="col-sm-4">
					<input type="date" id="date" name="date" class="form-control" min="" required>
				</div>
				<div class="col-sm-4 Validform_checktip"></div>
			</div>

			<div class="form-group">
				<label for="period" class="col-sm-2 col-sm-offset-2 control-label">选择时间段</label>
				<div class="col-sm-4">
					<select name="period" id="period" class="form-control">
						<option value="10:00-12:00">10:00-12:00</option>
						<option value="14:00-16:00">14:00-16:00</option>
						<option value="16:00-18:00">16:00-18:00</option>
					</select>
				</div>
				<div class="col-sm-4 Validform_checktip"></div>
			</div>


			<div class="form-group">
				<label for="Num" class="col-sm-2 col-sm-offset-2 control-label">设置预约额</label>
				<div class="col-sm-4">
					<input type="number" name="Num" id="Num" class="form-control" min="0" max="10" required/>
				</div>
				<div class="col-sm-4 Validform_checktip"></div>
			</div>
			<div class="form-group" style="margin-left:0px">
					<label class="col-sm-2 col-sm-offset-2 control-label">
						<input class="btn btn-success btn-block" type="submit" value="提交" style="width: 100px;background-color: #2fa8ec">
					</label>
					<label class="col-sm-23 control-label">
						<input class="btn btn-warning btn-block" type="reset" value="重置" style="margin-left: -105px;width: 100px;background-color: #2766ec">
					</label>
				</div>
		</form>
			<div style="color: red;font-size: small;background-color: #fff8bb;">
				⚠*提醒：如想更新某时间段的预约额，请直接输入新的数值重复提交；但为了确保客户体验，一旦想要更新预约额的时间段有人预约，则不予修改！
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
	})
</script>
<script>
	// 获取当前日期
	var currentDate = new Date();
	// 将日期格式化为 YYYY-MM-DD
	var formattedDate = currentDate.getFullYear() + '-' + (currentDate.getMonth() + 1) + '-' + currentDate.getDate();
	// 将格式化后的日期填充到输入框中
	document.getElementById('currentDate').value = formattedDate;
</script>
<script>
	var currentDate = new Date().toISOString().slice(0,10); //2024-04-27  slice  T10:30:00.000Z
	document.getElementById('currentDate').value = currentDate;
	// 设置选择日期输入框的最小值为今天，最大值为五天后
	var selectedDateInput = document.getElementById('date');
	var maxDate = new Date();
	maxDate.setDate(maxDate.getDate() + 5);
	var maxDateString = maxDate.toISOString().slice(0,10);
	selectedDateInput.setAttribute('min', currentDate);
	selectedDateInput.setAttribute('max', maxDateString);
</script>
<script>
	document.getElementById('Num').addEventListener('input', function() {
		var value = parseInt(this.value);
		var isValid = !isNaN(value) && value > 0 && value <= 10;
		if (!isValid) {
			this.setCustomValidity('请输入一个1到10的整数');
		} else {
			this.setCustomValidity('');
		}
	});

</script>
</html>
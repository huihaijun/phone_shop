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
	<title>增加分类</title>
	<link rel="stylesheet" type="text/css" href="bs/css/bootstrap.css">
	<script type="text/javascript" src="bs/js/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="bs/validform/style.css">
	<script type="text/javascript" src="bs/validform/Validform_v5.3.2_min.js"></script>
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
			margin-top: 60px;
			text-shadow: 0px 1px 0px #999, 0px 2px 0px #888, 0px 3px 0px #777, 0px 4px 0px #666, 0px 5px 0px #555, 0px 6px 0px #444, 0px 7px 0px #333, 0px 8px 7px #001135 }
		.dropdown-menu{
			margin:0;}
		.login-wrapper {
			background-color: #fff;
			width: 725px;
			height: 320px;
			border-radius: 15px;
			padding: 0 50px;
			position: absolute;
			left: 50%;
			top: 55%;
			transform: translate(-50%, -50%);
		}
		#catalogAddForm{
			margin-top:30px;
		}
	</style>
	<script type="text/javascript">
		$(function(){
			var form=$("#catalogAddForm").Validform({
				tiptype:2,//validform初始化
			});
			
			form.addRule([
				{
					ele:"#catalogName",
				    datatype:"*2-15",
				    ajaxurl:"jsp/admin/CatalogServlet?action=find",
				    nullmsg:"请输入商品分类名称！",
				    errormsg:"分类名称至少2个字符,最多15个字符！",
				}
			]);
		})
		$(".adminName").mouseover(function(){
			$(".dropdown-menu").css("display","inline-block");
		})
		$(".adminName").mouseout(function(){
			$(".dropdown-menu").css("display","none");
		}	)

	</script>
</head>
<body>

		<c:if test="${!empty catalogMessage}">
			<h3 class="text-center">${catalogMessage}</h3>
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
		<h2 class="threed">新增商品分类</h2>
			</div>
			<div class="login-wrapper" >
				<div class="container" style="padding-right: 569px;  background-color: transparent;  padding-top: 80px;font-size: small;">
		<form id="catalogAddForm" class="form-horizontal" action="jsp/admin/CatalogServlet?action=add" method="post">
			<div class="form-group" style="margin-left:70px">
				<label for="catalogName" class="col-sm-2 col-sm-offset-2 control-label">分类名称</label>
				<div class="col-sm-4 ">
					<input type="text" name="catalogName" id="catalogName" class="form-control"/>
				</div>
				<div class="col-sm-4 Validform_checktip"></div>
			</div>
			<div class="form-group">
					<label class="col-sm-2 col-sm-offset-4 control-label">
						<input class="btn btn-success btn-block" type="submit" value="提交"style="width: 100px;background-color: #2fa8ec">
					</label>
					<label class="col-sm-2 control-label">
						<input class="btn btn-warning btn-block" type="reset" value="重置"style="    margin-left: 50px;width: 100px;background-color: #2766ec">
					</label>
				</div>
		</form>
				</div>
	</div>
</body>
</html>
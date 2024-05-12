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
			width: 1280px;
			height: auto;
			border-radius: 15px;
			padding: 0 50px;
			position: absolute;
			left: 50%;
			top: 70%;
			transform: translate(-50%, -50%);
		}
		.container .row{
			line-height: 30px;
			htight:30px;
		}
		
	</style>
</head>
<body>
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
	<h2 class="threed">订单详情</h2>
</div>
<div class="login-wrapper" style="top: 66%;">
	<div class="container" style="font-size: small;">
		<div class="row"style="padding-right: 0px;    padding-top: 40px;">
			<div class="col-md-2 text-right">订单号</div>
			<div class="col-md-10">${order.orderNum}</div>
		</div>
		<div class="row">
			<div class="col-md-2 text-right">客户id</div>
			<div class="col-md-10">${order.userId}</div>
		</div>
		<div class="row">
			<div class="col-md-2 text-right">客户姓名</div>
			<div class="col-md-10">${order.user.name}</div>
		</div>
		<div class="row">
			<div class="col-md-2 text-right">寄送地址</div>
			<div class="col-md-10">${order.user.address}</div>
		</div>
		<div class="row">
			<div class="col-md-2 text-right">联系方式</div>
			<div class="col-md-10">${order.user.tell}</div>
		</div>
		<div class="row">
			<div class="col-md-2 text-right">订单状态</div>
			<div class="col-md-10">
				<c:if test="${order.orderStatus eq 1 }"><span style="background:dodgerblue;color:#fff;">已提交</span></c:if>
				<c:if test="${order.orderStatus eq 2 }"><span style="background:#ffd52d;color:#fff;">已发货</span></c:if>
				<c:if test="${order.orderStatus eq 3 }"><span style="background:green;color:#fff;">已完成</span></c:if>
				<c:if test="${order.orderStatus eq 4 }"><span style="background:greenyellow;color:#fff;">待处理售后</span></c:if>
				<c:if test="${order.orderStatus eq 5 }"><span style="background:green;color:#fff;">已结单</span></c:if>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12 text-left">订单商品信息</div>
			<div class="col-md-12">
				<table class="table table-bordered">
					<tr class="info">
						<th class="col-md-6">&nbsp;</th>
						<th class="col-md-2">单价</th>
						<th class="col-md-2">数量</th>
						<th class="col-md-2">金额</th>
					</tr>
					<c:forEach items="${order.oItem}" var="i" varStatus="vs">
						<tr class="pro-list">
							<td><img width="50px" class="img-responsive col-md-2"
								src="${i.book.upLoadImg.imgSrc }" alt="" />
								<div class="col-md-8">
									<p>${i.book.bookName}</p>
									<p>${i.book.author}</p>
									<p>${i.book.press}</p>
								</div>
							</td>
							<td>￥<i>${i.book.price}</i></td>
							<td>${i.quantity}</td>
							<c:choose>
								<c:when test="${vs.first}">
									<td style="border:0;border-left:1px solid #ddd;">￥${order.money }</td>
								</c:when>
								<c:otherwise>
									<td style="border:0;border-left:1px solid #ddd;">&nbsp;</td>
								</c:otherwise>
							</c:choose>
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
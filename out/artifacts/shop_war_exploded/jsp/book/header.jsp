<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<script type="text/javascript" src="js/book/fenlei.js"></script>
<style>
	.custom-badge {
	background-color: #f8ac59;
	color: #fff;
	display: inline-block;
	position: absolute;
	top: 9px;
	padding: 5px 10px;
	border-radius: 5px;
	margin-left: 25px;
	}
	.custom-badge:hover {
		background-color: #e76f51;
		transform: scale(1.1);
		transition: background-color 0.3s, transform 0.3s;
	}
</style>
<div class="head">

			<div class="top">
				<div class="container">
					<div class="pull-right">|
						<a href="jsp/admin/login.jsp">后台管理</a>
						<a href="#">网站地图</a>
						</div>
					
					<div class="pull-right">
						<c:choose>
							<c:when test="${empty landing}">
								<div class="top-right">
									HI~
									<a href="jsp/book/reg.jsp?type=login">[登录]</a>
									<a href="jsp/book/reg.jsp?type=reg">[免费注册] </a>
								</div>
							</c:when>
							<c:otherwise>
								<div class="btn-group adminName top-right">
									<a href="javascript:void(0)">
									    ${landing.name} <span class="caret"></span>
									</a>
									<ul class="dropdown-menu dropdown-menu-right">
										<li><a href="OrderServlet?action=list">我的订单</a></li>
										<li><a href="InformationServlet?userId=${landing.userId}">我的资料</a ></li>
										<li><a href="jsp/book/ReserveServlet?action=look&userId=${landing.userId}">我的预约</a ></li>
										<li><a href="UserServlet?action=sell&author=${landing.userName}">我的在售</a ></li>
										<li><a href="UserServlet?action=off" style="border-top:1px #ccc solid"  onClick="return confirm('确定要退出登录了吗？')">退出登录</a ></li>
									</ul>
								</div>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
			<div class="mid container">
				<div class="row">
					<a class="logo col-md-5" href="jsp/book/index.jsp" title="手机商城" style="width: 37.666667%;">
						<img alt="" src="images/logo.png">
						<span>二手手机商城📱</span>
					</a>
					<div class="search col-md-4" style="width: 27.333333%;">
						<div class="input-group">
	     	 				<input type="text" class="form-control" id="searchInput" placeholder="输入要搜索的商品...">
	      					<span class="input-group-btn">
	       						<button class="btn btn-default" type="button" onclick="searchBooks()">Go!</button>
	      					</span>
   						</div>
					</div>
					<div class="shopcart col-md-2 col-md-offset-1" style="margin-left: 19px">
						<a id="uploadIdleBtn" href="javascript:void(0)" onclick="checkLoginBeforeUpload()" style="width:149px;height:34px">
							<span class="glyphicon glyphicon-circle-arrow-up" aria-hidden="true"></span>
							<span>预约送机</span>
							<span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span>
						</a>
						<div class="custom-badge" >
							<span>线下验机获取报价~</span>
						</div>
					</div>

					<div class="shopcart col-md-2 col-md-offset-0">
						<a id="cart" href="jsp/book/cart.jsp"style="width:149px;height:34px">
							<span class="badge num">
								<c:choose>
									<c:when test="${!empty shopCart}">
										${shopCart.getTotQuan()}
									</c:when>
									<c:otherwise>
										0
									</c:otherwise>
								</c:choose>
							</span>
							<span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span>
							<span>购 物 车</span>
							<span class="glyphicon glyphicon-menu-right" aria-hidden="true"></span>
						</a>
					</div>
				</div>
				<div class="navbar">
					<ul class="nav navbar-nav" id="fenlei">
				        <li class="active"><a href="BookList?action=search&bookName=">全部二手机👉 <span class="sr-only">(current)</span></a></li>
			      	</ul>
				</div>
			</div>
		</div>

<script>
	function searchBooks() {
		var bookName = document.getElementById("searchInput").value; // 获取输入的搜索关键词
		console.log("用户搜索词：" + bookName);
		// 发起AJAX请求到后端Servlet，传递搜索关键词
		var xhr = new XMLHttpRequest();
		xhr.open("GET", "BookList?action=search&bookName=" + bookName, true);
		xhr.onreadystatechange = function () {
			// 0: 请求未初始化 - open() 方法还未被调用。
			// 1: 服务器连接已建立 - open() 方法已经被调用，但 send() 方法还未被调用。
			// 2: 请求已接收 - send() 方法已经被调用，请求已经被服务器接收。
			// 3: 请求处理中 - 正在处理请求。
			// 4: 请求已完成，且响应已就绪 - 请求已经完成，且响应已经就绪。
			if (xhr.readyState === 4 && xhr.status === 200) {
			// 200: OK - 请求成功。
			// 404: Not Found - 请求的资源未找到。
			// 500: Internal Server Error - 服务器内部错误。
				xhr.open("GET", "BookList?action=search&bookName=" + bookName, true);
				window.location.href = "BookList?action=search&bookName=" + bookName;
			}
		};
		xhr.send();
	}
	function checkLoginBeforeUpload() {
		// 判断 landing 是否为空，即用户是否已登录
		if (${empty landing}) {
			// 如果未登录，跳转到登录页面
			window.location.href = "jsp/book/reg.jsp?type=login";
		} else {
			// 如果已登录，跳转到上传闲置页面
			window.location.href = "jsp/book/ReserveServlet?action=search&userId=${landing.userId}"
		}
	}
</script>

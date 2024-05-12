<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	pageContext.setAttribute("basePath", basePath);
%>
<!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>我的预约</title>
	<link rel="stylesheet" href="bs/css/bootstrap.css">
	<script type="text/javascript" src="bs/js/jquery.min.js"></script>
	<script type="text/javascript" src="bs/js/bootstrap.js"></script>
	<link href="css/book/user_reg_login.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" type="text/css" href="bs/validform/style.css">
	<script type="text/javascript" src="bs/validform/Validform_v5.3.2_min.js"></script>
	<script type="text/javascript" src="js/book/user_reg_login.js"></script>
	<script type="text/javascript" src="js/book/landing.js"></script>

	<link href="css/book/head_footer.css" rel="stylesheet" type="text/css">
	<link rel="stylesheet" href="css/admin/adminManage/userList.css">

	<style type="text/css">
		body {
			background-color: white; /* 设置背景颜色 */
		}
		.nav-tabs {
			width: 760.5px;
		}
		.wrapper .tab-content {
			width: 65%;}
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
			z-index: 9998} /* 比弹窗层低一层 */

	</style>
</head>
<body>
	<!---xmessage“弹窗”——批量删除、删除、增加成功or失败--->
	<div class="overlay" id="overlay" onclick="closePopup()"></div>
	<div class="popup" id="popup">
		<h3 class="text-center" id="popupMessage"style="color: black"></h3>
		<button class="btn-white-text" style="width: 100px; background-color: #2fa8ec;font-size: 14px;
    color:white;
    display: flex;
    margin: 0 auto;
    justify-content: center;
    align-items: center;
    line-height: 1.42857143;
    text-align: center;
    white-space: nowrap;
    margin-top: 25px;
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

	<c:if test="${!empty userMessage}">
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
			<c:when test="${!empty userMessage}">
				<script>
					openPopup("${userMessage}");
				</script>
			</c:when>
		</c:choose>
	</c:if>


	<c:if test="${!empty infoList}">
		<c:forEach items="${infoList}" var="i">
			<script type="text/javascript">
				alert("${i}")
			</script>
		</c:forEach>
	</c:if>
	<%@include file="header.jsp" %>

	<div class="container-fullid">
		<div class="wrapper"style="margin-left: -140.5px;">
			<!-- main start -->
			<div class="main container">
				<div class="title">
					<ul class="nav nav-tabs" id="myTab">
						<li role="presentation" class="active"><a href="#tab_login" data-toggle="tab">我的预约</a></li>
					</ul>
				</div>
			<div class="container content" style="    padding: 0px 0px;">
				<div id="myTabContent" class="tab-content">
		<table class="table table-striped table-hover">
			<tr class="success" style="border-top: 2px solid black">
				<th style="background-color:#9fc6cd;text-align: center">姓名
				</th>
				<th style="background-color:#9fc6cd;text-align: center">预约日期
				</th>
				<th style="background-color:#9fc6cd;text-align: center">预约时间
				</th>
				<th style="background-color:#9fc6cd;text-align: center">🚥当前状态</th>
				<th class="col-md-3" style="background-color:#9fc6cd;text-align: center">🛠️操  作</th>
			</tr>

			<c:choose>
				<c:when  test="${!empty ureserve}">
					<c:forEach items="${ureserve}" var="i" varStatus="n">
						<tr style="border-top: 2px solid black">
							<!---返回 checkbox 的 value 属性的值 --->
							<td style="text-align: center">${i.name}</td>
							<td style="text-align: center">${i.date}</td>
							<td style="text-align: center">${i.period}</td>
							<td style="text-align: center">
								<c:choose>
									<c:when test="${i.state eq 0}">
										<span style="background:greenyellow;color:#fff">📝已预约</span>
									</c:when>
									<c:when test="${i.state eq 2}">
										<span style="background:red;color:#fff">❌已违约</span>
									</c:when>
									<c:otherwise>
										<span style="background:green;color:#fff">✅已到店</span>
									</c:otherwise>
								</c:choose>
							</td>
							<td style="text-align: center">
								<c:choose>
									<c:when test="${i.state eq 0}">
										<a class="cancel btn btn-danger btn-sm" href="jsp/book/ReserveServlet?action=del&reid=${i.reid}&userId=${i.userid}" onclick="javascript:return confirm('确定要取消吗？');">取消</a></c:when>
									<c:otherwise>
										<button class="cancel btn btn-danger btn-sm" disabled>取消</button>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</c:when>

				<c:otherwise>
					<tr>
						<td colspan="8"><h4 class="text-center">当前无更多用户信息</h4></td>
					</tr>
				</c:otherwise>

			</c:choose>
			<!---若userList不为空，遍历输出userList中的信息--->
		</table>

	<ul class="pager">
		<li><button class="homePage btn btn-default btn-sm">首页</button></li>
		<li><button class="prePage btn btn-sm btn-default">上一页</button></li>
		<li>总共 ${pageBean.pageCount} 页 | 当前第 ${pageBean.curPage} 页</li>
		<li>
			跳转到
			<div class="input-group form-group page-div">
				<input id="page-input" class="form-control input-sm" type="text" name="page"/>
				<span>
					<button  class="page-go btn btn-sm btn-default">GO</button>
				</span>
			</div>
		</li>
		<li><button class="nextPage btn btn-sm btn-default">下一页</button></li>
		<li><button class="lastPage btn btn-sm btn-default">末页</button></li>
	</ul>
	</div>
			</div>
		</div></div>
		<%@include file="footer.jsp" %>
	</div>


<script type="text/javascript">
	//按钮禁用限制
	//在第一页不可以用首页或上一页

	if("${pageBean.curPage}"==1){
		$(".homePage").attr("disabled","disabled");
		$(".prePage").attr("disabled","disabled");
	}
	//在最后一页不可以用下一页和最后一页
	if("${pageBean.curPage}"=="${pageBean.pageCount}"){
		$(".nextPage").attr("disabled","disabled");
		$(".lastPage").attr("disabled","disabled");
	}

	//按钮事件
	//分别为 去主页，去上一页，去下一页，去最后一页
	$(".homePage").click(function(){
		window.location="${basePath}/jsp/book/ReserveServlet?action=look&userId=${landing.userId}&page=1";
	})
	$(".prePage").click(function(){
		window.location="${basePath}/jsp/book/ReserveServlet?action=look&userId=${landing.userId}&page=${pageBean.prePage}";
	})
	$(".nextPage").click(function(){
		window.location="${basePath}/jsp/book/ReserveServlet?action=look&userId=${landing.userId}&page=${pageBean.nextPage}";
	})
	$(".lastPage").click(function(){
		window.location="${basePath}/jsp/book/ReserveServlet?action=look&userId=${landing.userId}&page=${pageBean.pageCount}";
	})
	//控制页面跳转范围
	$(".page-go").click(function(){
		var page=$("#page-input").val();
		var pageCount=${pageBean.pageCount};
		if(isNaN(page)||page.length<=0){
			//没用数字，提醒使用数字页码
			$("#page-input").focus();
			alert("请输入数字页码");
			return;
		}
		//用数字超过最大页数
		if(page > pageCount || page < 1 ){
			alert("输入的页码超出范围！");
			$("#page-input").focus();
		}else{
			window.location="${basePath}/jsp/book/ReserveServlet?action=look&userId=${landing.userId}&page="+page;
		}
	})


	//顶层LOGINOUT按钮显示/隐藏 JS
	$(".adminName").mouseover(function(){
		$(".dropdown-menu").css("display","inline-block");
	})
	$(".adminName").mouseout(function(){
		$(".dropdown-menu").css("display","none");
	})
</script>


</body>
</html>
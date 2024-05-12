<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
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
	<title>手机商城</title>
	<link rel="stylesheet" href="bs/css/bootstrap.css">
	<script type="text/javascript" src="bs/js/jquery.min.js"></script>
	<script type="text/javascript" src="bs/js/bootstrap.js"></script>

	<link rel="stylesheet" type="text/css" href="bs/validform/style.css">
	<script type="text/javascript" src="bs/validform/Validform_v5.3.2_min.js"></script>
	<script type="text/javascript" src="js/book/user_reg_login.js"></script>
	<script type="text/javascript" src="js/book/landing.js"></script>
	<link href="css/book/head_footer.css" rel="stylesheet" type="text/css">
	<link href="css/book/user_reg_login.css" rel="stylesheet" type="text/css">
	<!-- 加载 jQuery 库 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<!-- 加载 jQuery UI 库 -->
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<%--	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>--%>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

	<style type="text/css">
		.wrapper .main {
			width: 80%;
		}
		.form-horizontal .form-group {
			margin-right: 12px;
			margin-left: -15px;
			text-align: left;
			width: 40%;
		}
		/* 添加模糊效果样式 */
		.modal-blur {
			backdrop-filter: blur(5px);

		}
		.homePage,.prePage,.page-go,.nextPage,.lastPage{
			border-radius:15px;
			color:#337ab7;
		}
		.pager{
			padding:0 20px;
		}

		#page-input{
			display:inline-block;
			width:60px;
			border-radius: 10px;
		}
		.bookImg{
			width:50px;
		}
		.funbtn{
			margin:10px 0;
		}
		.funbtn a{
			margin-right:10px;
		}
		.ui-datepicker td span, .ui-datepicker td a{
			text-align: center;
		}
		.modal-backdrop{
			background-color: transparent;
		}
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
				<ul class="nav nav-tabs" id="myTab">
					<li role="presentation" class="active"><a href="#tab_login" data-toggle="tab">预约提交闲置手机</a></li>
				</ul>
			</div>
			<!-- 注册表单 -->
			<div id="myTabContent" class="tab-content">
				<!-- 登录表单 -->
				<div id="tab_login" class="tab-pane fade in active">
					<div class="container content">
						<!-- 左半部分：交互式日历 -->
						<div class="calendar" style="float: left; width: 25%; padding: 20px;">
							<%--			<h2>交互式日历</h2>--%>
							<!-- 用于显示选择的日期 -->
							<div id="datepicker"></div>
<%--							<div style="display: flex; justify-content: space-between; margin-top: 10px;">--%>
<%--								<!-- 右边的按钮 -->--%>
<%--								<button id="listBtn"class=" btn btn-sm btn-default" style="color:#337ab7;border-radius:20px;font-size: 12px;margin:0 auto">清空选择</button>--%>
<%--							</div>--%>
						</div>
						<!-- 右半部分：预约表格 -->
						<div class=class="table-container" style="float: right; width: 70%; padding: 20px;margin-right: 22px; ">
							<%--				<h2>预约表格</h2>--%>
							<table class="table table-striped table-hover" style="border: 1px solid #ccc;border-radius: 10px;">
								<!-- 表头 -->
								<tr class="success" style="border-top: 2px solid black;font-size: medium">
									<!-- 列标题 -->
									<th style="background-color:#9fc6cd;text-align: center">日 期</th>
									<th style="background-color:#9fc6cd;text-align: center">时间段</th>
									<th style="background-color:#9fc6cd;text-align: center">剩余预约额</th>
									<th class="col-md-3" style="background-color:#9fc6cd;text-align: center">🛠️操  作</th>
								</tr>
								<!-- 遍历预约列表 -->
								<c:choose>
									<c:when  test="${!empty reserveList}">
										<c:forEach items="${reserveList}" var="i" varStatus="n">
											<tr style="border-top: 2px solid black;height: 55px;justify-content: center;align-items: center;font-size: large">
												<td style="text-align: center ; justify-content: center;align-items: center;height: 58.43px;">${i.date}</td>
												<td style="text-align: center;height: 58.43px;">${i.period}</td>

												<td style="text-align: center;height: 58.43px;">${i.remnum}</td>

												<td style="text-align: center;height: 58.43px;">
													<c:choose>
														<c:when test="${i.remnum > 0}">
															<button class="btn btn-info btn-sm" style="font-size: medium;"onclick="showReservationModal('${landing.userName}', '${landing.name}','${landing.tell}', '${i.date}', '${i.period}', '${i.remnum}')">预约</button>
														</c:when>
														<c:otherwise>
															<button class="btn btn-info btn-sm" style="font-size: medium;"disabled>预约</button>
														</c:otherwise>
													</c:choose>
													</td>

												<!-- 模态框 -->
												<div class="modal" tabindex="-1" role="dialog" id="reservationModal">
													<div class="modal-dialog" role="document">
														<div class="modal-content">
															<div class="modal-header">
																<h5 class="modal-title">预约信息确认</h5>
																
															</div>
															<div class="modal-body">
																<p>用户名: <span id="username"></span></p>
																<p>姓名: <span id="name"></span></p>
																<p>手机号: <span id="tell"></span></p>
																<p>预约时间: <span id="reservationDate"></span></p>
																<p>预约时间段: <span id="reservationPeriod"></span></p>
																<p>剩余预约额: <span id="remnum"></span></p>
																<p>提示消息: 请注意，预约后请按照规定时间前往指定地点验机，否则会影响信誉等级！</p>
															</div>
															<div class="modal-footer">
																<button type="button" class="btn btn-primary" onclick="confirmReservation()">确定</button>
																<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
															</div>
														</div>
													</div>
												</div>

											</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="8"><h4 class="text-center">当前无更多预约信息</h4></td>
										</tr>
									</c:otherwise>
								</c:choose>
							</table>
						</div>
					</div>
				</div>
				<!-- 操作说明 -->
				<div class="operation-instruction">
					<h4>操作说明：</h4>
					<ol>
						<li>在左侧的日历中点击选择想要预约的日期，然后在右侧的预约信息栏中选择想要预约的时间段。</li>
						<li>如果用户当天已经存在预约，则预约将会失败。若想重新预约，请先进入“我的资料” > “我的预约”处取消预约。</li>
						<li>预约成功后，请按时前往。否则可能会影响用户的信誉等级，从而无法进行预约等操作。</li>
					</ol>
				</div>
			</div>



		</div>
	</div>

	<%@include file="footer.jsp" %>
</div>


<script type="text/javascript">
	/* tab标签显示控制通过url参数 */
	var ur=location.href;
	var para=ur.split('?')[1];
	var type="login";//默认
	if(para!=null){
		type=para.split("type=")[1];
	}
	switch (type){
		case 'reg':
			$('#myTab a[href="#tab_reg"]').tab('show')
			break;
		case 'login':
			$('#myTab a[href="#tab_login"]').tab('show')
			break;
	}

	//验证码
	function reCode(){
		$("#imgCode").prop("src","CodeServlet?action=code&"+new Date().getTime());
	}



</script>
<script>
	// 在页面加载完成后运行以下脚本
	$(document).ready(function() {
		// 将文本框转换为日期选择器
		$("#datepicker").datepicker({
			dateFormat: "yy-mm-dd", // 设置日期格式为yyyy-mm-dd
			minDate: 0, // 限制最小日期为今天
			maxDate: "+5d", // 限制最大日期为今天加上五天
			onSelect: function(dateText) { // 当用户选择日期时触发
				// 将选择的日期值传递到后台处理
				$("#selectedDate").text("当前选择日期：" + dateText);
				window.location.href = "jsp/book/ReserveServlet?action=search&userId=${landing.userId}&date=" + dateText;
			}
		});
	});
	// 点击按钮跳转到列表页面
	$("#listBtn").click(function() {
		window.location.href = "jsp/book/ReserveServlet?action=get&userId=${landing.userId}";
	});
</script>
<script>
	// JavaScript 函数：显示模态框并填充信息
	function showReservationModal(username, name, tell, date, period, remnum) {
		document.getElementById("username").innerText = username;
		document.getElementById("name").innerText = name;
		document.getElementById("tell").innerText = tell;
		document.getElementById("reservationDate").innerText = date;
		document.getElementById("reservationPeriod").innerText = period;
		document.getElementById("remnum").innerText = remnum;

		// document.getElementById("reservationEndTime").innerText = endTime; // 显示结束时间
		$('#reservationModal').modal('show'); // 使用 jQuery 显示模态框
		$('#reservationModal').addClass('modal-blur'); // 添加模糊效果类
	}

	// JavaScript 函数：确认预约操作
	// JavaScript 函数：确认预约操作
	// JavaScript 函数：确认预约操作
	function confirmReservation() {
		// 获取当前日期和时间
		var currentDate = new Date();
		var currentTime = currentDate.getTime();

		// 获取预约日期和时间段
		var reservationDateStr = document.getElementById("reservationDate").innerText;
		var reservationDate = new Date(reservationDateStr);

		// 获取预约时间段的开始时间和结束时间
		var period = document.getElementById("reservationPeriod").innerText;
		var timeRange = period.split("-");
		var startTime = new Date(reservationDateStr + " " + timeRange[0]);
		var endTime = new Date(reservationDateStr + " " + timeRange[1]);

		// 获取剩余预约额
		var remnum = parseInt(document.getElementById("remnum").innerText);

		// 如果预约日期早于当前日期，弹窗提示预约失败
		if (reservationDate.getTime() < currentDate.getTime() && !isSameDay(reservationDate, currentDate)) {
			alert("预约失败：不能预约过去的日期");
			return;
		}

		// 如果当前时间已经超过预约的结束时间，弹窗提示预约失败
		if (currentTime > endTime.getTime()) {
			alert("预约失败：当前时间已经超过预约的时间段");
			return;
		}

		// 如果剩余预约额为0，提示预约额已满
		if (remnum === 0) {
			alert("预约失败：当前预约额已满");
			return;
		}

		// 如果未超过，弹窗提示预约成功
		// alert("预约成功！");
		window.location.href = "jsp/book/ReserveServlet?action=Add&userId=${landing.userId}&userName=${landing.userName}&name=${landing.name}&tell=${landing.tell}&date=" + reservationDateStr +"&period=" + period;
		// 关闭模态框并移除模糊效果类
		$('#reservationModal').modal('hide');
		$('#reservationModal').removeClass('modal-blur');
	}

	// 判断两个日期是否为同一天
	function isSameDay(date1, date2) {
		return date1.getFullYear() === date2.getFullYear() &&
				date1.getMonth() === date2.getMonth() &&
				date1.getDate() === date2.getDate();
	}
	$(function(){
		$(".adminName").mouseover(function(){
			$(".dropdown-menu").css("display","inline-block");
		})
		$(".adminName").mouseout(function(){
			$(".dropdown-menu").css("display","none");
		})
	})
</script>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();  
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
	pageContext.setAttribute("basePath", basePath);
%>
<!-- 在<head>标签中添加jQuery UI的CSS -->
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<base href="${basePath}">
	<meta charset="UTF-8">
	<title>预约管理界面</title>
	<link rel="stylesheet" href="bs/css/bootstrap.css">
	<script type="text/javascript" src="bs/js/jquery.min.js"></script>
	<script type="text/javascript" src="bs/js/bootstrap.js"></script> 
	<link rel="stylesheet" href="css/admin/adminManage/userList.css">
	<link rel="stylesheet" type="text/css" href="bs/nav/css/normalize.css" />
	<link rel="stylesheet" type="text/css" href="bs/nav/css/htmleaf-demo.css">
	<link rel="stylesheet" type="text/css" href="bs/nav/css/style.css">
	<style type="text/css">
		body{
			background:url("${pageContext.request.contextPath}/images/admin/addbg.jpeg");
			background-attachment: fixed;
			background-size: cover;

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
			margin-top: 40px;
			text-shadow: 0px 1px 0px #999, 0px 2px 0px #888, 0px 3px 0px #777, 0px 4px 0px #666, 0px 5px 0px #555, 0px 6px 0px #444, 0px 7px 0px #333, 0px 8px 7px #001135 }
		.dropdown-menu{
			margin:0;
		}
		.ui-datepicker {
			width: 15em;
			padding: .2em .2em 0;
			display: none;
		}
		.ui-datepicker td span, .ui-datepicker td a{
			text-align: center;
		}
	</style>
</head>
<body>
	<!---xmessage“弹窗”——批量删除、删除、增加成功or失败--->
	<c:if test="${!empty userMessage}">
		<h3 class="text-center">${userMessage}</h3>
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

		<h2 class="threed">📜预约管理</h2>

		<div>
		<div class="container content" style="width: 390px;margin-left: 200px;border-radius: 10px;margin-top: 40px;padding: 1px 40px 0 40px;float: left;">
			<!-- 左半部分：交互式日历 -->
			<div class="calendar" style=" width: 100%; padding: 30px;">
			<!-- 用于显示选择的日期 -->
			<div id="datepicker"></div>
			<div style="display: flex; justify-content: center; margin-top: 25px;">
				<!-- 按钮 -->
				<button id="listBtn" class=" btn btn-sm btn-default" style="color:#337ab7;border-radius:20px;font-size: 12px">清空选择</button>
			</div>
		</div>
		</div>

		<div class="container content"  style="float: right;width: 660px;margin-right: 166px;border-radius: 10px;margin-top: 40px;padding: 1px 40px 0 40px;">
			<!-- 右半部分：预约表格 -->
			<div class=class="table-container" style=" width: 100%; padding: 30px 30px 0px 30px;">
<%--				<h2>预约表格</h2>--%>
				<table class="table table-striped table-hover">
					<!-- 表头 -->
					<tr class="success" style="border-top: 2px solid black">
						<!-- 列标题 -->
						<th style="background-color:#9fc6cd;text-align: center">日 期</th>
						<th style="background-color:#9fc6cd;text-align: center">时间段</th>
						<th style="background-color:#9fc6cd;text-align: center">预约额</th>
						<th style="background-color:#9fc6cd;text-align: center">已预约人数</th>
						<th class="col-md-3" style="background-color:#9fc6cd;text-align: center">🛠️操  作</th>
					</tr>
					<!-- 遍历预约列表 -->
					<c:choose>
						<c:when  test="${!empty reserveList}">
							<c:forEach items="${reserveList}" var="i" varStatus="n">
								<tr style="border-top: 2px solid black">
									<td>${i.date}</td>
									<td>${i.period}</td>
									<td>${i.num}</td>
									<td>${i.nownum}</td>
									<td>
										<c:choose>
											<c:when test="${i.nownum ne 0}">
												<a class="btn btn-info btn-sm" href="jsp/admin/ReserveManageServlet?action=view&date=${i.date}&period=${i.period}">查看</a >
											</c:when>
											<c:otherwise>
												<button class="btn btn-info btn-sm" disabled>查看</button>
											</c:otherwise>
										</c:choose>
									</td>
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
				<!-- 分页器 -->
				<ul class="pager">
					<li><button class="homePage btn btn-default btn-sm">首页</button></li>
					<li><button class="prePage btn btn-sm btn-default">上一页</button></li>
					<li style=" font-size: small">共${pageBean.pageCount}页|当前第${pageBean.curPage}页</li>
					<li style=" font-size: small">

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
		window.location="${basePath}jsp/admin/ReserveManageServlet?action=list&page=1";
	})
	$(".prePage").click(function(){
		window.location="${basePath}jsp/admin/ReserveManageServlet?action=list&page=${pageBean.prePage}";
	})
	$(".nextPage").click(function(){
		window.location="${basePath}jsp/admin/ReserveManageServlet?action=list&page=${pageBean.nextPage}";
	})
	$(".lastPage").click(function(){
		window.location="${basePath}jsp/admin/ReserveManageServlet?action=list&page=${pageBean.pageCount}";
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
			window.location="${basePath}jsp/admin/ReserveManageServlet?action=list&page="+page;
		}
	})
	
	//批量选中
	$("#batDelChoice").change(function(){
		//.prop("checked")用来获取值 取值为true/false
		//.prop("checked"，true/false)用来设置值"checked"
		//如果不是全部被选中,就把所有name='choice'都选中
		if(!$("input[name='choice']").prop("checked")){
			$(this).prop("checked",true);
			$("input[name='choice']").prop("checked",true);
			
		}else{
			// 如果是全部被选中,就把所有name='choice'都不选
			$(this).removeProp("checked");
			$("input[name='choice']").removeProp("checked");
		}	
	})
	
	
	//批量删除
	$("#batDel").click(function(){
		var choices=$("input:checked[name='choice']");
		var ids="";
		for(i=0;i<choices.length;i++){
			if(i!=choices.length-1){
				//循环 获取选中的行中的value值至ids里面（即用户/管理/商品/分类的id）
				//方便dao层批量删除执行语句时使用
				ids+=choices.eq(i).val()+",";
			}else{
				ids+=choices.eq(i).val();
			}
		}
		if(ids==""){
			alert("请勾选要删除的内容！");
			return;
			
		}
		if(confirm("你确定要删除"+choices.length+"条用户吗？")){
			window.location="${basePath}jsp/admin/ReserveManageServlet?action=batDel&ids="+ids;
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
		<script>
		// 在页面加载完成后运行以下脚本
		$(document).ready(function() {
			// 将文本框转换为日期选择器
			$("#datepicker").datepicker({
				dateFormat: "yy-mm-dd", // 设置日期格式为yyyy-mm-dd
				onSelect: function(dateText) { // 当用户选择日期时触发
					// 将选择的日期值传递到后台处理
					$("#selectedDate").text("当前选择日期：" + dateText);

					window.location.href = "jsp/admin/ReserveManageServlet?action=search&date=" + dateText;
				}
			});
		});

		// 点击按钮跳转到列表页面
		$("#listBtn").click(function() {
			window.location.href = "jsp/admin/ReserveManageServlet?action=list";
		});


	</script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	</div>
</body>
</html>
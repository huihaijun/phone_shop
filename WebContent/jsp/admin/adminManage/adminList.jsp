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
	<meta charset="UTF-8">
	<title>用户管理界面</title>
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
	<!---xmessage“弹窗”——批量删除、删除、增加成功or失败--->
	<div class="overlay" id="overlay" onclick="closePopup()"></div>

	<div class="popup" id="popup">
		<h3 class="text-center" id="popupMessage"style="color: black"></h3>
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

	<c:if test="${!empty adminMessage}">
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
			<c:when test="${!empty adminMessage}">
				<script>
					openPopup("${adminMessage}");
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

		<!---用户名显示&登出--->
		<div class="btn-group adminName">
			<button type="button" class="btn btn-default dropdown-toggle">
				${adminUser.userName} <span class="caret"></span>
			</button>
			<ul class="dropdown-menu dropdown-menu-right">
				<li><a href="LoginOutServlet" target="_top" onClick="return confirm('确定要退出系统了么？')">退出登录</a></li>
			</ul>
		</div>

		<h2 class="threed">👨🏻‍💻管理员用户列表</h2>

		<div class="container content" style="width: 1100px;margin-left: 200px;border-radius: 10px;margin-top:40px;padding: 1px 40px 0 40px;">
		<div class="funbtn">
			<a id="batDel" class="btn btn-danger" href="javascript:void(0)" >批量删除</a>
			<a class="btn btn-info" href="jsp/admin/adminManage/adminAdd.jsp">新增用户</a>
		</div>

		<table class="table table-striped table-hover">
			<tr class="success" style="border-top: 2px solid black">
				<th style="background-color:#9fc6cd;text-align: center">
					<input type="checkbox" id="batDelChoice">
					<label for="batDelChoice"> 全/反选</label>
				</th>
				<th style="background-color:#9fc6cd;text-align: center">id</th>
				<th style="background-color:#9fc6cd;text-align:center">用户名</th>
				<th style="background-color:#9fc6cd;text-align:center">密   码</th>
				<th style="background-color:#9fc6cd;text-align:center">姓   名</th>
				<th style="background-color:#9fc6cd;text-align:center">🕘最 后 登 录 时 间</th>
				<th style="background-color:#9fc6cd;text-align:center">🛠️操   作</th>
			</tr>

			<!---若adminList不为空，遍历输出adminList中的信息--->
			<c:choose>
				<c:when test="${!empty adminList}">
					<c:forEach items="${adminList}" var="i" >
						<tr style="border-top: 2px solid black">
							<!---返回 checkbox 的 value 属性的值 --->
							<td><input type="checkbox" name="choice" value="${i.id}"></td>
							<td>${i.id}</td>
							<td>${i.userName}</td>
							<td>${i.passWord}</td>
							<td>${i.name}</td>
							<td>${i.lastLoginTime}</td>
							<td>
								<a class="btn btn-info btn-sm" href="jsp/admin/AdminManageServlet?action=edit&id=${i.id}">修改</a>
								<a class="btn btn-danger btn-sm" href="jsp/admin/AdminManageServlet?action=del&id=${i.id}" onclick="javascript:return confirm('确定要删除吗？');">删除</a>
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
		</table>

			<!---页面跳转模块--->
	<ul class="pager"style="margin: 5px 0;">
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

	//按钮事件 分别为 去主页，去上一页，去下一页，去最后一页
	$(".homePage").click(function(){
		window.location="${basePath}jsp/admin/AdminManageServlet?action=list&page=1";
	})
	$(".prePage").click(function(){
		window.location="${basePath}jsp/admin/AdminManageServlet?action=list&page=${pageBean.prePage}";
	})
	$(".nextPage").click(function(){
		window.location="${basePath}jsp/admin/AdminManageServlet?action=list&page=${pageBean.nextPage}";
	})
	$(".lastPage").click(function(){
		window.location="${basePath}jsp/admin/AdminManageServlet?action=list&page=${pageBean.pageCount}";
	})

	//控制页面跳转范围的js
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
		}else{//实现跳转
			window.location="${basePath}jsp/admin/AdminManageServlet?action=list&page="+page;
		}
	})
	
	//批量选中js
	// $("#batDelChoice").change(function(){
	// 	//.prop("checked")用来获取值 取值为true/false
	// 	//.prop("checked"，true/false)用来设置值"checked"
	// 	//如果不是全部被选中,就把所有name='choice'都选中
	// 	if(!$("input[]").prop("checked")){
	// 		$(this).prop("checked",true);
	// 		$("input[name='choice']").prop("checked",true);
	// 	}else{
	// 		// 如果是全部被选中,就把所有name='choice'都不选
	// 		$(this).removeProp("checked");
	// 		$("input[name='choice']").removeProp("checked");
	// 	}
	// })

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
	//批量删除js
	$("#batDel").click(function(){
		//所有选中的
		var choices=$("input:checked[name='choice']");
		//用逗号隔开，便于执行sql语句
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
		//如果勾选为空，则蹦出弹框
		if(ids==""){
			alert("请勾选要删除的内容！");
			return;
		}
		if(confirm("你确定要删除"+choices.length+"条用户吗？")){
			//执行dao层语句
			window.location="${basePath}jsp/admin/AdminManageServlet?action=batDel&ids="+ids;
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
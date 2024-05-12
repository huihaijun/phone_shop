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
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>在此处插入标题</title>
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<style>
		*{
			padding: 0;
			margin:0;
		}
		a{
			text-decoration: none;
		}
		body{
			font-family: "Microsoft YaHei";
			background:#aed9ff;
		}
		.left{
			position: absolute;
			left: 0;
			top: 30px;
			width: 200px;
			background:#eee;
			display: block;
			margin:0 5px;
			border-radius: 0 15px 0 0;
		}

		.nowTime{
			font-size:16px;
			height:30px;
			background:#eee;
			line-height: 30px;
			text-align: center;
			color: #4894ff;
		}

		.left ul .list{
			list-style: none;
			text-align: center;
			border-top:6px #aed9ff solid;

		}
		.left ul .list a{
			display: block;
			width: 100%;
			height: 40px;
			line-height: 40px;
			color: #000;
			font-size: 18px;
			border-bottom: 1px #144d63 solid;
		}
		.left .list h3{
			line-height: 40px;
			height: 40px;
			color:#fff;
			font-size: 22px;
			background:#000000;
		}

		.left .list h3:hover{
			cursor: pointer;
			color: #2050bc;
		}
		.left ul .list a:hover{
			color: #357ebc;
			background: #ccc;
		}
	</style>
</head>
<body>
	<div class="nowTime"></div>
	<div class="left">
		<ul>
			<li class="list">
				<h3>用 户 管 理</h3>
				<ul>
					<li><a href="jsp/admin/AdminManageServlet?action=list" >管理员管理</a></li>
					<li><a href="jsp/admin/UserManageServlet?action=list" >用户管理</a></li>
				</ul>
			</li>
			<li class="list">
				<h3>商 品 管 理</h3>
				<ul>
					<li><a href="jsp/admin/BookManageServlet?action=list" >商品列表</a></li>
					<li><a href="jsp/admin/CatalogServlet?action=list">分类管理</a></li>
				</ul>
			</li>
			
			<li class="list">
				<h3>订 单 管 理</h3>
				<ul>
					<li><a href="jsp/admin/OrderManageServlet?action=list" >订单列表</a></li>
					<li><a href="jsp/admin/OrderManageServlet?action=processing" >订单处理</a></li>
				</ul>
			</li>
					
		</ul>
	</div>
	<script type="text/javascript">
	/* 菜单切换展开 */
		$(".list h3").next().slideUp(300);
		$(".list h3").click(function(){
			$(".list h3").css("color","#fff");
			$(".list h3").next().slideUp(300);  
			if($(this).next().css("display")=="none"){
				$(this).css("color","#2359bc");
				$(this).next().slideDown(300);
			}else{
				$(this).next().slideUp(300);
			}
		})
		
		$(".list ul a").click(function(){
			$(".list ul a").css("color","#000");
			$(this).css("color","#3198bc");
		})


	</script>
</body>
</html>
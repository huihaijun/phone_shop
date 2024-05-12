<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>后台登录</title>
<style>
	body, p, div, ul, li, h1, h2, h3, h4, h5, h6 {
		margin: 0;
		padding: 0;
	}
	#login {
		width: 400px;
		height: 250px;
		background: rgba(255, 255, 255, 0.3);
		margin: 200px auto 0;
		position: relative;
		border-radius: 10px;
	}

	#title {
		text-align: center;
		position: absolute;
		left: 40px;
		right: 0;
		top: 70px;
		font-size: 36px;
		color: #fff;
	}

	#login form p {
		text-align: center;
	}

	#userName {
		background: url(${pageContext.request.contextPath}/images/login/user.png) rgba(255, 255, 255, 0.7)
		no-repeat;
		width: 200px;
		height: 30px;
		border: solid #ccc 1px;
		border-radius: 3px;
		padding-left: 32px;
		margin-top: 50px;
		margin-bottom: 30px;
	}

	#passWord {
		background: url(${pageContext.request.contextPath}/images/login/pwd.png) rgba(255, 255, 255, 0.7) no-repeat;
		width: 200px;
		height: 30px;
		border: solid #ccc 1px;
		border-radius: 3px;
		padding-left: 32px;
		margin-bottom: 30px;
	}

	#submit {
		width: 232px;
		height: 30px;
		background: rgba(255, 255, 255, 0.7);
		border: solid #ccc 1px;
		border-radius: 3px;
	}

	#submit:hover {
		cursor: pointer;
		background: rgba(75, 81, 123, 0.42);
	}
</style>
<script type="text/javascript">
	function checkForm(){
		//实际发挥输入为空报错的js
		var userName=document.getElementById("userName");
		var passWord=document.getElementById("passWord");
		if(userName.value.length<=0){
			alert("请输入用户名！");
			userName.focus();
			return false;}
		if(passWord.value.length<=0){
			alert("请输入密码！");
			passWord.focus();
			return false;}
		return true;
	}
</script>
</head>

<body background="${pageContext.request.contextPath}/images/login/back.jpg"style="background-attachment: fixed;background-size: cover">

<!---接受来自servlet的infolist--->
<c:if test="${!empty infoList}">
	<c:forEach items="${infoList}" var="i">
		<script type="text/javascript">
			//输出用户名/密码错误的窗体
			alert("${i}")
		</script>
	</c:forEach>
</c:if>

	<h1 id="title">手机商城后台管理系统&nbsp;</h1>
	<div id="login">

		<form action="jsp/admin/LoginServlet" method="post"
			onsubmit="javascript:return checkForm()">
			<p>
				<input type="text" name="userName" id="userName" placeholder="用户名">
			</p>
			<p>
				<input type="password" name="passWord" id="passWord" placeholder="密码">
			</p>
			<p>
				<input type="submit" id="submit" value="登 录">
			</p>
		</form>

	</div>
</body>
</html>
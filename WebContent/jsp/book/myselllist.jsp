<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	pageContext.setAttribute("basePath", basePath);
%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<base href="${basePath}">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的在售</title>
<link rel="stylesheet" href="bs/css/bootstrap.css">
<script type="text/javascript" src="bs/js/jquery.min.js"></script>
<script type="text/javascript" src="bs/js/bootstrap.js"></script>		
<script type="text/javascript" src="js/book/landing.js"></script>
<link href="css/book/head_footer.css" rel="stylesheet" type="text/css">
<style type="text/css">
	.wrapper{
		min-height:500px;
	}
	/* 分页样式 */
	.wrapper .pager{
		border-top:1px #eee solid;
		padding-top:15px; 
	}
	.wrapper .pager .page-div{
		display: inline-block;
		width:110px;
	}
	.wrapper .homePage,.wrapper .prePage,.wrapper .page-go,.wrapper .nextPage,.lastPage{
		border-radius:15px;
		color:#d7006d;
	}
	
	
	.wrapper #page-input{
		display:inline-block;
		width:60px;
		border-radius: 10px;
	}
	.wrapper .bookImg{
		width:50px;
	}
	.wrapper .funbtn{
		margin:10px 0;
	}
	.wrapper .funbtn a{
		margin-right:10px;
	}
	.table-bordered {
		width: auto;
	}

</style>	

</head>
<body>
	<div class="container-fullid">
		<%@include file="header.jsp" %>
		<div class="wrapper">
			<div class="main container">
				<h2>全部在售</h2>
				<table class="table table-bordered">
					<thead>
						<tr class="info" >
							<th style="width:626.5px;text-align: center">商品名</th>
<%--							<th style="width:20%;text-align: center">商品名</th>--%>
							<th style="text-align: center;width: 82px;">价格</th>
							<th style="text-align: center;width: 200px;">添加时间</th>
							<th style="text-align: center;width: 110px;">交易状态</th>
							<th style="width:115px;text-align: center">商品操作</th>
						</tr>
					</thead>
					<c:choose>
						<c:when test="${!empty sellList}">
<%--							varStatus="n"       --%>
							<c:forEach items="${sellList}" var="i" >
								<tbody style="margin-top: 10px;">
										<c>
											<td>
												<img class="img-responsive col-md-2" style="width: 120px;" src="${i.upLoadImg.imgSrc}" alt="" />
												<span>${i.bookName}</span>
											</td>
											<td style="text-align: center">￥${i.price}</td>
											<td style="text-align: center">${i.addTime}</td>
											<td style="text-align: center">
												<c:if test="${i.state eq 0}"><p>在售中</p></c:if>
												<c:if test="${i.state eq 1}"><p>交易中</p></c:if>
												<c:if test="${i.state eq 2}"><p>交易完成待提现<p></c:if>
												<c:if test="${i.state eq 3}"><p>提现已完成<p></c:if>
												<c:if test="${i.state eq 4}"><p>商品已下架<p></c:if>
											</td>

											<c:choose>
												<c:when test="${i.state eq 0}" >
													<td style="border-bottom: 0;text-align: center">
														<a href="UserServlet?action=remove&id=${i.bookId}&author=${landing.userName}" class="btn btn-sm btn-success" onclick="confirm('您确认下架吗？')">不想卖了</a>
													</td>
												</c:when>
												<c:when test="${i.state eq 4}" >
													<td style="border-bottom: 0;text-align: center">
														<a href="UserServlet?action=reup&id=${i.bookId}&author=${landing.userName}" class="btn btn-sm btn-success" onclick="confirm('您确认重新上架吗？')">重新上架</a>
													</td>
												</c:when>
												<c:when test="${i.state eq 2}" >
													<td style="border-bottom: 0;text-align: center">
														<a href="UserServlet?action=payout&id=${i.bookId}&author=${landing.userName}" class="btn btn-sm btn-success" onclick="confirm('您确认提现吗？')">提现</a>
													</td>
												</c:when>
												<c:otherwise>
													<td style="border-bottom: 0;text-align: center"><a>无可进行操作</a></td>
												</c:otherwise>
										</c:choose>

										</tr>
								</tbody>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tbody>
								<tr><td colspan="6"><h2 class="text-center">还没有发布商品呢！</h2></td></tr>
							</tbody>
						</c:otherwise>
					</c:choose>
				</table>
				<!-- 分页按钮 -->
				<ul class="pager row">
					<li><button class="homePage btn btn-default btn-sm">首页</button></li>
					<li><button class="prePage btn btn-sm btn-default">上一页</button></li>
					<li>总共 ${pageBean.pageCount} 页 | 当前 ${pageBean.curPage} 页</li>
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

		<%@include file="footer.jsp" %>
	</div>


<script type="text/javascript">
	//按钮禁用限制
	if("${pageBean.curPage}"==1){
		$(".homePage").attr("disabled","disabled");
		$(".prePage").attr("disabled","disabled");
	}

	if("${pageBean.curPage}"=="${pageBean.pageCount}"){
		$(".page-go").attr("disabled","disabled");
		$(".nextPage").attr("disabled","disabled");
		$(".lastPage").attr("disabled","disabled");
	}
	//按钮事件
	$(".homePage").click(function(){
		window.location="${bsePath}OrderServlet?action=list&page=1";
	})
	$(".prePage").click(function(){
		window.location="${basePath}OrderServlet?action=list&page=${pageBean.prePage}";
	})
	$(".nextPage").click(function(){
		
		window.location="${basePath}OrderServlet?action=list&page=${pageBean.nextPage}";
	})
	$(".lastPage").click(function(){
		window.location="${basePath}OrderServlet?action=list&page=${pageBean.pageCount}";
	})
	//控制页面跳转范围
	$(".page-go").click(function(){
		var page=$("#page-input").val();
		var pageCount=${pageBean.pageCount};
		if(isNaN(page)||page.length<=0){
			$("#page-input").focus();
			alert("请输入数字页码");
			return;
		}
		if(page > pageCount || page < 1 ){
			alert("输入的页码超出范围！");
			$("#page-input").focus(); 
		}else{
			window.location="${basePath}OrderServlet?action=list&page="+page;
		}
	}) 
	
		
		
</script>
</body>
</html>
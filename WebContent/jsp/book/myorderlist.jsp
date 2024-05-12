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
<title>订单提交成功</title>
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
	

</style>	

</head>
<body>
	<div class="container-fullid">
		<%@include file="header.jsp" %>
		<div class="wrapper">
			<div class="main container">
				<h2>全部订单</h2>
				<table class="table table-bordered">
					<thead>
						<tr class="info" >
							<th style="width:55%;text-align: center">商品</th>
							<th style="text-align: center">单价</th>
							<th style="text-align: center">数量</th>
							<th style="width:14.04%;text-align: center">商品操作</th>
							<th style="text-align: center">实付款</th>
							<th style="text-align: center">交易状态</th>
						</tr>
					</thead>
					<c:choose>
						<c:when test="${!empty orderList }">
							<c:forEach items="${orderList}" var="order" varStatus="varstatus">
								<c:if test="${!varstatus.first}"><tbody><tr><td colspan="6">&nbsp;</td></tr></tbody> </c:if>
								<tbody style="margin-top: 10px;">
									<tr class="active">
										<td>订单日期：${order.orderDate}</td>
										<td colspan="5">订单号：${order.orderNum }</td>
									</tr>
									<c:forEach items="${order.oItem}" var="oit" varStatus="vs">
										<tr>
											<td>
												<img class="img-responsive col-md-2" src="${oit.book.upLoadImg.imgSrc}" alt="" />
												<span class="col-md-10">${oit.book.bookName}</span>
											</td>
											<td>￥${oit.book.price}</td>
											<td>${oit.quantity}</td>
											<c:choose>
												<c:when test="${vs.first}">
													<c:choose>
														<c:when test="${order.orderStatus eq 1}" >
															<td style="border-bottom: 0"><a>请等待发货</a></td>
														</c:when>
														<c:when test="${order.orderStatus eq 2}" >
															<td style="border-bottom: 0">
															<a href="OrderServlet?action=confirm&id=${order.orderId}" class="btn btn-sm btn-success" onclick="return confirm('您确认收货吗？')">确认收货</a>
<%--															<a href="OrderServlet?action=refund&id=${order.orderId}" class="refund btn btn-sm btn-success">申请退货</a>--%>
															<a href="#" class="refund btn btn-sm btn-success" data-orderid="${order.orderId}" data-ordernum="${order.orderNum}">申请退货</a>

															</td>
														</c:when>
														<c:otherwise>
															<td style="border-bottom: 0"><a>无可进行操作</a></td>
														</c:otherwise>
													</c:choose>
													<td style="border:0;border-left:1px solid #ddd;">￥${order.money }</td>
													<td style="border:0;border-left:1px solid #ddd;">
													<c:if test="${order.orderStatus eq 1}"><p>订单已提交</p></c:if>
													<c:if test="${order.orderStatus eq 2}"><p>已发货</p></c:if>
													<c:if test="${order.orderStatus eq 3}"><p>订单已完成<p></c:if>
													<c:if test="${order.orderStatus eq 4}"><p>售后处理中<p></c:if>
													<c:if test="${order.orderStatus eq 5}"><p>售后已完成<p></c:if>
												</c:when>
												<c:otherwise>
													<td style="border:0;border-left:1px solid #ddd;">&nbsp</td>
													<td style="border:0;border-left:1px solid #ddd;">&nbsp</td>
													<td style="border:0;border-left:1px solid #ddd;">&nbsp</td>
												</c:otherwise>
											</c:choose>

										</tr>
									</c:forEach>
								</tbody>
								
							</c:forEach>
						</c:when>
						<c:otherwise>
							<tbody>
								<tr><td colspan="6"><h2 class="text-center">还没有订单呢！</h2></td></tr>
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
	<div class="modal fade" id="returnModal" tabindex="-1" role="dialog" aria-labelledby="returnModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="returnModalLabel">申请退货</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<textarea id="returnReason" class="form-control" rows="3" style="resize: vertical;" placeholder="请输入申请理由"></textarea>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-primary" id="confirmReturn">确定</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function() {
			// 当点击“申请退货”时，显示模态框
			$(".refund").click(function(event) {
				event.preventDefault(); // 阻止默认链接行为
				var orderId = $(this).data("orderid"); // 获取订单ID
				var orderNum = $(this).data("ordernum"); // 获取订单编号
				$("#returnModal").data("orderid", orderId); // 将订单ID存储在模态框中
				$("#returnModalLabel").text("申请退货 - 订单编号：" + orderNum); // 在模态框标题中显示订单编号
				$("#returnModal").modal("show"); // 显示模态框
			});
			// 当在模态框中点击“确定”时
			$("#confirmReturn").click(function() {
				var reason = $("#returnReason").val().trim();
				if (reason === "") {
					alert("请输入申请理由");
					return;
				}
				var orderId = $("#returnModal").data("orderid"); // 获取存储在模态框中的订单ID
				// 重定向到指定 URL，带上订单 ID 和申请理由
				window.location.href = "OrderServlet?action=refund&id=" + orderId + "&reason=" + encodeURIComponent(reason);
				alert("申请售后成功！");
			});
			// 当申请退货成功后，显示提示窗口
		});
	</script>

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
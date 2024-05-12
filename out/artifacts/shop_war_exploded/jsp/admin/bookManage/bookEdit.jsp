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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>商品修改</title>
    <link rel="stylesheet" type="text/css" href="bs/css/bootstrap.css">
    <script type="text/javascript" src="bs/js/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="bs/validform/style.css">
    <script type="text/javascript" src="bs/validform/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="js/admin/bookManage/bookAdd.js"></script>
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
            width: 725px;
            height: 551px;
            border-radius: 15px;
            padding: 0 50px;
            position: absolute;
            left: 50%;
            top: 65%;
            transform: translate(-50%, -50%);
        }
        #bookAddForm{
        	margin-top:20px;
        }
        #imgForm,.img-box{
        	display:inline-block;
        }

        .row{
        	margin-top:10px;
        }
    </style>
</head>
<body>

    <c:if test="${!empty bookMessage}">
        <h3 class="text-center">${bookMessage}</h3>
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
    <h2 class="threed">商品修改</h2>
    </div>
    <div class="login-wrapper" style="margin-top: 22px;">
    <div class="container" style="padding-right: 450px;  background-color: transparent;  padding-top: 40px;font-size: small;">
            <div class="row">
    	<div class="col-sm-2 col-sm-offset-2 text-right"style="font-weight: bold;margin-top: 40px;">商品图片</div>
    	<div class="col-sm-4 "style="border: 2px solid #ccc;border-radius: 7px;">
    		<div class="img-box" onclick="javascript:upImg()">
    			<img alt="" height="100px" src="${bookInfo.upLoadImg.imgSrc}" >
    		</div>
    		<span id="imgSpan"style="color:grey;">     点击图片更改图片</span>
    		<form id="imgForm" action="jsp/admin/BookManageServlet?action=updateImg&id=${bookInfo.bookId}" method="post" enctype="multipart/form-data">
    			<input type="file" id="editImg" name="img" style="display:none"/>
    			<input type="submit" id="sub" value="更改" class="btn btn-info" style="display:none;margin-left:5px;">
    		</form>
    	</div>
    </div>
     <div class="row">
		<div class="col-sm-2 col-sm-offset-2 text-right" style="font-weight: bold;">商品名称</div>
		<div class="col-sm-4 ">
		   ${bookInfo.bookName}
		</div>
            
    </div>
    <form id="bookAddForm" class="form-horizontal" action="jsp/admin/BookManageServlet?action=update" method="post">
        <input type="hidden" name="bookId" value="${bookInfo.bookId}">
       
        <div class="form-group">
            <label for="catalog" class="col-sm-2 col-sm-offset-2 control-label">手机品牌</label>
            <div class="col-sm-4">
                <select name="catalog" id="catalog" class="form-control">
                    <option value="">==请选择商品类型==</option>
                    <c:if test="${!empty catalog}">
                        <c:forEach items="${catalog}" var="i">
                            <c:choose>
                                <c:when test="${i.catalogId eq bookInfo.catalog.catalogId}">
                                    <option value="${i.catalogId}" selected>${i.catalogName}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${i.catalogId}">${i.catalogName}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </c:if>
                </select>
            </div>
            <div class="col-sm-4 Validform_checktip"></div>
        </div>

        <div class="form-group">
            <label for="price" class="col-sm-2 col-sm-offset-2 control-label">价格</label>
            <div class="col-sm-4">
                <input type="text" name="price" id="price" class="form-control" value="${bookInfo.price}">
            </div>
            <div class="col-sm-4 Validform_checktip"></div>
        </div>
        <div class="form-group">
			<label for="author" class="col-sm-2 col-sm-offset-2 control-label">卖方用户名</label>
			<div class="col-sm-4 ">
				<input type="text" name="author" id="author" class="form-control" value="${bookInfo.author}"/>
			</div>
			<div class="col-sm-4 Validform_checktip"></div>
		</div>
		<div class="form-group">
			<label for="press" class="col-sm-2 col-sm-offset-2 control-label">使用时长</label>
			<div class="col-sm-4 ">
				<input type="text" name="press" id="press" class="form-control" value="${bookInfo.press}"/>
			</div>
			<div class="col-sm-4 Validform_checktip"></div>
		</div>
    	<div class="form-group">
            <label for="desc" class="col-sm-2 col-sm-offset-2 control-label">备注</label>
            <div class="col-sm-4">
                <textarea rows="3" name="desc" id="desc" class="form-control" >${bookInfo.description}</textarea>
            </div>
            <span class="col-sm-4 ckerr"></span>
        </div>
        <div class="bitch" style="margin-left:62px">
            <label class="col-sm-2 col-sm-offset-2 control-label">
                <input class="btn btn-success btn-block" type="submit" value="提交" style="width: 100px;background-color: #2fa8ec">
            </label>
            <label class="col-sm-2 control-label">
                <input class="btn btn-warning btn-block" type="reset" value="重置" style="width: 100px;background-color: #2766ec">
            </label>

        </div>

    </form>
    </div>
</div>
<script type="text/javascript">
	function upImg(){
		$("#editImg").click();
	}
	$("#editImg").change(function(){
		$("#sub").css("display","inline-block");
		$("#imgSpan").css("display","none");
	})

    $(".adminName").mouseover(function(){
        $(".dropdown-menu").css("display","inline-block");
    })
    $(".adminName").mouseout(function(){
        $(".dropdown-menu").css("display","none");
    }	)
    $(function(){
        var form=$("#bookAddForm").Validform({
            tiptype:2,//validform初始化
        });

        form.addRule([
            {
                ele:"#bookName",
                datatype:"*2-100",
                ajaxurl:"jsp/admin/BookManageServlet?action=find",
                nullmsg:"请输入商品名！",
                errormsg:"商品名至少2个字符,最多20个字符！"
            },
            {
                ele:"#catalog",
                datatype:"*",
                nullmsg:"请选择商品分类！",
                errormsg:"请选择商品分类！"
            },
            {
                ele:"#price",
                datatype:"/^[0-9]{1,}([.][0-9]{1,2})?$/",
                mullmsg:"价格不能为空！",
                errormsg:"价格只能为数字"
            },
            {
                ele:"#author",
                datatype:"*",
                ajaxurl:"jsp/admin/UserManageServlet?action=APfind",
                nullmsg:"请输入卖方用户名！",
                errormsg:"*"

            },
            {
                ele:"#press",
                datatype:"*",
                nullmsg:"请输入使用时长！",
                errormsg:"*"

            }

        ]);

    });

</script>

</body>
</html>
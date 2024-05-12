package com.shop.servlet.admin;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.bean.Admin;
import com.shop.dao.AdminDao;
import com.shop.dao.impl.AdminDaoImpl;

@WebServlet("/jsp/admin/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String mainPath="main.jsp";
		String loginPath="login.jsp";

		//从表单中获取用户&密码参数
		String userName=request.getParameter("userName");
		String passWord=request.getParameter("passWord");

		//封装为admin对象
		Admin admin=new Admin(userName, passWord);
		AdminDao ud=new AdminDaoImpl();

		//新建一个数组list 储存报错信息
		List<String> list=new ArrayList<String>();
		if(userName==null) {
			list.add("用户名不能为空");
		}
		if(passWord==null) {
			list.add("密码不能为空");
		}
		//若数组没内容↓
		if(list.size()==0) {
			//通过dao层中 userLogin 方法获取布尔值FLAG ，true则同意跳转
			if(ud.userLogin(admin)) {
				//把admin对象传给adminUser adminUser（main.jsp中的文体，导航栏上的名字）
				request.getSession().setAttribute("adminUser",admin );
				//Servlet请求重定向，实现跳转
				response.sendRedirect(mainPath);
				return;
			}else {
				list.add("用户名或密码错误!请重新输入");	
			}
		}//传递list到jsp里的infolist
		request.setAttribute("infoList", list);
		request.getRequestDispatcher(loginPath).forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

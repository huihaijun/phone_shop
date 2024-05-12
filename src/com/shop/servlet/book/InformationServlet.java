package com.shop.servlet.book;

import com.shop.bean.*;
import com.shop.dao.BookDao;
import com.shop.dao.OrderDao;
import com.shop.dao.OrderItemDao;
import com.shop.dao.UserDao;
import com.shop.dao.impl.BookDaoImpl;
import com.shop.dao.impl.OrderDaoImpl;
import com.shop.dao.impl.OrderItemDaoImpl;
import com.shop.dao.impl.UserDaoImpl;
import com.shop.util.DateUtil;
import com.shop.util.RanUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

//这是新增加的用户资料

/**
 * 订单前台一些请求
 * Servlet implementation class OrderSubServlet
 */
@WebServlet(name = "InformationServlet", urlPatterns = { "/InformationServlet" })
//@WebServlet("/jsp/book/InformationServlet")

public class InformationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int  MAX_LIST_SIZE=5;
	private static final String Information_PATH="jsp/book/information.jsp?type=information" ;


	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String userId = request.getParameter("userId");
		if (userId != null && !userId.isEmpty()) {
			try {
				int id = Integer.parseInt(userId);
				UserDao ud = new UserDaoImpl();
				request.setAttribute("userInfo", ud.findUser(id));
				request.getRequestDispatcher(Information_PATH).forward(request, response);
			} catch (NumberFormatException e) {
				// 处理无法解析为整数的情况，例如返回错误页面或输出错误信息
				response.getWriter().println("Invalid userId format");
			}
		} else {
			// 处理参数为空的情况，例如返回错误页面或输出错误信息
			response.getWriter().println("Missing userId parameter");
		}


	}



}

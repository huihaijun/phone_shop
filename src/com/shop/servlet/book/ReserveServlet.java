package com.shop.servlet.book;

import com.shop.bean.PageBean;
import com.shop.bean.Reserve;
import com.shop.bean.Ureserve;
import com.shop.bean.User;
import com.shop.dao.ReserveDao;
import com.shop.dao.UreserveDao;
import com.shop.dao.UserDao;
import com.shop.dao.impl.AdminDaoImpl;
import com.shop.dao.impl.ReserveDaoImpl;
import com.shop.dao.impl.UreserveDaoImpl;
import com.shop.dao.impl.UserDaoImpl;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import java.text.SimpleDateFormat;
/**
 * Servlet implementation class UserManage
 */
@WebServlet("/jsp/book/ReserveServlet")
public class ReserveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int MAX_LIST_SIZE = 12;

	private static final String Reserve_PATH="upload.jsp";

	private static final String LookReserve_PATH="ureserve.jsp";


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
		
		String action=request.getParameter("action");
		System.out.println("Action参数的值：" + action);
		switch(action){
		case "get":
			get(request,response);
			break;
		case "search":
			String date = request.getParameter("date");
			if (date != null && !date.isEmpty()) {
				search(request, response, date);
			} else {
				Date currentDate = new Date();
				// 创建一个SimpleDateFormat对象，用于格式化日期
				SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				// 使用SimpleDateFormat对象将Date对象格式化为字符串
				date = dateFormat.format(currentDate);
				search(request, response, date);
			}
			break;
		case "Add":
			Add(request,response);
			break;
		case "look":
			look(request,response);
			break;
		case "del":
			del(request,response);
			break;
		}

	}

	private void get(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		System.out.println("get方法被调用了");
		String userId = request.getParameter("userId");
		if (userId != null && !userId.isEmpty()) {
			try {
				int id = Integer.parseInt(userId);
				UserDao ud = new UserDaoImpl();
				request.setAttribute("userInfo", ud.findUser(id));
//				request.getRequestDispatcher(Reserve_PATH).forward(request, response);
			} catch (NumberFormatException e) {
				// 处理无法解析为整数的情况，例如返回错误页面或输出错误信息
				response.getWriter().println("Invalid userId format");
			}
		} else {
			// 处理参数为空的情况，例如返回错误页面或输出错误信息
			response.getWriter().println("Missing userId parameter");
		}
		ReserveDao rd = new ReserveDaoImpl();
		//默认当前页为第一页，每页最多能显示6条项目.
		int curPage=1;
		int maxSize=6;
		//只要page不为空，获取page更新为当前页的页码
		String page=request.getParameter("page");
		if(page!=null){
			curPage=Integer.parseInt(page);
		}
		//新建Pagebean对象，ad.bookReadCount()是在本方法新建的ad对象
		//在dao层执行 select （*） 时得出的数据
		PageBean pageBean=new PageBean(curPage,maxSize,rd.reserveCount());

		//1.传递dao层返回的包含数据的数组lu；2.传递pagebean包含的6个信息；
		//给jsp上的adminlist和pagebean方便adminlist.jsp下一步的遍历或者调用
		request.setAttribute("reserveList", rd.reserveList(pageBean));
		request.setAttribute("pageBean", pageBean);
		request.getRequestDispatcher(Reserve_PATH).forward(request, response);

	}
	private void search(HttpServletRequest request, HttpServletResponse response, String date) throws ServletException, IOException {
		String userId = request.getParameter("userId");
		if (userId != null && !userId.isEmpty()) {
			try {
				int id = Integer.parseInt(userId);
				UserDao ud = new UserDaoImpl();
				request.setAttribute("userInfo", ud.findUser(id));
//				request.getRequestDispatcher(Reserve_PATH).forward(request, response);
			} catch (NumberFormatException e) {
				// 处理无法解析为整数的情况，例如返回错误页面或输出错误信息
				response.getWriter().println("Invalid userId format");
			}
		} else {
			// 处理参数为空的情况，例如返回错误页面或输出错误信息
			response.getWriter().println("Missing userId parameter");
		}
		ReserveDao rd = new ReserveDaoImpl();
		int curPage = 1;
		String page = request.getParameter("page");
		if (page != null) {
			curPage = Integer.parseInt(page);
		}
		PageBean pb = null;
		List<Reserve> reserveList = new ArrayList<Reserve>();
		String reserveStr = date;//获取有没有关键词，没有就是查全部

		if (reserveStr != null) {
			pb = new PageBean(curPage, MAX_LIST_SIZE, rd.reserveCount());
			reserveList = rd.findReserve(date);

		} else {
			pb = new PageBean(curPage, MAX_LIST_SIZE, rd.reserveCount());
			reserveList = rd.reserveList(pb);
			request.setAttribute("title", "所有商品");
		}
		request.setAttribute("pageBean", pb);
		request.setAttribute("reserveList", reserveList);
		request.getRequestDispatcher(Reserve_PATH).forward(request, response);
	}

	private void Add(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		System.out.println("打印测试add方法被调用");

		UreserveDao ud =new UreserveDaoImpl();
		Ureserve ureserve=new Ureserve(
//				Integer.parseInt(request.getParameter("reid")),
				Integer.parseInt(request.getParameter("userId")),
				request.getParameter("userName"),
				request.getParameter("name"),
				request.getParameter("tell"),
				request.getParameter("date"),
				request.getParameter("period")
		);
		if(ud.addUreserve(ureserve)){
			request.setAttribute("reserveMessage", "你已成功预约！");
			request.getRequestDispatcher(Reserve_PATH).forward(request, response);
		}
		else{
			request.setAttribute("reserveMessage", "预约失败，可能你于当天已有预约");
			request.getRequestDispatcher(Reserve_PATH).forward(request, response);
		}
	}

	private void look(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		UreserveDao ud=new UreserveDaoImpl();
		//默认当前页为第一页，每页最多能显示6条项目.
		int curPage=1;
		int maxSize=6;
		//只要page不为空，获取page更新为当前页的页码
		String page=request.getParameter("page");
		if(page!=null){
			curPage=Integer.parseInt(page);
		}
		//新建Pagebean对象，ad.bookReadCount()是在本方法新建的ad对象
		//在dao层执行 select （*） 时得出的数据
		PageBean pageBean=new PageBean(curPage,maxSize,ud.UreserveReadCount());
		//1.传递dao层返回的包含数据的数组lu；2.传递pagebean包含的6个信息；
		//给jsp上的adminlist和pagebean方便adminlist.jsp下一步的遍历或者调用
		Integer userId = Integer.valueOf(request.getParameter("userId"));
		request.setAttribute("ureserve", ud.findUserReserve(pageBean,userId));
		request.setAttribute("pageBean", pageBean);
		request.setAttribute("userId", userId);
		request.getRequestDispatcher(LookReserve_PATH).forward(request, response);
	}

	private void del(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int reid=Integer.parseInt(request.getParameter("reid"));
		int userId=Integer.parseInt(request.getParameter("userId"));
		//调用dao层删除用户方法，若成功删除，返回true
		UreserveDao ud=new UreserveDaoImpl();
		if(ud.delreserve(reid)) {
			request.setAttribute("userMessage", "预约已删除!");
			request.setAttribute("userId", userId);
		}else {
			request.setAttribute("userMessage", "预约删除失败");
		}
		look(request, response);

	}
}


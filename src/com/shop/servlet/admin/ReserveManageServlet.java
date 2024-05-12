package com.shop.servlet.admin;

import com.shop.bean.*;
import com.shop.dao.*;
import com.shop.dao.impl.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
//import java.util.Date;
/**
 * Servlet implementation class OrderManageServlet
 */
@WebServlet("/jsp/admin/ReserveManageServlet")
public class ReserveManageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int MAX_LIST_SIZE = 12;

	private static final String RESERVEADD_PATH="reserveManage/reserveAdd.jsp";
	private static final String RESERVELIST_PATH="reserveManage/reserveList.jsp";
	private static final String RESERVEVIEW_PATH="reserveManage/reserveView.jsp";

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=request.getParameter("action");
//		System.out.println("Action parameter: " + action);
		if(action==null) {
			action="add";
		}

		switch(action) {
			case "list":
				reserveList(request,response);
				break;
			case "add":
				reserveAdd(request,response);
				break;
			case "search":
				String date = request.getParameter("date");
				if (date != null && !date.isEmpty()) {
					reserveSearch(request, response, date);
				} else {
					reserveList(request, response);
				}
				break;
			case "view":
				view(request,response);
				break;
			case "judge":
				judge(request,response);
				break;
			case "judge2":
				judge2(request,response);
				break;
		}
		
	}
	private void reserveList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//在dao层新建对象
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
		request.getRequestDispatcher(RESERVELIST_PATH).forward(request, response);
	}


	private void reserveAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ReserveDao ad =new ReserveDaoImpl();
		Reserve reserve=new Reserve(
				request.getParameter("date"),
				request.getParameter("period"),
				Integer.parseInt(request.getParameter("Num"))
		);
		if(ad.addReserve(reserve)){
				request.setAttribute("reserveMessage", "预约添加成功！");
				request.getRequestDispatcher(RESERVEADD_PATH).forward(request, response);
		}
		else{
			request.setAttribute("reserveMessage", "该时间段已有用户预约，修改失败");
			request.getRequestDispatcher(RESERVEADD_PATH).forward(request, response);
		}
	}

	private void reserveSearch(HttpServletRequest request, HttpServletResponse response, String date) throws ServletException, IOException {

		ReserveDao rd = new ReserveDaoImpl();
		int curPage = 1;
		String page = request.getParameter("page");
		if (page != null) {
			curPage = Integer.parseInt(page);
		}
		PageBean pb = null;
		List<Reserve> reserveList = new ArrayList<Reserve>();
		String reserveStr = request.getParameter("date");//获取有没有关键词，没有就是查全部
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
		request.getRequestDispatcher(RESERVELIST_PATH).forward(request, response);
//		for (Reserve reserve : reserveList) {
//			System.out.println(reserve);
//		}

	}
	private void view(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String date = request.getParameter("date");
		String period = request.getParameter("period");
		UreserveDao ud = new UreserveDaoImpl();
		request.setAttribute("viewList", ud.viewReserve(date,period));
		request.setAttribute("date", date);
		request.setAttribute("period", period);
		request.getRequestDispatcher(RESERVEVIEW_PATH).forward(request, response);
	}

	private void judge(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String reid=request.getParameter("reid");
		UreserveDao ureserveDao= new UreserveDaoImpl();
		String date = request.getParameter("date");
		String period = request.getParameter("period");
		if(ureserveDao.ureserveStatus(Integer.parseInt(reid),1)) {
			request.setAttribute("date", date);
			request.setAttribute("period", period);
			request.setAttribute("reserveMessage", "操作成功");
		}else {
			request.setAttribute("date", date);
			request.setAttribute("period", period);
			request.setAttribute("reserveMessage", "操作失败");
		}
		view(request, response);
	}

	private void judge2(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String reid=request.getParameter("reid");
		UreserveDao ureserveDao= new UreserveDaoImpl();
		String date = request.getParameter("date");
		String period = request.getParameter("period");
		if(ureserveDao.ureserveStatus(Integer.parseInt(reid),2)) {
			request.setAttribute("date", date);
			request.setAttribute("period", period);
			request.setAttribute("orderMessage", "一个订单操作成功");
		}else {
			request.setAttribute("date", date);
			request.setAttribute("period", period);
			request.setAttribute("orderMessage", "一个订单操作失败");
		}
		view(request, response);
	}
}


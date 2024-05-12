 package com.shop.servlet.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.bean.PageBean;
import com.shop.dao.BookDao;
import com.shop.dao.CatalogDao;
import com.shop.dao.impl.BookDaoImpl;
import com.shop.dao.impl.CatalogDaoImpl;

import net.sf.json.JSONObject;

@WebServlet("/jsp/admin/CatalogServlet")
public class CatalogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String CATALOGLIST_PATH="bookManage/catalogList.jsp";
	private static final String CATALOGADD_PATH="bookManage/catalogAdd.jsp";
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=request.getParameter("action");
		switch(action) {
		case "list":
			catalogList(request,response);
			break;
		case "add":
			catalogAdd(request,response);
			break;
		case "del":
			catalogDel(request,response);
			break;
		case "batDel":
			catalogBatDel(request,response);
			break;
		case "find":
			catalogFind(request,response);
			break;
		}
	}
	//获取分类、分页列表
	private void catalogList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//默认当前页为第一页，每页最多能显示6条项目.
		int curPage = 1;
		int maxSize = 6;
		//只要page不为空，点击跳转的时候获取page更新为当前页的页码
		String page = request.getParameter("page");
		if (page != null) {
			curPage = Integer.parseInt(page);
		}
		//新建Pagebean对象，ad.catalogReadCount()是在本方法新建的ad对象
		//在dao层执行 select （*） 时得出的数据
		CatalogDao cd = new CatalogDaoImpl();
		PageBean pb = new PageBean(curPage, maxSize, cd.catalogReadCount());

		//1.传递dao层返回的包含数据的数组list；2.传递pagebean包含的6个信息；
		//给jsp上的cataloglist和pagebean方便cataloglist.jsp下一步的遍历或者调用
		request.setAttribute("pageBean", pb);
		request.setAttribute("catalogList", cd.catalogList(pb));
		request.getRequestDispatcher(CATALOGLIST_PATH).forward(request, response);
	}

	private void catalogDel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int catalogId=Integer.parseInt(request.getParameter("id"));
		CatalogDao cd=new CatalogDaoImpl();
		//调用dao层 返回布尔值
		if(cd.catalogDel(catalogId)) {
			request.setAttribute("catalogMessage", "该分类已删除!");
		}else {
			request.setAttribute("catalogMessage", "该分类删除失败");
		}
		//分类删除成功失败都跳转到分类列表页面（通过servlet跳到分类列表）
		catalogList(request,response);
	}

	private void catalogBatDel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ids=request.getParameter("ids");
		CatalogDao cd=new CatalogDaoImpl();
		if(cd.catalogBatDelById(ids)) {
			request.setAttribute("bookMessage", "分类已批量删除!");
		}else {
			request.setAttribute("bookMessage", "分类删除失败");
		}
		//分类删除成功失败都跳转到分类列表页面（通过servlet跳到分类列表）
		catalogList(request, response);
		
	}

	private void catalogAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//获取填写的分类名
		String catalogName=request.getParameter("catalogName");
		CatalogDao cd =new CatalogDaoImpl();
		//执行dao层
		if(cd.catalogAdd(catalogName)) {
			request.setAttribute("catalogMessage", "增加分类成功!");
			catalogList(request,response);
		}else {
			request.setAttribute("catalogMessage", "增加分类失败");
			request.getRequestDispatcher(CATALOGADD_PATH).forward(request,response);
		}
	}
	// ajax查找商品是否存在
	private void catalogFind(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//获取分类名
		String catalogName = request.getParameter("param");
		CatalogDao cd = new CatalogDaoImpl();
		//实例化json对象
		JSONObject json = new JSONObject();
		if (cd.findCatalogByCatalogName(catalogName)) {
			json.put("info", "该分类已存在");
			json.put("status", "n");
		} else {
			json.put("info", "输入正确");
			json.put("status", "y");
		}
		response.getWriter().write(json.toString());
	}
}



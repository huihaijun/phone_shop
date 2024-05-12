package com.shop.servlet.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.bean.Admin;
import com.shop.bean.PageBean;
import com.shop.dao.AdminDao;
import com.shop.dao.impl.AdminDaoImpl;
import com.shop.util.DateUtil;

import net.sf.json.JSONObject;

@WebServlet("/jsp/admin/AdminManageServlet")
public class AdminManageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String ADMINLIST_PATH="adminManage/adminList.jsp";//用户列表页面地址
	private static final String ADMINADD_PATH="adminManage/adminAdd.jsp";//用户增加页面地址
	private static final String ADMINEDIT_PATH="adminManage/adminEdit.jsp";//用户修改页面地址

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=request.getParameter("action");
		switch(action){
		case "list":
			adminList(request,response);
			break;
		case "add":
			adminAdd(request,response);
			break;
		case "update":
			adminUpdate(request,response);
			break;
		case "edit":
			adminEdit(request,response);
			break;
		case "del":
			adminDel(request,response);
			break;
		case "batDel":
			adminBatDel(request,response);
			break;
		case "find":
			adminFind(request,response);
			break;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	//管理员列表，在增删改过程中也有刷新，回到第一页的功能
	private void adminList(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		//在dao层新建对象
		AdminDao ad=new AdminDaoImpl();
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
		PageBean pageBean=new PageBean(curPage,maxSize,ad.bookReadCount());
		//1.传递dao层返回的包含数据的数组lu；2.传递pagebean包含的6个信息；
		//给jsp上的adminlist和pagebean方便adminlist.jsp下一步的遍历或者调用
		request.setAttribute("adminList", ad.userList(pageBean));
		request.setAttribute("pageBean", pageBean);
		request.getRequestDispatcher(AdminManageServlet.ADMINLIST_PATH).forward(request, response);
	}
	
	//增加用户
	private void adminAdd(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		AdminDao ad=new AdminDaoImpl();
		Admin admin=new Admin(request.getParameter("userName"),
							  request.getParameter("passWord"),
				              request.getParameter("name"));
		//添加之前判断用户名是否在库中存在，调用finduser方法（布尔型）
		if(new AdminDaoImpl().findUser(admin.getUserName())){
			//实则用不到这条adminmessage（ajax拦截）主要使用else后的语句
			request.setAttribute("adminMessage", "用户添加失败！用户名已存在");
			request.getRequestDispatcher(AdminManageServlet.ADMINADD_PATH).forward(request, response);
		}else{
			//执行dao层添加操作
			if(ad.userAdd(admin)){
				request.setAttribute("adminMessage", "用户添加成功！");
				adminList(request, response);
			}else{
				request.setAttribute("adminMessage", "用户添加失败！");
				request.getRequestDispatcher(AdminManageServlet.ADMINADD_PATH).forward(request, response);
			}
		}
	}
	//ajax判断用户名
	private void adminFind(HttpServletRequest request, HttpServletResponse response) throws IOException {
		//在页面上获取用户名
		String userName=request.getParameter("param");
		AdminDao ad=new AdminDaoImpl();
		//实例化json对象
		JSONObject json=new JSONObject();
		if(ad.findUser(userName)){
			json.put("info", "用户名已存在");
			json.put("status", "n");
		}else{
			json.put("info", "用户名可以使用");
			json.put("status", "y");
		}
		response.getWriter().write(json.toString());
	}

	//修改用户 从每行的id中获取用于显示要修改的用户的id和用户名至admininfo中
	//（id用于sql语句，用户名用于呈现）
	//然后跳转至adminedit.jsp
	private void adminEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id=request.getParameter("id");
		AdminDao ad=new AdminDaoImpl();
		//这里回去是Admin对象 返回的是一个list用户信息集合
		request.setAttribute("adminInfo",ad.findUser(Integer.valueOf(id)));
		request.getRequestDispatcher(AdminManageServlet.ADMINEDIT_PATH).forward(request, response);
	}
	//更新用户信息
	private void adminUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//封装到admin里面（userinfo传来的id和输入的密码、名字）
		Admin admin=new Admin(Integer.parseInt(request.getParameter("id")),
				request.getParameter("passWord"),
				request.getParameter("name"));
		AdminDao ad=new AdminDaoImpl();
		//到dao层执行update
		if(ad.userUpdate(admin)) {
			request.setAttribute("adminMessage", "用户更新成功!");
			adminList(request, response);//通过servlet中adminlist跳到用户列表
		}else {
			//更新失败 重新获取adminInfo，跳转到修改页面
			request.setAttribute("adminMessage", "用户更新失败");
			//这里回去是Admin对象
			request.setAttribute("adminInfo", ad.findUser(Integer.valueOf(admin.getId())));
			request.getRequestDispatcher(AdminManageServlet.ADMINEDIT_PATH).forward(request, response);
		}
	}
	//删除用户
	private void adminDel(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		int id=Integer.parseInt(request.getParameter("id"));
		AdminDao ad=new AdminDaoImpl();
		//调用dao层删除用户方法，若成功删除，返回true
		if(ad.delUser(id)) {
			request.setAttribute("adminMessage", "用户已删除!");
		}else {
			request.setAttribute("adminMessage", "用户删除失败");
		}
		//用户删除成功失败都跳转到用户列表页面（通过再调用adminList跳到用户列表）
		adminList(request, response);
	}
	
	//批量删除
	private void adminBatDel(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String ids=request.getParameter("ids");
		AdminDao ad=new AdminDaoImpl();
		//调用dao层删除用户方法，若成功删除，返回true
		if(ad.batDelUser(ids)) {
			request.setAttribute("adminMessage", "用户已批量删除!");
		}else {
			request.setAttribute("adminMessage", "用户批量删除失败");
		}
		//用户删除成功失败都跳转到用户列表页面（通过servlet中listUser跳到用户列表）
		adminList(request, response);
		
	}
}

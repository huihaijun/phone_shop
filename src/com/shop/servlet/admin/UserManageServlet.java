package com.shop.servlet.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.bean.Admin;
import com.shop.bean.PageBean;
import com.shop.bean.User;
import com.shop.dao.AdminDao;
import com.shop.dao.UserDao;
import com.shop.dao.impl.AdminDaoImpl;
import com.shop.dao.impl.UserDaoImpl;
import net.sf.json.JSONObject;

/**
 * Servlet implementation class UserManageServlet
 */
@WebServlet("/jsp/admin/UserManageServlet")
public class UserManageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String USERLIST_PATH="userManage/userList.jsp";//用户列表页面地址
	private static final String USERADD_PATH="userManage/userAdd.jsp";//用户增加页面地址
	private static final String USEREDIT_PATH="userManage/userEdit.jsp";//用户修改页面地址

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=request.getParameter("action");
		if(action==null) {
			action="list";
		}
		switch(action){
		case "list":
			userList(request,response);
			break;
		case "add":
			userAdd(request,response);
			break;
		case "update":
			userUpdate(request,response);
			break;
		case "edit":
			userEdit(request,response);
			break;
		case "del":
			userDel(request,response);
			break;
		case "batDel":
			userBatDel(request,response);
			break;
		case "find":
			adminFind(request,response);
			break;
		case "APfind":
			addProductFind(request,response);
			break;
		}
	}
	//用户列表，在增删改过程中也有刷新，回到第一页的功能
	private void userList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//在dao层新建对象
		UserDao ud=new UserDaoImpl();
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
		PageBean pageBean=new PageBean(curPage,maxSize,ud.bookReadCount());

		//1.传递dao层返回的包含数据的数组lu；2.传递pagebean包含的5个信息；
		//给jsp上的adminlist和pagebean方便adminlist.jsp下一步的遍历或者调用
		request.setAttribute("userList", ud.userList(pageBean));
		request.setAttribute("pageBean", pageBean);
		request.getRequestDispatcher(USERLIST_PATH).forward(request, response);
	}
	//删除用户
	private void userDel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id=Integer.parseInt(request.getParameter("id"));
		//调用dao层删除用户方法，若成功删除，返回true
		UserDao ud=new UserDaoImpl();
		if(ud.delUser(id)) {
			request.setAttribute("userMessage", "用户已删除！");
		}else {
			request.setAttribute("userMessage", "用户删除失败");
		}
		//用户删除成功失败都通过servlet中Userlist跳到用户列表
		userList(request, response);
	}
	//批量删除
	private void userBatDel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ids=request.getParameter("ids");
		//调用dao层删除用户方法，若成功删除，返回true
		UserDao ud=new UserDaoImpl();
		if(ud.batDelUser(ids)) {
			request.setAttribute("userMessage", "用户已批量删除！");
		}else {
			request.setAttribute("userMessage", "用户批量删除失败");
		}
		//用户删除成功失败都通过servlet中Userlist跳到用户列表
		userList(request, response);
	}

	//修改用户 从每行的id中获取用于显示要修改的用户的id和用户名至userinfo中
	//（id用于sql语句，用户名用于呈现）
	//然后跳转至useredit.jsp
	private void userEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id=request.getParameter("id");
		UserDao ud=new UserDaoImpl();
		//这里回去是User对象 返回的是一个list用户信息集合
		request.setAttribute("userInfo",ud.findUser(Integer.valueOf(id)));
		request.getRequestDispatcher(USEREDIT_PATH).forward(request, response);
	}
	//更新用户信息
	private void userUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//封装到admin里面（userinfo传来的id和输入的密码、名字、性别、年龄、电话、地址、禁用状态）
		User user=new User(
				Integer.parseInt(request.getParameter("userId")),
				request.getParameter("passWord"),
				request.getParameter("name"),
				request.getParameter("sex"),
				Integer.parseInt(request.getParameter("age")),
				request.getParameter("tell"),
				request.getParameter("address"),
				request.getParameter("enabled"));
		UserDao ud=new UserDaoImpl();
		//到dao层执行update
		if(ud.userUpdate(user)) {
			request.setAttribute("userMessage", "用户更新成功！");
			userList(request, response);//通过servlet中Userlist跳到用户列表
		}else {
			//更新失败 重新获取id 至 userInfo，跳转到修改页面
			request.setAttribute("userMessage", "用户更新失败");
			//这里回去是User对象
			request.setAttribute("userInfo", ud.findUser(Integer.valueOf(user.getUserId())));
			request.getRequestDispatcher(USEREDIT_PATH).forward(request, response);
		}
	}
	private void userAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserDao ad=new UserDaoImpl();
		User user=new User(
				request.getParameter("userName"),
				request.getParameter("passWord"),
				request.getParameter("name"),
				request.getParameter("sex"),
				Integer.parseInt(request.getParameter("age")),
				request.getParameter("tell"),
				request.getParameter("address"));
				//默认添加的用户启用
				user.setEnabled("y");

		//添加之前判断用户名是否在库中存在 调用finduser方法（布尔型）
		if(new AdminDaoImpl().findUser(user.getUserName())){
			//实则用不到这条usermessage（ajax拦截） 主要使用else后的语句
			request.setAttribute("userMessage", "用户添加失败！用户名已存在");
			request.getRequestDispatcher(USERADD_PATH).forward(request, response);
		}else{
			//执行dao层添加操作
			if(ad.userAdd(user)){
				request.setAttribute("userMessage", "用户添加成功！");
				userList(request, response);//通过servlet中Userlist跳到用户列表
			}else{
				request.setAttribute("userMessage", "用户添加失败！");
				request.getRequestDispatcher(USERADD_PATH).forward(request, response);
			}
		}
	}
	private void adminFind(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String userName=request.getParameter("param");
		UserDao ud=new UserDaoImpl();
		JSONObject json=new JSONObject();
		if(ud.findUser(userName)){
			json.put("info", "用户名已存在");
			json.put("status", "n");
		}else{
			json.put("info", "用户名可以使用");
			json.put("status", "y");
		}
		response.getWriter().write(json.toString());

	}
	private void addProductFind(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String userName=request.getParameter("param");
		UserDao ud=new UserDaoImpl();
		JSONObject json=new JSONObject();
		if(ud.findUser(userName)){
			json.put("info", "验证通过");
			json.put("status", "y");
		}else{
			json.put("info", "没有相关注册信息！");
			json.put("status", "n");
		}
		response.getWriter().write(json.toString());

	}



}

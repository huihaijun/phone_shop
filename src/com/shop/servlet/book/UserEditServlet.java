package com.shop.servlet.book;

import com.shop.bean.PageBean;
import com.shop.bean.User;
import com.shop.dao.UserDao;
import com.shop.dao.impl.AdminDaoImpl;
import com.shop.dao.impl.UserDaoImpl;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class UserManageServlet
 */
@WebServlet("/jsp/book/UserEditServlet")
public class UserEditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
//	private static final String USERLIST_PATH="information.jsp";//用户列表页面地址
//	private static final String USERADD_PATH="userManage/userAdd.jsp";//用户增加页面地址
	private static final String USEREDIT_PATH="information.jsp";//用户修改页面地址
	private static final String Information_PATH="information.jsp" ;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);

		/*mall*/

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
		case "update":
			userUpdate(request,response);
			break;
		case "edit":
			userEdit(request,response);
			break;

		}
	}
	//用户列表，在增删改过程中也有刷新，回到第一页的功能
	private void userList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

	//修改用户 从每行的id中获取用于显示要修改的用户的id和用户名至userinfo中
	//（id用于sql语句，用户名用于呈现）
	//然后跳转至useredit.jsp
	private void userEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		String id=request.getParameter("id");
		Integer userId = Integer.valueOf(request.getParameter("userId"));
		UserDao ud=new UserDaoImpl();
		//这里回去是User对象 返回的是一个list用户信息集合
		request.setAttribute("userInfo",ud.findUser(userId));
//		request.setAttribute("userInfo", ud.findUser(id));
		request.getRequestDispatcher(USEREDIT_PATH).forward(request, response);
	}
	//更新用户信息
	private void userUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//封装到admin里面（userinfo传来的 id 和 输入的密码、名字、性别、年龄、电话、地址、禁用状态）
//
		User user=new User(
				Integer.parseInt(request.getParameter("userId")),
				request.getParameter("userPassWord"),
				request.getParameter("name"),
				request.getParameter("sex"),
				Integer.parseInt(request.getParameter("age")),
				request.getParameter("tell"),
				request.getParameter("address")
		);
		UserDao ud=new UserDaoImpl();
		//到dao层执行update
		if(ud.userUUpdate(user)) {
			request.setAttribute("userMessage", "用户更新成功");
			userList(request, response);//通过servlet中Userlist跳到用户列表
		}else {
			//更新失败 重新获取id 至 userInfo，跳转到修改页面
			request.setAttribute("userMessage", "用户更新失败");
			//这里回去是User对象
			request.setAttribute("userInfo", ud.findUser(Integer.valueOf(user.getUserId())));
			request.getRequestDispatcher(USEREDIT_PATH).forward(request, response);
		}
	}
//	private void userAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		UserDao ad=new UserDaoImpl();
//		User user=new User(
//				request.getParameter("userName"),
//				request.getParameter("passWord"),
//				request.getParameter("name"),
//				request.getParameter("sex"),
//				Integer.parseInt(request.getParameter("age")),
//				request.getParameter("tell"),
//				request.getParameter("address"));
//				//默认添加的用户启用
//				user.setEnabled("y");
//
//		//添加之前判断用户名是否在库中存在 调用finduser方法（布尔型）
//		if(new AdminDaoImpl().findUser(user.getUserName())){
//			//实则用不到这条usermessage（ajax拦截） 主要使用else后的语句
//			request.setAttribute("userMessage", "用户添加失败！用户名已存在");
//			request.getRequestDispatcher(USERADD_PATH).forward(request, response);
//		}else{
//			//执行dao层添加操作
//			if(ad.userAdd(user)){
//				request.setAttribute("userMessage", "用户添加成功！");
//				userList(request, response);//通过servlet中Userlist跳到用户列表
//			}else{
//				request.setAttribute("userMessage", "用户添加失败！");
//				request.getRequestDispatcher(USERADD_PATH).forward(request, response);
//			}
//		}
//	}
//	private void adminFind(HttpServletRequest request, HttpServletResponse response) throws IOException {
//		String userName=request.getParameter("param");
//		UserDao ud=new UserDaoImpl();
//		JSONObject json=new JSONObject();
//		if(ud.findUser(userName)){
//			json.put("info", "用户名已存在");
//			json.put("status", "n");
//		}else{
//			json.put("info", "用户名可以使用");
//			json.put("status", "y");
//		}
//		response.getWriter().write(json.toString());
//
//	}
//


}

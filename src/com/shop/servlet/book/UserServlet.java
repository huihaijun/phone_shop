package com.shop.servlet.book;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.shop.bean.Order;
import com.shop.bean.OrderItem;
import com.shop.bean.PageBean;
import com.shop.bean.User;
import com.shop.dao.BookDao;
import com.shop.dao.OrderDao;
import com.shop.dao.OrderItemDao;
import com.shop.dao.UserDao;
import com.shop.dao.impl.*;

import com.zhenzi.sms.ZhenziSmsClient;
import net.sf.json.JSONObject;
import org.apache.commons.lang.RandomStringUtils;

/**
 * Servlet implementation class UserManage
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int MAX_LIST_SIZE = 12;

	private static final String LOGIN_PATH="jsp/book/reg.jsp?type=login";
	private static final String REG_PATH="jsp/book/reg.jsp?type=reg";
	private static final String INDEX_PATH="jsp/book/index.jsp";
	private static final String LANDING="landing";				//前台用户session标识
	private static final String Information_PATH="jsp/book/information.jsp" ;
	private static final String SELLLIST_PATH="jsp/book/myselllist.jsp" ;

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
		case "login":
			login(request,response);
			break;
		case "off":
			offlogin(request,response);
			break;
		case "ajlogin":
			ajlogin(request,response);
			break;
		case "reg":
			reg(request,response);
			break;
		case "landstatus":
			landstatus(request,response);
			break;
		case "information":
			getInformation(request,response);
			break;
		case"find":
			userFind(request,response);
			break;
		case"sell":
			sell(request,response);
			break;
		case"remove":
			remove(request,response);
			break;
		case"reup":
			reUpload(request,response);
			break;
		case"payout":
			payout(request,response);
			break;
		case "yanzheng":
			try {
				yanzheng(request,response);
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
			break;
		case"findNumber":
			findNumber(request,response);
			break;
		}
	}


	private void getInformation(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
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


	//判断登陆状态
	private void landstatus(HttpServletRequest request, HttpServletResponse response) throws IOException {
		User user=  (User) request.getSession().getAttribute(LANDING);
		
		PrintWriter pw = response.getWriter();
		JSONObject json=new JSONObject();
		
		if(user!=null) {
			json.put("status", "y");
		}else {
			json.put("status", "n");
		}
		pw.print(json.toString());
		pw.flush();
		
	}
	//ajax登陆
	private void ajlogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String userName = request.getParameter("userName");
		String passWord = request.getParameter("passWord");
		User user=new User(userName,passWord);
		PrintWriter pw = response.getWriter();
		JSONObject json=new JSONObject();
		UserDao ud=new UserDaoImpl();
		User user2=ud.userLogin(user);

		if(user2!=null) {
			if("y".equals(user2.getEnabled()) && user2.getCredit() >= 70) {
				request.getSession().setAttribute(LANDING, user2);
				json.put("status","y" );
			} else if ("y".equals(user2.getEnabled()) && user2.getCredit() < 70) {
				json.put("info", "您的信用分不足70，无法登录，请联系管理员");
			} else {
				json.put("info", "该用户已被禁用，请联系管理员");
			}
		} else {
			json.put("info", "用户名或密码错误，请重新登录！");
		}
		pw.print(json.toString());
	}
	private void reg(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 获取用户输入的验证码
		String inputCode = request.getParameter("verificationCode");
		// 获取后端存储的验证码
		String storedCode = (String) request.getSession().getAttribute("code");
		// 比较用户输入的验证码和后端存储的验证码
		if (inputCode != null && inputCode.equals(storedCode)) {
			// 验证码匹配成功，继续注册流程
			UserDao ad = new UserDaoImpl();
			User user = new User(
					request.getParameter("userName"),
					request.getParameter("passWord"),
					request.getParameter("name"),
					request.getParameter("sex"),
					Integer.parseInt(request.getParameter("age")),
					request.getParameter("tell"),
					request.getParameter("address"));
			user.setEnabled("y");// 默认添加的用户启用
			// 添加之前判断用户名是否在库中存在
			if (new AdminDaoImpl().findUser(user.getUserName())) {
				request.setAttribute("infoList", "用户添加失败！用户名已存在");
				request.getRequestDispatcher(REG_PATH).forward(request, response);
			} else {
				// 执行dao层添加操作
				if (ad.userAdd(user)) {
					response.sendRedirect(LOGIN_PATH); // 执行重定向
					return; // 终止方法的执行
				} else {
					request.setAttribute("userMessage", "用户添加失败！");
					request.getRequestDispatcher(REG_PATH).forward(request, response);
				}
			}
		} else {
			response.getWriter().write("验证码错误，请重新输入！");
		}
	}

	private void offlogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession();
		User user =  (User) request.getSession().getAttribute(LANDING);
		if(user!=null) {
			request.getSession().removeAttribute(LANDING);
			session.removeAttribute("shopCart");
		}
		response.sendRedirect(INDEX_PATH);
	}

	private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName=request.getParameter("userName");
		String passWord=request.getParameter("passWord");
		User user=new User(userName,passWord);
		UserDao ud=new UserDaoImpl();
		User user2=ud.userLogin(user);
		if (user2 != null) {
			if ("y".equals(user2.getEnabled())) {
				System.out.println(user2.getCredit());
				if (user2.getCredit() >= 70) {
					request.getSession().setAttribute(LANDING, user2);
					response.sendRedirect(INDEX_PATH);
				} else {
					request.setAttribute("infoList", "您的信用分不足70，无法登录，请联系管理员");
					request.getRequestDispatcher(LOGIN_PATH).forward(request, response);
				}
			} else {
				request.setAttribute("infoList", "该用户已被禁用，请联系管理员");
				request.getRequestDispatcher(LOGIN_PATH).forward(request, response);
			}
		} else {
			request.setAttribute("infoList", "用户名或密码错误，请重新输入！");
			request.getRequestDispatcher(LOGIN_PATH).forward(request, response);
		}
		
	}
	private void userFind(HttpServletRequest request, HttpServletResponse response) throws IOException {
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

	private void sell(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String author=request.getParameter("author");
		BookDao bd = new BookDaoImpl();
			//默认当前页为第一页，每页最多能显示6条项目.
			int curPage = 1;
			int maxSize = 1;
			//只要page不为空，获取page更新为当前页的页码
			String page = request.getParameter("page");
			if (page != null) {
				curPage = Integer.parseInt(page); }
			//新建Pagebean对象，ad.bookReadCount()是在本方法新建的ad对象
			//在dao层执行 select（*）时得出的数据
			PageBean pb = new PageBean(curPage, maxSize, bd.sellCount(author));
			//1.传递dao层返回的包含数据的数组lu；2.传递pagebean包含的6个信息；
			//给jsp上的adminlist和pagebean方便adminlist.jsp下一步的遍历或者调用
			request.setAttribute("pageBean", pb);
			request.setAttribute("sellList", bd.sellList(pb,author));
			request.getRequestDispatcher(SELLLIST_PATH).forward(request, response);
	}
	private void remove(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String bookId = request.getParameter("id");
		String author = request.getParameter("author");
		BookDao bookDao = new BookDaoImpl();
		request.setAttribute("author", author);
		if(bookDao.bookState(Integer.parseInt(bookId),4)) {
			request.setAttribute("removeMessage", "下架成功！");
		}else {
			request.setAttribute("removeMessage", "操作失败");
		}
		sell(request,response);
	}
	private void reUpload(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String bookId = request.getParameter("id");
		String author = request.getParameter("author");
		BookDao bookDao = new BookDaoImpl();
		request.setAttribute("author", author);
		if(bookDao.bookState(Integer.parseInt(bookId),0)) {
			request.setAttribute("removeMessage", "重新上架成功！");
		}else {
			request.setAttribute("removeMessage", "操作失败");
		}
		sell(request,response);
	}
	private void payout(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		String bookId = request.getParameter("id");
		String author = request.getParameter("author");
		BookDao bookDao = new BookDaoImpl();
		request.setAttribute("author", author);
		if(bookDao.bookState(Integer.parseInt(bookId),3)) {
			request.setAttribute("removeMessage", "提现成功！");
		}else {
			request.setAttribute("removeMessage", "操作失败");
		}
		sell(request,response);
	};

	public String yanzheng(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String tell = request.getParameter("number");
		System.out.println("tell:" + tell);
		UserDao ud = new UserDaoImpl();
		JSONObject json = new JSONObject();
		if (ud.findUserByNumber(tell)) {
			json.put("info", "该号码已被注册");
			json.put("status", "n");
		} else {
			// 如果号码未被注册，则执行发送验证码的代码
			// 生成四位随机数字验证码
			Random random = new Random();
			String code = String.format("%04d", random.nextInt(10000));
			// 将验证码信息保存到session中，方便前端获取
			request.getSession().setAttribute("code", code);
			System.out.println("验证码为：" + code);
			// 发送过程，使用榛子云服务
			final String apiUrl = "https://sms_developer.zhenzikj.com";
			final String appId = "113862"; // 这里填写AppId
			final String appSecret = "8c34d8b1-8af5-4399-9e2c-602522207dba"; // 这里填写AppSecret
			ZhenziSmsClient client = new ZhenziSmsClient(apiUrl, appId, appSecret);
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("number", tell);
			params.put("templateId", "12846");
			String[] templateParams = new String[2];
			// 传入验证码和有效时间
			templateParams[0] = code;
			templateParams[1] = "5分钟";
			// 把参数放入map中
			params.put("templateParams", templateParams);
			// 调用send方法，进行发送
			String result = client.send(params);
			// 这里返回json格式的字符串，可以判断是否发送成功
			System.out.println("发送结果：" + result);
			// 返回发送成功的信息
			json.put("info", "验证码已发送，请注意查收！");
			json.put("status", "y");
			return result;
		}
		response.getWriter().write(json.toString());
		return null; // 或者返回其它需要的结果
	}

	private void findNumber(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String tell=request.getParameter("param");
		System.out.println("tell:"+tell);
		UserDao ud=new UserDaoImpl();
		JSONObject json=new JSONObject();
		if(ud.findUserByNumber(tell)){
			json.put("info", "该号码已被注册");
			json.put("status", "n");
		}else{
			json.put("info", "号码可以使用");
			json.put("status", "y");
		}
		response.getWriter().write(json.toString());


	}

}

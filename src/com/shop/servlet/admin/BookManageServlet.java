package com.shop.servlet.admin;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.bean.*;
import com.shop.dao.UpLoadVidDao;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.IOUtils;

import com.shop.dao.BookDao;
import com.shop.dao.CatalogDao;
import com.shop.dao.UpLoadImgDao;
import com.shop.dao.impl.UpLoadVidDaoImpl;
import com.shop.dao.impl.BookDaoImpl;
import com.shop.dao.impl.CatalogDaoImpl;
import com.shop.dao.impl.UpLoadImgDaoImpl;

import com.shop.util.RanUtil;

import net.sf.json.JSONObject;
@WebServlet("/jsp/admin/BookManageServlet")
public class BookManageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String BOOKLIST_PATH = "bookManage/bookList.jsp";// 商品列表页面地址
	private static final String BOOKADD_PATH = "bookManage/bookAdd.jsp";// 商品增加页面地址
	private static final String BOOKEDIT_PATH = "bookManage/bookEdit.jsp";// 商品修改页面地址
	private static final String BOOKIMGDIR_PATH="images/book/bookimg/";//商品图片保存文件夹相对路径
	private static final String BOOKVIDDIR_PATH="images/book/bookvid/";//商品视频保存文件夹相对路径
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		switch (action) {
		case "list":
			bookList(request, response);
			break;
		case "addReq":
			bookAddReq(request, response);
			break;
		case "add":
			bookAdd(request, response);
			break;
		case "edit":
			bookEdit(request, response);
			break;
		case "update":
			bookUpdate(request,response);
			break;
		case "find":
			bookFind(request, response);
			break;
		case "updateImg":
			updateImg(request,response);
			break;
		case "del":
		bookDel(request,response);
		break;
		case "batDel":
		bookBatDel(request,response);
		break;
	}
}
	//商品列表，在增删改过程中也有刷新，回到第一页的功能
	private void bookList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//在dao层新建对象
		BookDao bd = new BookDaoImpl();
		//默认当前页为第一页，每页最多能显示6条项目.
		int curPage = 1;
		int maxSize = 6;
		//只要page不为空，获取page更新为当前页的页码
		String page = request.getParameter("page");
		if (page != null) {
			curPage = Integer.parseInt(page); }
		//新建Pagebean对象，ad.bookReadCount()是在本方法新建的ad对象
		//在dao层执行 select（*）时得出的数据
		PageBean pb = new PageBean(curPage, maxSize, bd.bookReadCount());
		//1.传递dao层返回的包含数据的数组lu；2.传递pagebean包含的6个信息；
		//给jsp上的adminlist和pagebean方便adminlist.jsp下一步的遍历或者调用
		request.setAttribute("pageBean", pb);
		request.setAttribute("bookList", bd.bookList(pb));
		request.getRequestDispatcher(BOOKLIST_PATH).forward(request, response);
	}

	// 点击“添加用户后”1.获取商品分类信息
	private void bookAddReq(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//新建dao层对象 把分类名都传到bookadd.jsp
		CatalogDao cd = new CatalogDaoImpl();
		request.setAttribute("catalog", cd.getCatalog());
		request.getRequestDispatcher(BOOKADD_PATH).forward(request, response); }
	private void bookAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//默认flag 为 false
		boolean imgflag = false;
		boolean vidflag = false;
		//新建map用于保存商品信息（包括图片和视频以及表单普通数据）
		Map<String, String> map = new HashMap<>();
		//输入流、输出流默认为空
		InputStream inputStream = null;
		OutputStream outputStream = null;
		//输入流、输出流默认为空
		InputStream videoInputStream = null;
		OutputStream videoOutputStream = null;

		//String filePath = "E:\\0_java\\phone shop\\shop\\WebContent\\";
		//新建src dirPath
		File DirPath = new File(request.getServletContext().getRealPath("/") + BOOKIMGDIR_PATH);
		//如果dirpath不存在 则可以使用.mkdirs（）方法再建立下级目录
		if (!DirPath.exists()) { DirPath.mkdirs(); }

		//创建磁盘文件项目工厂
		DiskFileItemFactory dfif = new DiskFileItemFactory();
		//实例化Servlet文件上传对象，把'磁盘文件项目工厂'放入构造中
		ServletFileUpload servletFileUpload = new ServletFileUpload(dfif);
		//解决乱码
		servletFileUpload.setHeaderEncoding("ISO8859_1");
		//新建一个集合parseRequest，先设它为空
		//返回List<FileItem> 相当于每一个表单元素都是一个FileItem
		List<FileItem> parseRequest = null;
		try {
			//集合 parseRequest 得到所有上传表单对象
			parseRequest = servletFileUpload.parseRequest(request);
		} catch (FileUploadException e) {e.printStackTrace();}
		//用迭代器访问集合
		Iterator<FileItem> iterator = parseRequest.iterator();
		//遍历
		while (iterator.hasNext()) {
			FileItem fileItem = iterator.next();
			// 判断是否是表单的普通字段 true为普通表单字段，false为上传文件内容
			if (fileItem.isFormField()) {
				//其他非上传文件的数据，以（name名---获取页面上的值一一对应存入map中）
				String name = new String(fileItem.getFieldName().getBytes("ISO8859_1"), "utf-8");
				String value = new String(fileItem.getString().getBytes("ISO8859_1"), "utf-8");
				map.put(name, value);
				//上传的文件↓
			} else {
				//获取文件的类型
				String contentType = fileItem.getContentType();
				//重新命名图片文件 获取唯一uuid + 文件类型
				//命名成功以后  flag=true 才能保存信息到map集合里
				if (contentType != null) {
					if (contentType.startsWith("image")) {
						String imgName = null;
						if ("image/jpeg".equals(contentType)) {
							imgName = RanUtil.getUUID() + ".jpg";
							imgflag = true;
						} else if ("image/png".equals(contentType)) {
							imgName = RanUtil.getUUID() + ".png";
							imgflag = true;
						}
						if (imgflag) {
							inputStream = fileItem.getInputStream();
							File file = new File(DirPath, imgName);
							outputStream = new FileOutputStream(file);

							//保存img信息（文件名 文件路径 文件类型）到map集合中，后面传入对象使用
							map.put("imgName", imgName);
							map.put("imgSrc" , BOOKIMGDIR_PATH + imgName);
							map.put("imgType", contentType);

						}
					} else if (contentType.equals("video/mp4") ) {
						String videoName = RanUtil.getUUID() + ".mp4"; // 根据实际情况可能需要根据 contentType 设置文件扩展名
						vidflag = true;
						//保存视频文件到本地
						videoInputStream = fileItem.getInputStream();
						File videoFile = new File(DirPath, videoName);
						videoOutputStream = new FileOutputStream(videoFile);

						//保存视频文件信息到 map 集合
						map.put("vidName", videoName);
						map.put("vidSrc", BOOKIMGDIR_PATH + videoName);
						map.put("vidType", contentType);

					}
				}
			}
		}

		// 如果上传的内容小于3个必填项或者图片没有或类型不正确返回
		if (!imgflag || !vidflag) {
			//报bookmessage
			request.setAttribute("bookMessage", "商品添加失败");
			bookAddReq(request, response);
		} else {
			//验证通过后，保存图片流到本地
			IOUtils.copy(inputStream, outputStream);
			IOUtils.copy(videoInputStream, videoOutputStream);

			//把map集合中存储的（表单数据）提取出来转换为 book 对象封装
			//注意商品增加的字段要和数据库字段一致，不然map集合转对象会出错！
			Book book = new Book();
			//设置商品名、价格、描述、品牌、上市时间
			book.setBookName(map.get("bookName"));
			book.setPrice(Double.parseDouble(map.get("price")));
			book.setDescription(map.get("desc"));
			book.setAuthor(map.get("author"));
			book.setPress(map.get("press"));

			//商品分类信息 通过选择的catalog获取 分类id 放入book对象
			Catalog catalog = book.getCatalog();
			catalog.setCatalogId(Integer.parseInt(map.get("catalog")));

			//商品图片信息：图片名 src 文件类型
			UpLoadImg upLoadImg = book.getUpLoadImg();
			upLoadImg.setImgName(map.get("imgName"));
			upLoadImg.setImgSrc(map.get("imgSrc"));
			upLoadImg.setImgType(map.get("imgType"));

			//商品图片信息：视频名 src 文件类型
			UpLoadVid upLoadVid = book.getUpLoadVid();
			upLoadVid.setVidName(map.get("vidName"));
			upLoadVid.setVidSrc(map.get("vidSrc"));
			upLoadVid.setVidType(map.get("vidType"));
			//增加商品时先增加商品图片,增加商品图片成功了,再添加增加商品信息

			//1.新建Uploadimgdao对象
			UpLoadImgDao imgDao = new UpLoadImgDaoImpl();
			UpLoadVidDao vidDao = new UpLoadVidDaoImpl();
			//图片信息通过book对象getUpLoadImg()（获取图片名 src 图片类型）写入数据库！
			if (imgDao.imgAdd(upLoadImg)) {
				// 通过图片名获取商品图片添加后的id
				Integer imgId = imgDao.findIdByImgName(upLoadImg.getImgName());
				upLoadImg.setImgId(imgId); // 设置imgid

				// 视频信息通过book对象写入数据库
				if (vidDao.vidAdd(upLoadVid)) {
					// 通过视频名获取商品视频添加后的id
					Integer vidId = vidDao.findIdByVidName(upLoadVid.getVidName());
					upLoadVid.setVidId(vidId); // 设置vidid

					// 新建bookdao对象
					BookDao bd = new BookDaoImpl();
					// 商品信息写入数据库
					if (bd.bookAdd(book)) {
						request.setAttribute("bookMessage", "商品添加成功！");
						bookList(request, response); // 通过bookList更新商品列表
					} else {
						request.setAttribute("bookMessage", "商品添加失败1");
						bookAddReq(request, response);
					}
					// 图片或视频信息添加失败，报告商品添加失败
				} else {
					request.setAttribute("bookMessage", "商品添加失败2");
					bookAddReq(request, response);}
			}
		}
		//关闭输入/输出流
		IOUtils.closeQuietly(inputStream);
		IOUtils.closeQuietly(outputStream);
		IOUtils.closeQuietly(videoInputStream);
		IOUtils.closeQuietly(videoOutputStream);
	}

	//3.ajax查找商品是否存在
	private void bookFind(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String bookName = request.getParameter("param");
		BookDao bd = new BookDaoImpl();
		// 这里实例化json对象
		JSONObject json = new JSONObject();
		if (bd.findBookByBookName(bookName)) {
			json.put("info", "该商品已存在");
			json.put("status", "n");
		} else {
			json.put("info", "输入正确");
			json.put("status", "y");
		}
		response.getWriter().write(json.toString());
	}

	//商品删除
	//先删除数据库商品信息，再删除商品图片及本地硬盘图片信息
	private void bookDel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BookDao bd=new BookDaoImpl();
		//获取id
		int id=Integer.parseInt(request.getParameter("id"));
		//新建src路径dirPath
		File contextPath=new File(request.getServletContext().getRealPath("/"));
		UpLoadImgDao uid=new UpLoadImgDaoImpl();
		//找到id对应视图中的商品集合
		Book book=bd.findBookById(id);
		//调用dao层删除用户方法（若成功删除，返回true）
		if(bd.bookDelById(id)) {
			request.setAttribute("bookMessage", "商品已删除");
			if(uid.imgDelById(book.getImgId())) {
				//根据src路径删除本地文件
				File f=new File(contextPath,book.getUpLoadImg().getImgSrc());
				if(f.exists()) { f.delete(); } }
				}else {
					request.setAttribute("bookMessage", "商品删除失败");
		}
		//用户删除成功失败都通过servlet中Booklist跳到商品列表
		bookList(request, response);
	}
	//商品批量删除
	private void bookBatDel(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//获取多选的商品ids
		String ids=request.getParameter("ids");
		BookDao bd=new BookDaoImpl();
		UpLoadImgDao uid=new UpLoadImgDaoImpl();
		File contextPath=new File(request.getServletContext().getRealPath("/"));
		//通过选中商品id 批量查询图片的id，并组成一组字符串
		String imgIds=bd.findimgIdByIds(ids);
		//此处的list 是通过批量select 得出的 uploadingimg数据
		List<UpLoadImg> list = uid.findImgByIds(imgIds);
		if(bd.bookBatDelById(ids)) {//←商品数据库先删
			request.setAttribute("bookMessage", "商品已批量删除！");
			//批量删除本地文件↓
			if(uid.imgBatDelById(imgIds)) {//←图片数据库再删
				//所有选中的商品组成的集合
				for(UpLoadImg uli:list) {
					//获取src 然后根据路径delete！
					File f=new File(contextPath,uli.getImgSrc());
					if(f.exists()) { f.delete();
					}
				}
			}
		}else {
			request.setAttribute("bookMessage", "商品批量删除失败");
		}
		//用户删除成功失败都通过servlet中Booklist跳到用户列表
		bookList(request, response);
	}

	//1.接收商品修改请求【获取id、分类信息、商品信息（从视图里找）】
	private void bookEdit(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//获取要修改的商品的id
		int bookId = Integer.parseInt(request.getParameter("id"));
		BookDao bookDao = new BookDaoImpl();
		CatalogDao catalogDao = new CatalogDaoImpl();
		//获取商品分类信息 放到"catalog"传入bookedit.jsp
		request.setAttribute("catalog", catalogDao.getCatalog());
		//通过id在视图中获取商品信息 放到"bookInfo"
		request.setAttribute("bookInfo", bookDao.findBookById(bookId));
		//前往bookedit.jsp
		request.getRequestDispatcher(BOOKEDIT_PATH).forward(request, response);
	}
	//2.商品表单数据更新
	private void bookUpdate(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BookDao bookDao=new BookDaoImpl();
		Book book=new Book();
		//表单数据直接用.getParameter（）更新
		book.setBookId(Integer.parseInt(request.getParameter("bookId")));
		book.setCatalogId(Integer.parseInt(request.getParameter("catalog")));
		book.setAuthor(request.getParameter("author"));
		book.setPress(request.getParameter("press"));
		book.setPrice(Double.parseDouble(request.getParameter("price")));
		book.setDescription(request.getParameter("desc"));
		//执行dao层语句
		if(bookDao.bookUpdate(book)) {
			request.setAttribute("bookMessage", "修改成功！");
			bookList(request, response);
		}else {
			request.setAttribute("bookMessage", "修改失败");
			request.setAttribute("bookInfo", bookDao.findBookById(book.getBookId()));
			request.getRequestDispatcher(BOOKEDIT_PATH).forward(request, response);
		}
	}
	//3.更新商品图片
	private void updateImg(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
		//获取商品id
		int bookId = Integer.parseInt(request.getParameter("id"));
		//重新设置变量
		boolean flag = false;
		String imgSrc = null;
		OutputStream outputStream = null;
		InputStream inputStream = null;
		String imgName = null;
		String contentType = null;
		//新建dao层对象
		BookDao bookDao = new BookDaoImpl();
		UpLoadImgDao upImgDao = new UpLoadImgDaoImpl();
		//新建src dirPath
		File contextPath=new File(request.getServletContext().getRealPath("/"));
		File dirPath = new File( contextPath,BOOKIMGDIR_PATH);
		//如果dirpath不存在 则可以使用.mkdirs（）方法再建立下级目录
		if (!dirPath.exists()) { dirPath.mkdirs(); }
		//创建磁盘文件项目工厂
		DiskFileItemFactory dfif = new DiskFileItemFactory();
		//实例化Servlet文件上传对象，把'磁盘文件项目工厂'放入构造中
		ServletFileUpload servletFileUpload = new ServletFileUpload(dfif);
		//新建一个集合parseRequest，先设它为空
		//返回的List<FileItem> 相当于每一个表单元素都是一个FileItem
		List<FileItem> parseRequest = null;
		try {//集合 parseRequest 得到所有上传表单对象（这里只有图片）
			parseRequest = servletFileUpload.parseRequest(request);
		} catch (FileUploadException e) { e.printStackTrace(); }
		//用迭代器访问集合
		Iterator<FileItem> iterator = parseRequest.iterator();
		//遍历
		while (iterator.hasNext()) {
			FileItem fileItem = iterator.next();
			//如果不是表单数据（这里的确没有表单数据）
			if (!fileItem.isFormField()) {
				inputStream = fileItem.getInputStream();
				//获取文件类型
				contentType = fileItem.getContentType();
				//重新命名图片文件 获取唯一uuid + 文件类型
				//命名成功以后  flag=true 才能保存信息到map集合里
				if ("image/jpeg".equals(contentType)) {
					imgName = RanUtil.getUUID() + ".jpg";
					flag = true;
				}
				if ("image/png".equals(contentType)) {
					imgName = RanUtil.getUUID() + ".png";
					flag = true;
				}
			}
		}
		//命名成功后保存img信息
		if (flag) {
			//定义图片src
			imgSrc = BOOKIMGDIR_PATH + imgName;
			outputStream = new FileOutputStream(new File(contextPath,imgSrc));
			//验证通过后，保存图片流到本地
			IOUtils.copy(inputStream, outputStream);
			//关闭输入、输出流
			outputStream.close();
			inputStream.close();

			//根据商品id去查询图片原来的信息
			Book book = bookDao.findBookById(bookId);
			UpLoadImg upImg = book.getUpLoadImg();
			//如果旧图片文件存在，将其通过路径删除
			File oldImg = new File(contextPath,book.getUpLoadImg().getImgSrc());
			if (oldImg.exists()) { oldImg.delete(); }
			//封装UploadImg对象
			upImg.setImgName(imgName);
			upImg.setImgSrc(imgSrc);
			upImg.setImgType(contentType);
			//执行dao层
			if (upImgDao.imgUpdate(upImg)) {
				request.setAttribute("bookMessage", "图片修改成功！");
			} else {
				request.setAttribute("bookMessage", "图片修改失败"); }
			} else {
			request.setAttribute("bookMessage", "图片修改失败");
		}bookEdit(request,response);
	}

	// 获取文件扩展名的方法
	private String getFileExtension(String contentType) {
		if (contentType.equalsIgnoreCase("image/jpeg")) {
			return ".jpg";
		} else if (contentType.equalsIgnoreCase("image/png")) {
			return ".png";
		}
		return "";
	}}
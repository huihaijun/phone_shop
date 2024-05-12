package com.shop.servlet.book;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.shop.bean.Book;
import com.shop.bean.Catalog;
import com.shop.dao.BookDao;
import com.shop.dao.CatalogDao;
import com.shop.dao.impl.BookDaoImpl;
import com.shop.dao.impl.CatalogDaoImpl;

import net.sf.json.JSONObject;

/**
 * 
 * Servlet implementation class Index
 */
@WebServlet("/ShopIndex")
public class ShopIndex extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

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
		
		response.setContentType("text/json"); 
		JSONObject json = new JSONObject();
		
		BookDao bd=new BookDaoImpl();
		List<Book> recBooks = bd.bookList(10);
		json.put("recBooks", recBooks);
		List<Book> newBooks = bd.newBooks(10);
		json.put("newBooks", newBooks);
		
		PrintWriter pw = response.getWriter();
		pw.print(json);
		pw.flush();
		
		
	}

}

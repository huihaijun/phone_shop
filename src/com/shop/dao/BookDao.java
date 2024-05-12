package com.shop.dao;

import java.util.List;

import com.shop.bean.Book;
import com.shop.bean.Catalog;
import com.shop.bean.Order;
import com.shop.bean.PageBean;

import net.sf.json.JSONObject;

public interface BookDao {

	// 获取商品分页列表 (视图)
	List<Book> bookList(PageBean pageBean);

	// 获取商品总数
	long bookReadCount();

	// 增加商品
	boolean bookAdd(Book book);
	// 根据商品名称查找商品是否存在
	boolean findBookByBookName(String bookName);

	// 更新商品信息
	boolean bookUpdate(Book book);


	// 根据id删除商品
	boolean bookDelById(int bookId);

	// 批量删除商品
	boolean bookBatDelById(String ids);

	// 根据id串查询图片id串
	String findimgIdByIds(String ids);

	// 根据商品id查找商品信息(视图)
	Book findBookById(int bookId);

	//----------------------------------

	// 按分类获取商品数量
	long bookReadCount(int catalogId);

	// 按分类获取商品分页列表(视图)
	List<Book> bookList(PageBean pageBean, int catalogId);

	// 按分类获取商品分页列表(视图)
	List<Book> bookListByKeyword(PageBean pageBean, String bookName);

	// 随机获取指定数量书
	List<Book> bookList(int num);

	// 获取指定数量新添加的商品
	List<Book> newBooks(int num);

	//模糊查询
	List<Book> findBooksByBookName(String bookName);

	// 按分类获取商品数量
	long bookReadCountByKeyword(String bookName);

//	查用户在售
	List<Book> sellList(PageBean pageBean, String author);
	//统计总订单数(by userId)

	long sellCount(String author);

	boolean bookState(int bookId,int state);
}

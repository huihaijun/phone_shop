package com.shop.dao.impl;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.shop.bean.*;
import com.shop.dao.BookDao;
import com.shop.util.DateUtil;
import com.shop.util.DbUtil;

public class BookDaoImpl implements BookDao {

	@Override
	public List<Book> bookList(PageBean pageBean) {
		List<Book> list = new ArrayList<>();
		String sql = "select * from view_product WHERE state = 0 order by bookId desc limit ?,?";
		// 查询的分页结果集
		List<Map<String, Object>> lm = DbUtil.executeQuery
				(sql, (pageBean.getCurPage() - 1) * pageBean.getMaxSize(),
				pageBean.getMaxSize());
		// 把查询的book结果由List<Map<String, Object>>转换为List<Book>
		if (lm.size() > 0) {
			for (Map<String, Object> map : lm) {
				Book book = new Book(map);
				list.add(book);
			}
		}
		return list;
	}

	@Override
	public long bookReadCount() {
		String sql = "select count(*) as count from s_product";
		List<Map<String, Object>> lm = DbUtil.executeQuery(sql);
		return lm.size() > 0 ? (long) lm.get(0).get("count") : 0;
	}

	//商品添加！
	@Override
	public boolean bookAdd(Book book) {
		String sql = "insert into s_product(bookName,catalogId,author,press,price,description,imgId,vidId,addTime) values(?,?,?,?,?,?,?,?,?)";
		int i = DbUtil.excuteUpdate(sql, book.getBookName(), book.getCatalog().getCatalogId(), book.getAuthor(),
				book.getPress(), book.getPrice(), book.getDescription(), book.getUpLoadImg().getImgId(),book.getUpLoadVid().getVidId(),
				DateUtil.getTimestamp());
		if(i > 0){
			return true;
		}
		return false;
	}

	@Override
	public Book findBookById(int bookId) {
		String sql = "select * from view_product where bookId=?";
		Book book = null;
		List<Map<String, Object>> list = DbUtil.executeQuery(sql, bookId);
		if (list.size() > 0) {
			book = new Book(list.get(0));
		}
		return book;
	}

	/**
	 * 
	 */
	@Override
	public boolean findBookByBookName(String bookName) {
		String sql = "select * from s_product where bookName=?";
		List<Map<String, Object>> list = DbUtil.executeQuery(sql, bookName);
		return list.size() > 0 ? true : false;
	}

	/**
	 * 更新商品信息
	 */
	@Override
	public boolean bookUpdate(Book book) {
		String sql = "update s_product set catalogId=?,author=?,press=?,price=?,description=? where bookId=?";
		int i = DbUtil.excuteUpdate(sql, book.getCatalogId(), book.getAuthor(), book.getPress(), book.getPrice(),
				book.getDescription(), book.getBookId());
		return i > 0 ? true : false;
	}

	/**
	 * 商品删除
	 */
	@Override
	public boolean bookDelById(int bookId) {
		String sql = "delete from s_product where bookId=?";
		int i = DbUtil.excuteUpdate(sql, bookId);
		return i > 0 ? true : false;
	}

	/**
	 * 批量查询
	 */
	@Override
	public String findimgIdByIds(String ids) {
		String imgIds = "";
		String sql = "select imgId from s_product where bookId in(" + ids + ")";
		List<Map<String, Object>> list = DbUtil.executeQuery(sql);
		if (list.size() > 0) {
			for (int i = 0; i < list.size(); i++) {
				if (i != list.size() - 1) {
					imgIds += list.get(i).get("imgId") + ",";
				} else {
					imgIds += list.get(i).get("imgId");
				}
			}
		}
		return imgIds;
	}

	// 批量删除
	@Override
	public boolean bookBatDelById(String ids) {
		String sql = "delete from s_product where bookId in(" + ids + ")";
		int i = DbUtil.excuteUpdate(sql);
		return i > 0 ? true : false;
	}

	// 随机查询一定数量的书
	@Override
	public List<Book> bookList(int num) {
		List<Book> list = new ArrayList<>();
		String sql = "select * from view_product WHERE state = 0 order by rand() LIMIT ?";
		List<Map<String, Object>> lm = DbUtil.executeQuery(sql, num);
		// 把查询的book结果由List<Map<String, Object>>转换为List<Book>
		if (lm.size() > 0) {
			for (Map<String, Object> map : lm) {
				Book book = new Book(map);
				list.add(book);
			}
		}
		return list;
	}

	/**
	 * 查询指定数量新书
	 */
	@Override
	public List<Book> newBooks(int num) {
		List<Book> list = new ArrayList<>();
		String sql = "SELECT * FROM view_product WHERE state = 0 ORDER BY addTime desc limit 0,?";
		List<Map<String, Object>> lm = DbUtil.executeQuery(sql, num);
		// 把查询的book结果由List<Map<String, Object>>转换为List<Book>
		if (lm.size() > 0) {
			for (Map<String, Object> map : lm) {
				Book book = new Book(map);
				list.add(book);
			}
		}
		return list;
	}

	/**
	 * 按分类id统计商品数量
	 */
	@Override
	public long bookReadCount(int catalogId) {
		String sql = "select count(*) as count from s_product where catalogId=?";
		List<Map<String, Object>> lm = DbUtil.executeQuery(sql, catalogId);
		return lm.size() > 0 ? (long) lm.get(0).get("count") : 0;
	}

	/**
	 * 按分类id获取商品列表
	 */
	@Override
	public List<Book> bookList(PageBean pageBean, int catalogId) {
		List<Book> list = new ArrayList<>();

		String sql = "select * from view_product where state=0 and catalogId=? limit ?,?";
		// 查询的分页结果集
		List<Map<String, Object>> lm = DbUtil.executeQuery(sql, catalogId,
				(pageBean.getCurPage() - 1) * pageBean.getMaxSize(), pageBean.getMaxSize());

		// 把查询的book结果由List<Map<String, Object>>转换为List<Book>
		if (lm.size() > 0) {
			for (Map<String, Object> map : lm) {
				Book book = new Book(map);
				list.add(book);
			}
		}
		return list;
	}


	@Override
	public List<Book> bookListByKeyword(PageBean pageBean, String bookName) {
		List<Book> list = new ArrayList<>();
		System.out.println("bookListByKeyword模糊搜索查询结果: " + bookName);
		String sql = "select * from view_product where bookName like ? AND state = 0";
		// 查询的分页结果集
		List<Map<String, Object>> lm = DbUtil.executeQuery(sql, "%" + bookName + "%",
				(pageBean.getCurPage() - 1) * pageBean.getMaxSize(), pageBean.getMaxSize());

		// 把查询的book结果由List<Map<String, Object>>转换为List<Book>
		if (lm.size() > 0) {
			for (Map<String, Object> map : lm) {
				Book book = new Book(map);
				list.add(book);
			}
		}
		return list;
	}

	@Override
	public List<Book> findBooksByBookName(String bookName) {
//		System.out.println("模糊搜索查询结果: " + bookName);
		List<Book> list = new ArrayList<>();
		String sql = "select * from view_product where bookName like ? AND state = 0";
		// 查询的结果集
		List<Map<String, Object>> lm = DbUtil.executeQuery(sql, "%" + bookName + "%");
		// 把查询的book结果由List<Map<String, Object>>转换为List<Book>
		if (lm.size() > 0) {
			for (Map<String, Object> map : lm) {
				Book book = new Book(map);
				list.add(book);
			}
		}
//		for (Book book : list) {
//			System.out.println(book);
//		}
		return list;
	}
	/**
	 * 根据关键字统计商品数量
	 */
	@Override
	public long bookReadCountByKeyword(String bookName) {
		String sql = "select count(*) as count from s_product where productName like ?";
		List<Map<String, Object>> lm = DbUtil.executeQuery(sql, "%" + bookName + "%");
		return lm.size() > 0 ? (long) lm.get(0).get("count") : 0;
	}

	@Override
	public List<Book> sellList(PageBean pageBean, String author) {
		List<Book> lb = new ArrayList<>();
		String sql = "SELECT p.*, i.imgSrc FROM s_product p JOIN s_uploadimg i ON p.imgId = i.imgId WHERE p.author=? ORDER BY p.bookId DESC LIMIT ?,?";
		List<Map<String, Object>> list = DbUtil.executeQuery(sql, author, (pageBean.getCurPage() - 1) * pageBean.getMaxSize(), pageBean.getMaxSize());
		if (list.size() > 0) {
			for (Map<String, Object> map : list) {
				Book book = new Book(map);
				// 将图片的imgSrc直接封装到Book对象中
				book.getUpLoadImg().setImgSrc((String) map.get("imgSrc"));
				lb.add(book);
			}
			System.out.println(lb);
		}
		return lb;
	}

//	public List<Book> sellList(PageBean pageBean, String author) {
//
//		List<Book> lb=new ArrayList<>();
//		String sql="select * from s_product where author=? order by bookId desc limit ?,?";
//		List<Map<String, Object>> list = DbUtil.executeQuery(sql,author,(pageBean.getCurPage()-1)*pageBean.getMaxSize(),pageBean.getMaxSize());
//		if(list.size()>0) {
//			for(Map<String,Object> map:list) {
//				Book book=new Book(map);
//				lb.add(book);
//			}
//			System.out.println(lb);
//		}
//		return lb;
//	}

	@Override
	public long sellCount(String author) {
		String sql = "select count(*) as count from s_product where author=?";
		List<Map<String, Object>> lm = DbUtil.executeQuery(sql,author);
		return lm.size() > 0 ? (long) lm.get(0).get("count") : 0;
	}

	@Override
	public boolean bookState(int bookId, int state){
		String sql = "update s_product set state = ? where bookId = ?";
		int i = DbUtil.excuteUpdate(sql, state, bookId);
		return i > 0?true:false;
	}
}

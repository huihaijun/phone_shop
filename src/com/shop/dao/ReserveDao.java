package com.shop.dao;
import java.util.List;

import com.shop.bean.Book;
import com.shop.bean.PageBean;
import com.shop.bean.Reserve;


public interface ReserveDao {

	long reserveCount();
	// 添加预约信息
	boolean addReserve(Reserve reserve);
	//模糊查询
	List<Reserve> findReserve(String date);

	List<Reserve> reserveList(PageBean pageBean);


}

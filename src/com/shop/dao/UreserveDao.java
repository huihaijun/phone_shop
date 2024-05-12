package com.shop.dao;

import com.shop.bean.PageBean;
import com.shop.bean.Ureserve;

import java.util.List;


public interface UreserveDao {

	//获取总记录数
	long UreserveReadCount();

	// 添加预约信息
	boolean addUreserve(Ureserve ureserve);


	List<Ureserve> findUserReserve(PageBean pageBean,int userId);

	//根据id删除一个预约
	boolean delreserve(int reid);

	List<Ureserve> viewReserve(String date, String period);

	boolean ureserveStatus(int reid, int state);


	//模糊查询
//	List<Ureserve> findureserve(String date);

//	List<Ureserve> ureserveList(PageBean pageBean);


}

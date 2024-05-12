package com.shop.dao;

import java.util.List;

import com.shop.bean.Catalog;
import com.shop.bean.PageBean;

/*
 * 商品分类dao层
 */
public interface CatalogDao {

	//获取商品分类信息（返回一个分页集合）
	List<Catalog> catalogList(PageBean pb);

	//统计分类的总数
	long catalogReadCount();

	//增加分类
	boolean catalogAdd(String catalogName);
	//删除分类
	boolean catalogDel(int catalogId);
	//批量删除分类
	boolean catalogBatDelById(String ids);
	//根据用户名查找分类名称（用于ajax判断）
	boolean findCatalogByCatalogName(String catalogName);


	//获取商品分类信息
	List<Catalog> getCatalog();


}

package com.shop.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.shop.bean.Catalog;
import com.shop.bean.PageBean;
import com.shop.dao.CatalogDao;
import com.shop.util.DbUtil;

public class CatalogDaoImpl implements CatalogDao {
	@Override
	//返回一个集合，这里是通过limit分页查询的结果list
	//这里的pagebean是在servlet里面定义的传来的参数
	public List<Catalog> catalogList(PageBean pb) {
		//真正存储分页结果的数组list
		List<Catalog> list=new ArrayList<Catalog>();
		String sql = "select * from s_catalog limit ?,?";
		// 查询的分页结果集 从第  -（当前页-1）*6条 -  的下一条数据开始，往后的6条数据
		List<Map<String, Object>> lm = DbUtil.executeQuery
				(sql, (pb.getCurPage() - 1) * pb.getMaxSize(), pb.getMaxSize());
		//若lm不为空，则将list中的每一条数据通过新建catalog对象遍历
		//传到真正存储分页结果的数组（此处为list）
		if(lm.size()>0){
			for(Map<String,Object> map:lm){
			Catalog catalog=new Catalog(map);
			list.add(catalog);
			}
		}	
		return list; 
	}
	@Override
	//通过select数据库中所有分类，计算个数，反映到servlet中的Pagebean方法的readCount位置
	public long catalogReadCount() {
		long count=0;
		String sql="select count(*) as count from s_catalog";
		List<Map<String, Object>> lm=DbUtil.executeQuery(sql);
		if(lm.size()>0){
			count=(long) lm.get(0).get("count");
		}
		return count;
	}
	@Override
	//根据id删除数据，并返回布尔值，true删除分类成功，false删除分类失败
	public boolean catalogDel(int catalogId) {
		String sql = "delete from s_catalog where catalogId=?";
		int i = DbUtil.excuteUpdate(sql, catalogId);
		return i > 0 ? true : false;
	}

	@Override
	//根据ids批量删除数据，并返回布尔值，true删除分类成功，false删除分类失败
	public boolean catalogBatDelById(String ids) {
		String sql="delete from s_catalog where catalogId in("+ids+")";
		int i=DbUtil.excuteUpdate(sql);
		return i>0?true:false;
	}


	//增加分类 并返回布尔值，true增加成功，false增加失败
	@Override
	public boolean catalogAdd(String catalogName) {
		String sql="insert into s_catalog(catalogName) values(?)";
		int i = DbUtil.excuteUpdate(sql, catalogName);
		return i > 0 ? true : false;
	}


	@Override
	//在数据库查找用户名是否存在true存在 判断用户是否已经存在
	public boolean findCatalogByCatalogName(String catalogName) {
		String sql = "select * from s_catalog where catalogName=?";
		List<Map<String, Object>> list = DbUtil.executeQuery(sql, catalogName);
		return list.size() > 0 ? true : false;
	}

	@Override
	public List<Catalog> getCatalog() {
		List<Catalog> list=new ArrayList<Catalog>();
		String sql="select * from s_catalog";
		List<Map<String,Object>> lmso=DbUtil.executeQuery(sql);
		if(lmso.size()>0){
			for(Map<String,Object> map:lmso){
				Catalog catalog=new Catalog(map);
				list.add(catalog);
			}
		}
		return list;
	}


}

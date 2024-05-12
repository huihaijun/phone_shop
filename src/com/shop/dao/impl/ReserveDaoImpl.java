package com.shop.dao.impl;
import com.shop.bean.Book;
import com.shop.bean.PageBean;
import com.shop.bean.Reserve;
import com.shop.bean.User;
import com.shop.dao.ReserveDao;
import com.shop.dao.UserDao;
import com.shop.util.DbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ReserveDaoImpl implements ReserveDao {
	@Override
	public long reserveCount() {
		long count=0;
		//select所有用户
		String sql="select count(*) as count from s_reserve";
		List<Map<String, Object>> lm=DbUtil.executeQuery(sql);
		//lm若不为空，则得出数据条数，得出一共有多少条信息
		if(lm.size()>0){
			count=(long) lm.get(0).get("count");
		}
		return count;
	}

	@Override
		//返回一个list集合，这里是通过limit分页查询的结果lu
		//这里的pagebean是在servlet里面定义的传来的参数
	public List<Reserve> reserveList(PageBean pageBean) {
			//真正存储分页结果的数组lu
		List<Reserve> lr=new ArrayList<>();
		List<Map<String, Object>> list=new ArrayList<Map<String,Object>>();

		String sql="select * from s_reserve limit ?,?";
			//从第  -（当前页-1）*6条 -  的下一条数据开始，往后的6条数据
		list=DbUtil.executeQuery(sql,
				(pageBean.getCurPage()-1)*pageBean.getMaxSize(),pageBean.getMaxSize());
			//若list不为空，则将list中的每一条数据通过新建user对象u遍历
			//传到真正存储分页结果的数组（此处为lu）
		if(list.size()>0) {
			for(Map<String,Object> map:list) {
				Reserve r=new Reserve(map);
				lr.add(r);
			}
		}
		return lr;
	}
	@Override
	public boolean addReserve(Reserve reserve) {
		// 定义SQL查询语句，用于检查指定日期和时间段是否已存在预约记录
		String sqlQuery = "SELECT Num, nownum FROM s_reserve WHERE date = ? AND period = ?";
		// 定义SQL插入语句，用于在数据库中插入新的预约记录
		String sqlInsert = "INSERT INTO s_reserve(date, period, Num) VALUES (?, ?, ?)";
		// 定义SQL更新语句，用于更新现有的预约记录中的数量
		String sqlUpdate = "UPDATE s_reserve SET Num = ? WHERE date = ? AND period = ? AND nownum = 0";
		try (Connection conn = DbUtil.getConnection();
			 // 准备查询语句
			 PreparedStatement stmtQuery = conn.prepareStatement(sqlQuery);
			 // 准备插入语句
			 PreparedStatement stmtInsert = conn.prepareStatement(sqlInsert);
			 // 准备更新语句
			 PreparedStatement stmtUpdate = conn.prepareStatement(sqlUpdate)) {
			// 设置查询语句的参数，即日期和时间段
			stmtQuery.setString(1, reserve.getDate());
			stmtQuery.setString(2, reserve.getPeriod());
			// 执行查询
			ResultSet rs = stmtQuery.executeQuery();
			// 如果查询结果存在
			if (rs.next()) {
				int nownum = rs.getInt("nownum");
				// 如果nownum为0，则更新预约数量
				if (nownum == 0) {
					// 设置更新语句的参数，即预约数量、日期和时间段
					stmtUpdate.setInt(1, reserve.getNum());
					stmtUpdate.setString(2, reserve.getDate());
					stmtUpdate.setString(3, reserve.getPeriod());
					// 执行更新，并返回更新的行数
					int rowsUpdated = stmtUpdate.executeUpdate();
					// 如果更新成功，则返回true，表示预约添加成功
					return rowsUpdated > 0;
				} else {
					// 如果nownum不为0，则直接返回false，表示预约添加失败
					return false;
				}
			} else {
				// 如果查询结果不存在，则插入新的预约记录
				// 设置插入语句的参数，即日期、时间段和预约数量
				stmtInsert.setString(1, reserve.getDate());
				stmtInsert.setString(2, reserve.getPeriod());
				stmtInsert.setInt(3, reserve.getNum());
				// 执行插入，并返回插入的行数
				int rowsInserted = stmtInsert.executeUpdate();
				// 如果插入成功，则返回true，表示预约添加成功
				return rowsInserted > 0;
			}
		} catch (SQLException e) {
			// 捕获并打印SQL异常
			e.printStackTrace();
			// 返回false，表示预约添加失败
			return false;
		}
	}

	@Override
	public List<Reserve> findReserve(String date) {
		List<Reserve> list = new ArrayList<>();
		String sql = "select * from s_reserve where date = ? order by period asc";
		// 查询的结果集
		List<Map<String, Object>> lm = DbUtil.executeQuery(sql, date);
		// 把查询的book结果由List<Map<String, Object>>转换为List<Book>
		if (lm.size() > 0) {
			for (Map<String, Object> map : lm) {
				Reserve r = new Reserve(map);
				list.add(r);
			}
		}
		return list;
	}
}
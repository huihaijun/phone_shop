package com.shop.dao.impl;
import com.shop.bean.*;

import com.shop.dao.UreserveDao;
import com.shop.util.DbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class UreserveDaoImpl implements UreserveDao {


	@Override
	public boolean addUreserve(Ureserve ureserve) {
		// 检查数据库中是否已经存在相同的 userid 和 date 记录
		String checkIfExistsSql = "SELECT COUNT(*) FROM s_ureserve WHERE userId = ? AND date = ?";
		String updateReserveSql = "UPDATE s_reserve SET nownum = nownum + 1 WHERE date = ? AND period = ?";
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = DbUtil.getConnection();
			conn.setAutoCommit(false); // 设置手动提交事务

			// 检查是否已经存在相同记录
			stmt = conn.prepareStatement(checkIfExistsSql);
			stmt.setInt(1, ureserve.getUserid());
			stmt.setString(2, ureserve.getDate());
			rs = stmt.executeQuery();
			if (rs.next()) {
				int count = rs.getInt(1);
				if (count > 0) {
					// 如果存在相同记录，则返回 false
					return false;
				}
			}

			// 如果不存在相同记录，则执行插入操作
			String insertSql = "INSERT INTO s_ureserve(userId, userName,name,tell, date, period) VALUES (?, ?, ?, ?, ?, ?)";
			stmt = conn.prepareStatement(insertSql);
			stmt.setInt(1, ureserve.getUserid());
			stmt.setString(2, ureserve.getUserName());
			stmt.setString(3, ureserve.getName());
			stmt.setString(4, ureserve.getTell());
			stmt.setString(5, ureserve.getDate());
			stmt.setString(6, ureserve.getPeriod());
			int i = stmt.executeUpdate();
			if (i <= 0) {
				// 插入失败，回滚事务
				conn.rollback();
				return false;
			}

			// 更新 s_reserve 表的 nownum
			stmt = conn.prepareStatement(updateReserveSql);
			stmt.setString(1, ureserve.getDate());
			stmt.setString(2, ureserve.getPeriod());
			stmt.executeUpdate();

			// 提交事务
			conn.commit();
			return true;
		} catch (SQLException e) {
			e.printStackTrace();
			// 处理异常，回滚事务并返回 false 或者抛出异常
			if (conn != null) {
				try {
					conn.rollback();
				} catch (SQLException ex) {
					ex.printStackTrace();
				}
			}
			return false;
		} finally {
			// 手动关闭连接、语句和结果集
			try {
				if (rs != null) {
					rs.close();
				}
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	@Override
	public List<Ureserve> findUserReserve(PageBean pageBean,int userId) {
		List<Ureserve> lu=new ArrayList<>();
		List<Map<String, Object>> list=new ArrayList<Map<String,Object>>();
		String sql="select * from s_ureserve where userId=? limit ?,? ";
		list=DbUtil.executeQuery(sql,userId,
				(pageBean.getCurPage()-1)*pageBean.getMaxSize(),pageBean.getMaxSize());
		if(list.size()>0) {
			for(Map<String,Object> map:list) {
				Ureserve ureserve=new Ureserve(map);
				lu.add(ureserve);
			}
		}
		return lu;

	}

	@Override
	public long UreserveReadCount() {
		long count=0;
		//select所有用户
		String sql="select count(*) as count from s_ureserve";
		List<Map<String, Object>> lm=DbUtil.executeQuery(sql);
		//lm若不为空，则得出数据条数，得出一共有多少条信息
		if(lm.size()>0){
			count=(long) lm.get(0).get("count");
		}
		return count;
	}

@Override
public boolean delreserve(int reid) {
	// 获取被删除的记录的日期和时间段信息
	String selectSql = "SELECT date, period FROM s_ureserve WHERE reid = ?";
	List<Map<String, Object>> result = DbUtil.executeQuery(selectSql, reid);
	if (result.size() > 0) {
		Map<String, Object> record = result.get(0);
		String date = (String) record.get("date");
		String period = (String) record.get("period");
		// 删除 s_ureserve 表中指定记录
		String deleteSql = "DELETE FROM s_ureserve WHERE reid = ?";
		int rowsAffected = DbUtil.excuteUpdate(deleteSql, reid);
		// 如果删除成功，则更新 s_reserve 表中符合条件的记录的 nownum 字段值
		if (rowsAffected > 0) {
			String updateSql = "UPDATE s_reserve SET nownum = nownum - 1 WHERE date = ? AND period = ?";
			int updateRows = DbUtil.excuteUpdate(updateSql, date, period);
			return updateRows > 0;
		}
	}
	return false;
	}

	@Override
	public List<Ureserve> viewReserve(String date, String period) {
		List<Ureserve> list = new ArrayList<>();
		String sql = "SELECT * FROM s_ureserve WHERE date = ? AND period = ?";
		// 查询的结果集
		List<Map<String, Object>> lm = DbUtil.executeQuery(sql, date, period);
		// 把查询的结果转换为 List<Reserve>
		for (Map<String, Object> map : lm) {
			Ureserve r = new Ureserve(map);
			list.add(r);
			System.out.println(list);
		}
		return list;
	}

	@Override
	public boolean ureserveStatus(int reid, int state) {
		String sql = "update s_ureserve set state=? where reid=?";
		int i = DbUtil.excuteUpdate(sql, state, reid);
		if (i > 0) {
			if (state == 2) {
				String sql2 = "update s_user set credit = credit - 10 where userId = (select userId from s_ureserve where reid = ?)";
				int j = DbUtil.excuteUpdate(sql2, reid);
				return j > 0;
			} else {
				System.out.println("jiafen");
				String sql3 = "update s_user set credit = credit + 5 where userId = (select userId from s_ureserve where reid = ?)";
				int k = DbUtil.excuteUpdate(sql3, reid);
				return k > 0;
			}
		}
		return false;
	}

}
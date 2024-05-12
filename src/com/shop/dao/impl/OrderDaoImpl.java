package com.shop.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.shop.bean.Order;
import com.shop.bean.PageBean;
import com.shop.bean.User;
import com.shop.dao.OrderDao;
import com.shop.util.DbUtil;


public class OrderDaoImpl implements OrderDao {
	/**
	 * 向s_order插入一条订单记录
	 */
	@Override
	public boolean orderAdd(Order order) {
		String sql="insert into s_order(orderNum,userId,orderDate,orderStatus,money,name,tell) values(?,?,?,?,?,?,?)";
		int i= DbUtil.excuteUpdate(sql,order.getOrderNum(),order.getUserId(),order.getOrderDate(),order.getOrderStatus(),order.getMoney(),order.getName(),order.getTell());
		if (i > 0) {
			String sql01 = "update s_product set state = 1 where bookId in (select bookId from s_orderitem where orderId = ( select orderID from s_order order by orderId limit 1))";
			int j = DbUtil.excuteUpdate(sql01);
			return j > 0;
		}
		return false;
	}
	/**
	 * by订单号查询订单编号
	 */
	@Override
	public int findOrderIdByOrderNum(String orderNum) {
		int orderId=0;
		String sql="select orderId from s_order where orderNum=?";
		List<Map<String, Object>> query = DbUtil.executeQuery(sql, orderNum);
		if(query.size()>0) {
			orderId=(int) query.get(0).get("orderId");
		}
		
		return orderId;
	}
	@Override
	public long orderReadCount(int userId) {
		String sql = "select count(*) as count from s_order where userId=?";
		List<Map<String, Object>> lm = DbUtil.executeQuery(sql,userId);
		return lm.size() > 0 ? (long) lm.get(0).get("count") : 0;
	}
	@Override
	public List<Order> orderList(PageBean pageBean,int userId) {
		List<Order> lo=new ArrayList<>();
		List<Map<String, Object>> list=new ArrayList<Map<String,Object>>();
		
		String sql="select * from s_order where userId=? limit ?,?";
		
		list=DbUtil.executeQuery(sql,userId,(pageBean.getCurPage()-1)*pageBean.getMaxSize(),pageBean.getMaxSize());
		
		if(list.size()>0) {
			for(Map<String,Object> map:list) {
				Order order=new Order(map);
				lo.add(order);
			}
		}
		return lo;
	}
	
	@Override
	public long orderReadCount() {
		String sql = "select count(*) as count from s_order";
		List<Map<String, Object>> lm = DbUtil.executeQuery(sql);
		return lm.size() > 0 ? (long) lm.get(0).get("count") : 0;
	}
	
	@Override
	public List<Order> orderList(PageBean pageBean) {
		List<Order> lo=new ArrayList<>();
		List<Map<String, Object>> list=new ArrayList<Map<String,Object>>();
		
		String sql="select * from s_order order by orderId limit ?,?";
		
		list=DbUtil.executeQuery(sql,(pageBean.getCurPage()-1)*pageBean.getMaxSize(),pageBean.getMaxSize());
		
		if(list.size()>0) {
			for(Map<String,Object> map:list) {
				Order order=new Order(map);
				lo.add(order);
			}
		}
		
		return lo;
	}
	
	@Override
	public Order findOrderByOrderId(int orderId) {
		Order order=null;
		String sql="select * from s_order where orderId=?";
		List<Map<String, Object>> query = DbUtil.executeQuery(sql, orderId);
		if(query.size()>0) {
			order=new Order(query.get(0));
		}
		return order;
	}
	
	@Override
	public long orderReadCountByStatus(int status) {
		String sql = "select count(*) as count from s_order where orderStatus=?";
		List<Map<String, Object>> lm = DbUtil.executeQuery(sql,status);
		return lm.size() > 0 ? (long) lm.get(0).get("count") : 0;
	}
	@Override
	public long orderReadCountByStatuss(int status,int statuss) {
		String sql = "select count(*) as count from s_order where orderStatus=? or orderStatus=?";
		List<Map<String, Object>> lm = DbUtil.executeQuery(sql,status,statuss);
		return lm.size() > 0 ? (long) lm.get(0).get("count") : 0;
	}
	@Override
	public List<Order> orderListByStatus(PageBean pageBean, int status) {
		List<Order> lo=new ArrayList<>();
		List<Map<String, Object>> list=new ArrayList<Map<String,Object>>();
		
		String sql="select * from s_order where orderStatus=? limit ?,?";
		
		list=DbUtil.executeQuery(sql,status,(pageBean.getCurPage()-1)*pageBean.getMaxSize(),pageBean.getMaxSize());
		
		if(list.size()>0) {
			for(Map<String,Object> map:list) {
				Order order=new Order(map);
				lo.add(order);
			}
		}
		return lo;
	}
	@Override
	public List<Order> orderListByStatuss(PageBean pageBean, int status, int statuss) {
		List<Order> orderList = new ArrayList<>();
		List<Map<String, Object>> resultList = new ArrayList<>();

		String sql = "SELECT * FROM s_order WHERE orderStatus = ? OR orderStatus = ? LIMIT ?, ?";
		resultList = DbUtil.executeQuery(sql, status, statuss, (pageBean.getCurPage() - 1) * pageBean.getMaxSize(), pageBean.getMaxSize());

		if (resultList.size()>0) {
			for
			(Map<String, Object> map : resultList) {
				Order order = new Order(map);
				orderList.add(order);
			}
		}
		return orderList;
	}


	@Override
	public boolean orderStatus(int orderId,int status) {
		if (status == 5) {
			String sql0 = "update s_order set orderStatus = ? where orderId = ?";
			int j = DbUtil.excuteUpdate(sql0, status, orderId);
			if (j > 0) {
				String sql01 = "update s_product set state = 0 where bookId in (select bookId from s_orderitem where orderId = ?)";
				int k = DbUtil.excuteUpdate(sql01, orderId);
				return k > 0;
			}
		} else if(status ==3){
			String sql = "update s_order set orderStatus = ? where orderId = ?";
			int i = DbUtil.excuteUpdate(sql, status, orderId);
			if (i > 0){
				String sql010 = "update s_product set state = 2 where bookId in (select bookId from s_orderitem where orderId = ?)";
				int q = DbUtil.excuteUpdate(sql010, orderId);
				return q > 0;
			}
		}else{
			String sql2 = "update s_order set orderStatus = ? where orderId = ?";
			int m = DbUtil.excuteUpdate(sql2, status, orderId);
			return m > 0;
		}
		return false;
	}

	@Override
	public boolean updateOrderReason(int orderId, String reason) {
		String sql = "update s_order set reason = ? where orderId = ?";
		int m = DbUtil.excuteUpdate(sql, reason, orderId);
		return m > 0;
	}
	
}

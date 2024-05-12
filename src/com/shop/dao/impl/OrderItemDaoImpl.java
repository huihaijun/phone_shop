package com.shop.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.shop.bean.OrderItem;
import com.shop.dao.OrderItemDao;
import com.shop.util.DbUtil;

public class OrderItemDaoImpl implements OrderItemDao {

	@Override
	public boolean orderAdd(OrderItem orderItem) {
		String sql = "insert into s_orderitem(bookId, orderId, quantity) values(?,?,?)";
		int i = DbUtil.excuteUpdate(sql, orderItem.getBookId(), orderItem.getOrderId(), orderItem.getQuantity());

		if (i > 0) {
			String Sql1 = "update s_product set state = 1 where bookId = ?";
			int j = DbUtil.excuteUpdate(Sql1, orderItem.getBookId());
			return j > 0;
		}

		return false;
	}

	@Override
	public List<OrderItem> findItemByOrderId(int orderId) {
		List<OrderItem> lo=new ArrayList<>();
		String sql="select * from s_orderitem where orderId=?";
		List<Map<String, Object>> query = DbUtil.executeQuery(sql, orderId);
		if(query.size()>0) {
			for(Map<String,Object> map:query) {
				OrderItem oItem=new OrderItem(map);
				lo.add(oItem);
			}
			
		}
		return lo;
	}

}

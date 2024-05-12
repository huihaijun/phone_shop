package com.shop.bean;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class Order {

    private int orderId;            //订单编号
    private String orderNum;		//订单号
    private int userId;             //用户编号
    private String orderDate;       //订单日期
    private double money;			//订单金额
    private int orderStatus;     	//订单状态
    private String name;
	private String tell;
	private String reason;
	private List<OrderItem> oItem=new ArrayList<>();
    private User user=new User();

    public Order() {
    }

    public Order(Map<String, Object> map) {
		this.setOrderId((int) map.get("orderId"));
		this.setOrderNum((String) map.get("orderNum"));
		this.setUserId((int) map.get("userId"));
		this.setOrderDate((String) map.get("orderDate"));
		this.setMoney((double) map.get("money"));
		this.setOrderStatus((int) map.get("orderStatus"));
		this.setName((String) map.get("name"));
		this.setTell((String) map.get("tell"));
		this.setReson((String) map.get("reason"));
	}

	public Order(int orderId,String reason) {
		super();
		this.orderId = orderId;
		this.reason = reason;
	}




	public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

	public String getName() { return name; }

	public void setName(String name) { this.name= name; }

	public String getTell() {
		return tell;
	}

	public void setTell(String tell) {
		this.tell= tell;
	}
    
    public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}

	public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

	public int getOrderStatus() {
		return orderStatus;
	}

	public void setOrderStatus(int orderStatus) {
		this.orderStatus = orderStatus;
	}



	public List<OrderItem> getoItem() {
		return oItem;
	}

	public void setoItem(List<OrderItem> oItem) {
		this.oItem = oItem;
	}

	public double getMoney() {
		return money;
	}

	public void setMoney(double money) {
		this.money = money;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public void setReson(String tell) {
		this.reason= reason;
	}

	public String getReason() {
		return reason;
	}


}

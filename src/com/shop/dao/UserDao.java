package com.shop.dao;

import java.util.List;

import com.shop.bean.Admin;
import com.shop.bean.PageBean;
import com.shop.bean.User;

public interface UserDao {
	
	//获取总记录数
	long bookReadCount();
	//获取用户列表（分页显示）
	List<User> userList(PageBean pageBean);
	//查找用户名是否存在
	boolean findUser(String userName);
	//根据id获取一个用户的信息
	User findUser(Integer id);
	//增加用户
	boolean userAdd(User user);
	//更新用户
	boolean userUpdate(User user);

	boolean userUUpdate(User user);
	//根据id删除一个用户
	boolean delUser(int id);
	//根据一组id字符串批量删除用户
	boolean batDelUser(String ids);
	//登陆
	User userLogin(User user);
	//
	boolean findUserByNumber(String tell);
}

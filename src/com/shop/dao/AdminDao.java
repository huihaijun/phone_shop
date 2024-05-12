package com.shop.dao;

import java.util.List;
import java.util.Map;

import com.shop.bean.Admin;
import com.shop.bean.PageBean;


//管理员dao层！

public interface AdminDao {
	
	//用户登录 返回布尔型数值servlet用于跳转
	boolean userLogin(Admin admin);

	//获取用户列表（分页显示），主要用servlet中新建的ad对象，pagebean参数
	//调用此方法，返回每页的分页结果集到servlet，进行下一步的setattribute遍历呈现
	List<Admin>userList(PageBean pageBean);

	//获取总记录数——调用dao层select * ，获取数据库中数据条数
	long bookReadCount();

	//👇下列三个都返回布尔值 即带adminmessage
	//增加用户
	boolean userAdd(Admin admin);
	//根据id删除一个用户
	boolean delUser(int id);
	//根据ids批量删除用户
	boolean batDelUser(String ids);

	//在数据库中查找 用户名是否已经存在
	boolean findUser(String username);

	//更改前 根据id获取一个用户的信息
	Admin findUser(Integer id);
	//再根据id更新用户 也返回布尔值 带adminmessage
	boolean userUpdate(Admin admin);



}

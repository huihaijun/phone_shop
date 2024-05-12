package com.shop.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.shop.bean.Admin;
import com.shop.bean.PageBean;
import com.shop.dao.AdminDao;
import com.shop.util.DateUtil;
import com.shop.util.DbUtil;

public class AdminDaoImpl implements AdminDao {
	//管理员登录！（写数据库+向servlet返回一个布尔值，用于跳转）
	@Override
	public boolean userLogin(Admin admin) {
		//默认布尔值false
		boolean flag=false;
		String sql="select * from s_admin where userName=? and passWord=?";
		String sql2="update s_admin set lastLoginTime=? where id=?";
		//遍历出所有账户密码匹配的对象至list里面
		List<Map<String,Object>> list=DbUtil.executeQuery(sql,admin.getUserName(),admin.getPassWord());
		if(list.size()>0){
			//同意登录！
			flag=true;
			//把name值传入对象中
			admin.setName((String)list.get(0).get("name"));
			//通过登录成功用户的 id 更新最后登录时间
			DbUtil.excuteUpdate(sql2, DateUtil.getTimestamp(),list.get(0).get("id"));
		}
		return flag;
	}


	@Override
	//返回一个list集合，这里是通过limit分页查询的结果lu
	//这里的pagebean是在servlet里面定义的传来的参数
	public List<Admin> userList(PageBean pageBean) {
		//真正存储分页结果的数组lu
		List<Admin> lu=new ArrayList<>();
		//sql中的 limit 用法：从第几条开始的下一条，往后几条。输出一个集合。
		String sql="select * from s_admin limit ?,?";
		//从第  -（当前页-1）*6条 -  的下一条数据开始，往后的6条数据
		List<Map<String, Object>> list=DbUtil.executeQuery
				(sql,(pageBean.getCurPage()-1)*pageBean.getMaxSize(),pageBean.getMaxSize());
		//若list不为空，则将list中的每一条数据通过新建admin对象u遍历
		//传到真正存储分页结果的数组（此处为lu）
		if(list.size()>0) {
			for(Map<String,Object> map:list) {
				Admin u=new Admin(map);
				lu.add(u);
			}}
		return lu;
	}

	@Override
	//通过select数据库中所有管理员，计算个数，反映到servlet中的Pagebean方法的readCount位置
	public long bookReadCount() {
		//默认count为0
		long count=0;
		//select数据库中所有管理员
		String sql="select count(*) as count from s_admin";
		List<Map<String, Object>> lm=DbUtil.executeQuery(sql);
		//lm若不为空，则得出数据条数，得出一共有多少条信息
		if(lm.size()>0){
			count=(long) lm.get(0).get("count");
		}
		return count;
	}


	@Override
	//增加的用户对象，返回一个boolean true用户增加成功 false用户增加失败
	public boolean userAdd(Admin user) {
		String sql="insert into s_admin(userName,password,name) values(?,?,?)";
		int i= DbUtil.excuteUpdate(sql, user.getUserName(),user.getPassWord(),user.getName());
		return i>0?true:false;	
		
	}

	@Override
	//根据id删除数据，并返回布尔值，true删除用户成功，false删除用户失败
	public boolean delUser(int id) {
		String sql="delete from s_admin where id=?";
		int i=DbUtil.excuteUpdate(sql, id);
		return i>0?true:false;
	}

	@Override
	//根据ids批量删除数据，并返回布尔值，true删除用户成功，false删除用户失败
	public boolean batDelUser(String ids) {
		String sql="delete from s_admin where id in ("+ids+")";
		int i=DbUtil.excuteUpdate(sql);
		return i>0?true:false;
	}


	@Override
	//在数据库查找用户名是否存在true存在 判断用户是否已经存在
	public boolean findUser(String userName) {
		String sql="select * from s_admin where userName=?";
		List<Map<String,Object>> list=DbUtil.executeQuery(sql, userName);
		return list.size()>0?true:false;
	}


	@Override
	//根据id查找一个用户信息 返回一个list用户信息集合！！！是admin集合
	public Admin findUser(Integer id) {
		String sql="select * from s_admin where id=?";
		Admin admin=null;
		List<Map<String,Object>> list=DbUtil.executeQuery(sql, id);
		if(list.size()>0) {
			admin=new Admin(list.get(0));
		}
		return admin;
	}


	@Override
	//根据id，更新用户
	public boolean userUpdate(Admin admin) {
		String sql="update s_admin set password=? , name=? where id =?";
		int i=DbUtil.excuteUpdate(sql, admin.getPassWord(),admin.getName(),admin.getId());
		return i>0?true:false;
	}
}

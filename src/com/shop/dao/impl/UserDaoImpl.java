package com.shop.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.shop.bean.Admin;
import com.shop.bean.PageBean;
import com.shop.bean.User;
import com.shop.dao.UserDao;
import com.shop.util.DbUtil;


public class UserDaoImpl implements UserDao {
	@Override
	//返回一个list集合，这里是通过limit分页查询的结果lu
	//这里的pagebean是在servlet里面定义的传来的参数
	public List<User> userList(PageBean pageBean) {
		//真正存储分页结果的数组lu
		List<User> lu=new ArrayList<>();
		List<Map<String, Object>> list=new ArrayList<Map<String,Object>>();
		
		String sql="select * from s_user limit ?,?";
		//从第  -（当前页-1）*6条 -  的下一条数据开始，往后的6条数据
		list=DbUtil.executeQuery(sql,
				(pageBean.getCurPage()-1)*pageBean.getMaxSize(),pageBean.getMaxSize());
		//若list不为空，则将list中的每一条数据通过新建user对象u遍历
		//传到真正存储分页结果的数组（此处为lu）
		if(list.size()>0) {
			for(Map<String,Object> map:list) {
				User u=new User(map);
				lu.add(u);
			}
		}
		return lu;
	}
	//通过select数据库中所有用户，计算个数，反映到servlet中的Pagebean方法的readCount位置
	@Override
	public long bookReadCount() {
		long count=0;
		//select所有用户
		String sql="select count(*) as count from s_user";
		List<Map<String, Object>> lm=DbUtil.executeQuery(sql);
		//lm若不为空，则得出数据条数，得出一共有多少条信息
		if(lm.size()>0){
			count=(long) lm.get(0).get("count");
		}
		return count;
	}
	@Override
	//增加的用户对象，返回一个布尔值 true用户增加成功 false用户增加失败
	public boolean userAdd(User user) {
		String sql="insert into s_user(userName,userPassWord,name,sex,age,tell,address,enabled) values(?,?,?,?,?,?,?,?)";
		
		int i= DbUtil.excuteUpdate
				(sql, user.getUserName(),user.getUserPassWord(),user.getName(),user.getSex(),user.getAge()
				,user.getTell(),user.getAddress(),user.getEnabled());
		return i>0?true:false;	
		
	}

	@Override
	//在数据库查找用户名是否存在true存在 判断用户是否已经存在
	public boolean findUser(String userName) {
		String sql="select * from s_user where userName=?";
		List<Map<String,Object>> list=DbUtil.executeQuery(sql, userName);
		return list.size()>0?true:false;
	}
	@Override
	//根据id查找一个用户信息 返回一个list用户信息集合！！！是admin集合
	public User findUser(Integer id) {
		String sql="select * from s_user where userId=?";
		User u=null;
		List<Map<String,Object>> list=DbUtil.executeQuery(sql, id);
		if(list.size()>0) {
			u=new User(list.get(0));
		}
		return u;
	}

	//根据id更新用户
	@Override
	public boolean userUpdate(User user) {
		String sql="update s_user set userPassWord=?,name=?,sex=?,age=?,tell=?,address=?,credit=?,enabled=? where userId =?";
		int i=DbUtil.excuteUpdate(sql,user.getUserPassWord(),user.getName(),user.getSex(),user.getAge()
				,user.getTell(),user.getAddress(),user.getCredit(),user.getEnabled(),user.getUserId());
		
		return i>0?true:false;
	}

	@Override
	public boolean userUUpdate(User user) {
		String sql="update s_user set userPassWord=?,name=?,sex=?,age=?,tell=?,address=? where userId =?";
		int i=DbUtil.excuteUpdate(sql,user.getUserPassWord(),user.getName(),user.getSex(),user.getAge()
				,user.getTell(),user.getAddress(),user.getUserId());

		return i>0?true:false;
	}
	//根据id删除用户
	@Override
	public boolean delUser(int id) {
		String sql="delete from s_user where userId=?";
		int i=DbUtil.excuteUpdate(sql, id);
		return i>0?true:false;
	}
	//批量删除ids用户
	@Override
	public boolean batDelUser(String ids) {
		String sql="delete from s_user where userId in ("+ids+")";
		int i=DbUtil.excuteUpdate(sql);
		return i>0?true:false;
	}



	@Override
	public User userLogin(User user) {
		User user1=null;
		String sql="select * from s_user where userName=? and userPassWord=?";
		List<Map<String, Object>> list = DbUtil.executeQuery(sql, user.getUserName(),user.getUserPassWord());
		if(list.size()>0) {
			Map<String, Object> map = list.get(0);
			user1=new User(map);
			
		}
		return user1;
	}

	@Override
	//在数据库查找用户名是否存在true存在 判断用户是否已经存在
	public boolean findUserByNumber(String tell) {
		String sql="select * from s_user where tell=?";
		List<Map<String,Object>> list=DbUtil.executeQuery(sql, tell);
		return list.size()>0?true:false;
	}

}

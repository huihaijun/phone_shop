package com.shop.dao.impl;

import com.shop.bean.UpLoadImg;
import com.shop.bean.UpLoadVid;
import com.shop.dao.UpLoadVidDao;
import com.shop.util.DbUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class UpLoadVidDaoImpl implements UpLoadVidDao {

	//增加商品图片写入数据库，返回布尔值
	@Override
	public boolean vidAdd(UpLoadVid upLoadVid) {
		String sql="insert into s_uploadvid(vidName,vidSrc,vidType) values(?,?,?)";
		int i=DbUtil.excuteUpdate(sql, upLoadVid.getVidName(),upLoadVid.getVidSrc(),upLoadVid.getVidType());
		return i>0?true:false;
	}


	//通过查询获取图片的id
	@Override
	public Integer findIdByVidName(String vidName) {
		Integer id=0;
		String sql = "select vidId from s_uploadvid where vidName=?";
		List<Map<String, Object>> list = DbUtil.executeQuery(sql, vidName);
		if(list.size()>0){
			id=(Integer) list.get(0).get("vidId");
		}
		return id;
		
	}
	//更新图片信息 并返回布尔值
	@Override
	public boolean vidUpdate(UpLoadVid upVid) {
		String sql = "update s_uploadvid set vidName=? , vidSrc=? , vidType=? where vidId=?";
		int i = DbUtil.excuteUpdate(sql, upVid.getVidName(),upVid.getVidSrc(),upVid.getVidType(),upVid.getVidId());
		return i>0?true:false;
	}
	//通过id删除图片
	@Override
	public boolean vidDelById(int vidId) {
		String sql="delete from s_uploadvid where vidId=?";
		int i = DbUtil.excuteUpdate(sql, vidId);
		return i>0?true:false;
	}
	//根据ids查询图片
	@Override
	public List<UpLoadVid> findVidByIds(String vidIds) {
		List<UpLoadVid> luli=new ArrayList<>();
		String sql="select * from s_uploadimg where imgId in("+vidIds+")";
		List<Map<String, Object>> list = DbUtil.executeQuery(sql);
		if(list.size()>0) {
			for(Map<String,Object> map:list) {
				UpLoadVid uli=new UpLoadVid(map);
				luli.add(uli);
			}
		}
		return luli;
	}
	//批量删除
	@Override
	public boolean vidBatDelById(String vidIds) {
		String sql="delete from s_uploadimg where imgId in("+vidIds+")";
		int i=DbUtil.excuteUpdate(sql);
		return i>0?true:false;
	}

}

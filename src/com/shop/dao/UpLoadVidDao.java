package com.shop.dao;

import com.shop.bean.UpLoadImg;
import com.shop.bean.UpLoadVid;

import java.util.List;

/**
 * 商品图片上传dao层
 * @author thuih
 *
 */
public interface UpLoadVidDao {
	
	//图片增加
	boolean vidAdd(UpLoadVid upLoadVid);
	//根据商品图片名称获取id（名称用的uuid唯一识别码）
	Integer findIdByVidName(String vidName);
	//更新图片信息
	boolean vidUpdate(UpLoadVid upVid);
	//通过id删除图片
	boolean vidDelById(int vidId);
	//通过imgIds查询图片信息
	List<UpLoadVid> findVidByIds(String vidIds);
	//批量删除
	boolean vidBatDelById(String vidIds);
}

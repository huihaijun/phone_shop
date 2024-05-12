package com.shop.util;

import java.io.File;
import java.net.MalformedURLException;
import java.util.List;
import java.util.Map;

public class Test {

	public static void main(String[] args) throws MalformedURLException {
		String imgIds="";
		String ids="1,6";
		String sql="select imgId from s_product where bookId in("+ids+")";
		
		List<Map<String, Object>> list = DbUtil.executeQuery(sql);
		if(list.size()>0) {
			for(int i=0;i<list.size();i++) {
				if(i!=list.size()-1) {
					imgIds+=list.get(i).get("imgId")+",";
				}else {
					imgIds+=list.get(i).get("imgId");
				}
				
			}
		}
		System.out.println(imgIds);
	}

}

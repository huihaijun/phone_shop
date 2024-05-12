package com.shop.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.ResourceBundle;


public class PropertiesUtil {

	private static ResourceBundle bundle;


	public static String getValue(String key) {
		try {
			bundle = ResourceBundle.getBundle(DbUtil.BASE_NAME);//这里通过类常量(db文件名)获取资源
		} catch (Exception e) {
			e.getStackTrace();
		}

		return bundle.getString(key);
	}

}
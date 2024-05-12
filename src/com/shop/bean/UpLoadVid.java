package com.shop.bean;

import java.util.Map;

public class UpLoadVid {
	private int vidId;
	private String vidName; // 文件名称
	private String vidSrc; // 文件路径
	private String vidType; // 文件类型
	public UpLoadVid() {
	}

	public UpLoadVid(int imgId, String imgName, String imgSrc, String imgType) {
		super();
		this.vidId = vidId;
		this.vidName = vidName;
		this.vidSrc = vidSrc;
		this.vidType = vidType;
	}

	public UpLoadVid(Map<String, Object> map) {

		this.vidId = (int) map.get("vidId");
		this.vidName = (String) map.get("vidName");
		this.vidSrc = (String) map.get("vidSrc");
		this.vidType = (String) map.get("vidType");
	}

	public int getVidId() { return vidId; }

	public void setVidId(int vidId) { this.vidId = vidId; }

	public String getVidName() { return vidName; }

	public void setVidName(String vidName) { this.vidName = vidName; }

	public String getVidSrc() {
		return vidSrc;
	}

	public void setVidSrc(String vidSrc) { this.vidSrc = vidSrc; }

	public String getVidType() {
		return vidType;
	}

	public void setVidType(String vidType) {
		this.vidType = vidType;
	}

	@Override
	public String toString() {
		return "UpLoadVid [vidId=" + vidId + ", vidName=" + vidName + ", vidSrc=" + vidSrc + ", vidType=" + vidType
				+ "]";
	}

}

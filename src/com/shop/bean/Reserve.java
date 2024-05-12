package com.shop.bean;

import java.util.Map;

public class Reserve {

	private int tsid;         //号
	private String date;    //
	private String period;    //用户密码
	private Integer Num;

	private Integer nownum;
	private Integer remnum;

	public Reserve() {}



	public Reserve(String date,String period,Integer Num) {
		super();
		this.date = date;
		this.period = period;
		this.Num = Num;
	}
	public Reserve(int tsid,String date,String period,Integer Num) {
		super();
		this.tsid = tsid;
		this.date = date;
		this.period = period;
		this.Num = Num;
	}

	public Reserve(int tsid,String date,String period,Integer Num,Integer nownum) {
		super();
		this.tsid = tsid;
		this.date = date;
		this.period = period;
		this.Num = Num;
		this.nownum=nownum;
	}
	
	public Reserve(Map<String,Object> map) {
		tsid=(int) map.get("tsid");
		date=(String) map.get("date");
		period=(String) map.get("period");
		Num= (int) map.get("Num");
		nownum= (int) map.get("nownum");
//		remnum= (int) map.get("remnum");
		this.remnum = this.Num - this.nownum;
	}

	public int getTsid() {
		return tsid;
	}

	public void setTsid(int tsid) {
		this.tsid = tsid;
	}


	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getPeriod() {
		return period;
	}

	public void setPeriod(String period) {
		this.period = period;
	}


	public int getNum() {
		return Num;
	}

	public void setNum(int Num) {
		this.Num = Num;
	}

	public int getnownum() {return nownum;}
	public void setnownum(int nownum) {
		this.nownum = nownum;
	}

	public int getremnum() {return remnum;}
	public void setremnum(int remnum) {
		this.remnum = remnum;
	}


	@Override
	public String toString() {
		return "Reserve [tsid=" + tsid + ", date=" + date + ", period=" + period + ", Num=" + Num
				+ "]";
	}




}

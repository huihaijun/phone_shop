package com.shop.bean;
import java.util.Map;

public class Ureserve {
    private int reid;         //号
    private int userId;         //号
    private String userName;         //号
    private String name;         //号
    private String tell;
    private String date;         //号
    private String period;
    private int state;         //号

    public Ureserve() {}

    public Ureserve(int reid,int userId,String date,String period) {
        super();
        this.reid=reid;
        this.userId=userId;
        this.date = date;
        this.period = period;
    }
    public Ureserve(int reid,int userId,String userName,String name,String date,String period,int state) {
        super();
        this.reid=reid;
        this.userId=userId;
        this.userName=userName;
        this.name = name;
        this.date = date;
        this.period = period;
        this.state = state;
    }
    public Ureserve(int userId,String userName,String name,String tell,String date,String period,int state) {
        super();
        this.userId=userId;
        this.userName=userName;
        this.name = name;
        this.tell = tell;
        this.date = date;
        this.period = period;
        this.state = state;
    }

    public Ureserve(int userId,String userName,String date,String period,int state) {
        super();
        this.userId=userId;
        this.userName=userName;
        this.date = date;
        this.period = period;
        this.state = state;
    }

    public Ureserve(int userId,String userName,String name,String date,String period) {
        super();
        this.userId=userId;
        this.userName=userName;
        this.name=name;
        this.date = date;
        this.period = period;
    }
    public Ureserve(int userId,String userName,String name,String tell,String date,String period) {
        super();
        this.userId=userId;
        this.userName=userName;
        this.name=name;
        this.tell = tell;
        this.date = date;
        this.period = period;
    }

    public Ureserve(int userId,String userName,String date,String period) {
        super();
        this.userId=userId;
        this.userName=userName;
        this.date = date;
        this.period = period;
    }

    public Ureserve(Map<String,Object> map) {
        reid=(int) map.get("reid");
        userId = (int) map.get("userId");
        userName=(String) map.get("userName");
        name=(String) map.get("name");
        tell=(String) map.get("tell");
        date=(String) map.get("date");
        period=(String) map.get("period");
        state=(int) map.get("state");
    }

    public int getReid() {
        return reid;
    }

    public void setReid(int reid) {
        this.reid = reid;
    }

    public int getUserid() {
        return userId;
    }

    public void setUserid(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTell() {
        return tell;
    }

    public void setTell(String tell) {
        this.tell = tell;
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

    public int getState() {
        return state;
    }
    public void setState(int state) {
        this.state = state;
    }


    @Override
    public String toString() {
        return "Ureserve [reid=" + reid + ", userId="+userId+",userName="+userName+",name="+name+",date=" + date + ", period=" + period + ", state=" + state + "]";
    }

}

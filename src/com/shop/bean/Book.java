package com.shop.bean;

import java.util.Date;
import java.util.Map;

public class Book {
	//自动获取
	private int bookId; // 商品编号
	private Date addTime;//上架时间

	//从填写的里面获取
	private String bookName; // 商品名称
	private double price; // 价格
	private String description; // 描述信息
	private String author; // 品牌
	private String press; // 上市时间

	private int imgId; // 图片id
	private int vidId;//视频id
	private int catalogId; // 商品分类id
	private String name;
	private Catalog catalog = new Catalog(); // 商品分类类属性
	private UpLoadImg upLoadImg = new UpLoadImg(); // 图片类属性
	private UpLoadVid upLoadVid = new UpLoadVid(); // 视频类属性
	private int state;
	public Book() {}

	// 这里是从数据库获取时集合转对象
	public Book(Map<String, Object> map) {
		this.bookId = (int) map.get("bookId");
		this.bookName = (String) map.get("bookName");
		this.price = (double) map.get("price");
		this.description = (String) map.get("description");
		this.author = (String) map.get("author");
		this.press = (String) map.get("press");
		this.addTime = (Date) map.get("addTime");
		this.catalog = new Catalog(map);
		this.state = (int) map.get("state");
		this.upLoadVid = new UpLoadVid(map);
		this.upLoadImg = new UpLoadImg(map);
	}


	public int getBookId() {
		return bookId;
	}

	public void setBookId(int bookId) {
		this.bookId = bookId;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public String getBookName() {
		return bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPress() {
		return press;
	}

	public void setPress(String press) {
		this.press = press;
	}

	public int getCatalogId() {
		this.catalogId = this.catalog.getCatalogId();
		return catalogId;
	}

	public void setCatalogId(int catalogId) {
		this.catalog.setCatalogId(catalogId);
	}

	public int getImgId() {
		this.imgId = this.upLoadImg.getImgId();
		return imgId;
	}

	public int getVidId() {
		this.vidId = this.upLoadVid.getVidId();
		return vidId;
	}

	public void setImgId(int imgId) {
		this.upLoadImg.setImgId(imgId);
	}

	public void setVidId(int vidId) {
		this.upLoadVid.setVidId(vidId);
	}

	public Catalog getCatalog() {
		return catalog;
	}

	public void setCatalog(Catalog catalog) {
		this.catalog = catalog;
	}

	public UpLoadImg getUpLoadImg() {
		return upLoadImg;
	}

	public void setUpLoadImg(UpLoadImg upLoadImg) {
		this.upLoadImg = upLoadImg;
	}

	public UpLoadVid getUpLoadVid() {
		return upLoadVid;
	}

	public void setUpLoadVid(UpLoadVid upLoadVid) {
		this.upLoadVid = upLoadVid;
	}

	public Date getAddTime() {
		return addTime;
	}

	public void setAddTime(Date addTime) {
		this.addTime = addTime;
	}

	@Override
	public String toString() {
		return "Book [bookId=" + bookId + ", bookName=" + bookName + ", price=" + price + ", description=" + description
				+ ", author=" + author + ", press=" + press + ", catalogId=" + catalogId + ", imgId=" + imgId
				+ ", catalog=" + catalog + ", upLoadImg=" + upLoadImg + ", upLoadVid=" + upLoadVid + "]";
	}
}

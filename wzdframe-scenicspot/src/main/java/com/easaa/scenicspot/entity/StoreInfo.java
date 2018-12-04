package com.easaa.scenicspot.entity;

import java.io.Serializable;
import java.util.List;

import com.easaa.entity.PageData;

public class StoreInfo  implements Serializable{

	private String storeId;
	
	private String storeName;
	
	
	private String storeImg;
	
	//店铺横幅
	private String storeBanner;
	
	
	//店铺标签
	private String storeTabs;
	
	//店铺简介
	private String introduction;
	
	
	//主营
	private String mainsale;

	//商品数量
	private String goodsNum;
	
	//店铺地址
	private String address;
	
	
	
	
	private List<ProductSimple> goodsList;



	public String getStoreId() {
		return storeId;
	}



	public void setStoreId(String storeId) {
		this.storeId = storeId;
	}



	public String getStoreName() {
		return storeName;
	}



	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}



	public String getStoreImg() {
		return storeImg;
	}



	public String getAddress() {
		return address;
	}



	public void setAddress(String address) {
		this.address = address;
	}



	public void setStoreImg(String storeImg) {
		this.storeImg = storeImg;
	}



	public String getStoreBanner() {
		return storeBanner;
	}



	public void setStoreBanner(String storeBanner) {
		this.storeBanner = storeBanner;
	}



	public String getStoreTabs() {
		return storeTabs;
	}



	public void setStoreTabs(String storeTabs) {
		this.storeTabs = storeTabs;
	}



	public String getIntroduction() {
		return introduction;
	}



	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}



	public String getMainsale() {
		return mainsale;
	}



	public void setMainsale(String mainsale) {
		this.mainsale = mainsale;
	}



	public String getGoodsNum() {
		return goodsNum;
	}



	public void setGoodsNum(String goodsNum) {
		this.goodsNum = goodsNum;
	}



	public List<ProductSimple> getGoodsList() {
		return goodsList;
	}



	public void setGoodsList(List<ProductSimple> goodsList) {
		this.goodsList = goodsList;
	}
	
	

	
}

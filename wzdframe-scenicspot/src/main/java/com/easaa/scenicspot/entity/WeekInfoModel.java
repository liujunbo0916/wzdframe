package com.easaa.scenicspot.entity;

import java.util.List;

import com.easaa.entity.PageData;

public class WeekInfoModel {

	
	//当前月份
	private int currentMonth; 
	
	//展示当前月份
	private String showCurrentMonth;
	
	//当前年份
	private String currentYear;
	//展示当前年份
	private String showCurrentYear;
	
	//跳转的月份  用户点击翻页 到某一月份
	private int gotoMonth;
	
	private String gotoShowMonth;
	
	private String  gotoYear;
	
	private String gotoShowYear;
	
	//价格
	private String price;
	
	//一月中的天数
	private List<String> dayOfMonth;
	
	//特殊价格列表   如  2017-10-01  =》  178，2017-10-02  =》  179
	private PageData specialPrice;

	public int getCurrentMonth() {
		return currentMonth;
	}

	public void setCurrentMonth(int currentMonth) {
		this.currentMonth = currentMonth;
	}

	public String getShowCurrentMonth() {
		return showCurrentMonth;
	}

	public void setShowCurrentMonth(String showCurrentMonth) {
		this.showCurrentMonth = showCurrentMonth;
	}

	public String getCurrentYear() {
		return currentYear;
	}

	public void setCurrentYear(String currentYear) {
		this.currentYear = currentYear;
	}

	public String getShowCurrentYear() {
		return showCurrentYear;
	}

	public void setShowCurrentYear(String showCurrentYear) {
		this.showCurrentYear = showCurrentYear;
	}

	public int getGotoMonth() {
		return gotoMonth;
	}

	public void setGotoMonth(int gotoMonth) {
		this.gotoMonth = gotoMonth;
	}

	public String getGotoShowMonth() {
		return gotoShowMonth;
	}

	public void setGotoShowMonth(String gotoShowMonth) {
		this.gotoShowMonth = gotoShowMonth;
	}

	public String getGotoYear() {
		return gotoYear;
	}

	public void setGotoYear(String gotoYear) {
		this.gotoYear = gotoYear;
	}

	public String getGotoShowYear() {
		return gotoShowYear;
	}

	public void setGotoShowYear(String gotoShowYear) {
		this.gotoShowYear = gotoShowYear;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public List<String> getDayOfMonth() {
		return dayOfMonth;
	}

	public void setDayOfMonth(List<String> dayOfMonth) {
		this.dayOfMonth = dayOfMonth;
	}

	public PageData getSpecialPrice() {
		return specialPrice;
	}

	public void setSpecialPrice(PageData specialPrice) {
		this.specialPrice = specialPrice;
	}
}

package com.easaa.scenicspot.entity.ticket;

import net.sf.json.JSONArray;

public class TicketPriceData {
	
	//按钮失效控制
	
	//控制向左的按钮
	private String disabledMinMonth;
	
	private String disabledMinYear;
	
	//控制向右
	private String disabledMaxMonth;
	
	private String disabledMaxYear;
	
	//选择的年月
	private String yearParam;
	
	private String monthParam;
	
	
	private JSONArray jsonData;


	public String getDisabledMinMonth() {
		return disabledMinMonth;
	}


	public void setDisabledMinMonth(String disabledMinMonth) {
		this.disabledMinMonth = disabledMinMonth;
	}


	public String getDisabledMaxMonth() {
		return disabledMaxMonth;
	}


	public void setDisabledMaxMonth(String disabledMaxMonth) {
		this.disabledMaxMonth = disabledMaxMonth;
	}


	public String getYearParam() {
		return yearParam;
	}


	public void setYearParam(String yearParam) {
		this.yearParam = yearParam;
	}


	public String getMonthParam() {
		return monthParam;
	}


	public void setMonthParam(String monthParam) {
		this.monthParam = monthParam;
	}


	public JSONArray getJsonData() {
		return jsonData;
	}


	public String getDisabledMinYear() {
		return disabledMinYear;
	}


	public void setDisabledMinYear(String disabledMinYear) {
		this.disabledMinYear = disabledMinYear;
	}


	public String getDisabledMaxYear() {
		return disabledMaxYear;
	}


	public void setDisabledMaxYear(String disabledMaxYear) {
		this.disabledMaxYear = disabledMaxYear;
	}


	public void setJsonData(JSONArray jsonData) {
		this.jsonData = jsonData;
	}
}

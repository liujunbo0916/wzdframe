package com.easaa.scenicspot.entity.ticket;

import java.io.Serializable;

/**
 * 
 * 票类详情
 * 
 * @author liujunbo
 *
 */
public class TicketData implements Serializable{

	private String ticketId;
	
	private String ticketName;
	
	//票务公司唯一识别号码
	private String thirdNo;
	
	//平台价格
	private String ticketPrice;
	
	//打包类型  1 单票  2 套票
	private String ticketPackageType;
	
	//购买须知
	private String ticketTip;
	
	//标签                         
	private String ticketLable;
	
	
	/**
	 * ##############第三方票务详细信息###################
	 */
	//支付方式 1在线支付  2 购票点支付
	private int paymentMethod;
	//开始售卖时间
	private String beginSaleTime;
	//结束售卖时间
	private String endSaleTime;
	//有效期时间
	private String beginValidTime;
	
	//有效期结束时间
	private String endValidTime;
	
	//市场价格
	private double marketPrice;
	
	//零售价
	private double retailPrice;
	
	//结算价格
	private double settlementPrice;
	
	//库存
	private int stock;
	
	//最小购买量
	private int minBuyCount;
	
	//	最多购买数量，不能少于最小购买数量, 0为不限制
	private int maxBuyCount;
	
	//下单提前天数
	private int advanceBookDays;
	
	//可预订最晚下单时间
	private String lastBookTime;
	
	//是否需要实名
	private boolean isRealName;
	
	
	//每身份证IdCardLimitDays天内最多可购买idCardLimitCount, 值为 0 表示不限制购买数量
	private int idCardLimitDays;
	private int idCardLimitCount;
	
	public String getTicketName() {
		return ticketName;
	}

	public String getTicketLable() {
		return ticketLable;
	}

	public void setTicketLable(String ticketLable) {
		this.ticketLable = ticketLable;
	}

	public String getTicketId() {
		return ticketId;
	}

	public void setTicketId(String ticketId) {
		this.ticketId = ticketId;
	}

	public void setTicketName(String ticketName) {
		this.ticketName = ticketName;
	}

	public String getThirdNo() {
		return thirdNo;
	}

	public void setThirdNo(String thirdNo) {
		this.thirdNo = thirdNo;
	}

	public String getTicketPrice() {
		return ticketPrice;
	}

	public void setTicketPrice(String ticketPrice) {
		this.ticketPrice = ticketPrice;
	}

	public String getTicketPackageType() {
		return ticketPackageType;
	}

	public void setTicketPackageType(String ticketPackageType) {
		this.ticketPackageType = ticketPackageType;
	}

	public String getTicketTip() {
		return ticketTip;
	}

	public void setTicketTip(String ticketTip) {
		this.ticketTip = ticketTip;
	}

	public int getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(int paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getBeginSaleTime() {
		return beginSaleTime;
	}

	public void setBeginSaleTime(String beginSaleTime) {
		this.beginSaleTime = beginSaleTime;
	}

	public String getEndSaleTime() {
		return endSaleTime;
	}

	public void setEndSaleTime(String endSaleTime) {
		this.endSaleTime = endSaleTime;
	}

	public String getBeginValidTime() {
		return beginValidTime;
	}

	public void setBeginValidTime(String beginValidTime) {
		this.beginValidTime = beginValidTime;
	}

	public String getEndValidTime() {
		return endValidTime;
	}

	public void setEndValidTime(String endValidTime) {
		this.endValidTime = endValidTime;
	}

	public double getMarketPrice() {
		return marketPrice;
	}

	public void setMarketPrice(double marketPrice) {
		this.marketPrice = marketPrice;
	}

	public double getRetailPrice() {
		return retailPrice;
	}

	public void setRetailPrice(double retailPrice) {
		this.retailPrice = retailPrice;
	}

	public double getSettlementPrice() {
		return settlementPrice;
	}

	public void setSettlementPrice(double settlementPrice) {
		this.settlementPrice = settlementPrice;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public int getMinBuyCount() {
		return minBuyCount;
	}

	public void setMinBuyCount(int minBuyCount) {
		this.minBuyCount = minBuyCount;
	}

	public int getMaxBuyCount() {
		return maxBuyCount;
	}

	public void setMaxBuyCount(int maxBuyCount) {
		this.maxBuyCount = maxBuyCount;
	}

	public int getAdvanceBookDays() {
		return advanceBookDays;
	}

	public void setAdvanceBookDays(int advanceBookDays) {
		this.advanceBookDays = advanceBookDays;
	}

	public String getLastBookTime() {
		return lastBookTime;
	}

	public void setLastBookTime(String lastBookTime) {
		this.lastBookTime = lastBookTime;
	}

	public Boolean isRealName() {
		return isRealName;
	}

	public void setRealName(Boolean isRealName) {
		this.isRealName = isRealName;
	}

	public int getIdCardLimitDays() {
		return idCardLimitDays;
	}

	public void setIdCardLimitDays(int idCardLimitDays) {
		this.idCardLimitDays = idCardLimitDays;
	}

	public int getIdCardLimitCount() {
		return idCardLimitCount;
	}

	public void setIdCardLimitCount(int idCardLimitCount) {
		this.idCardLimitCount = idCardLimitCount;
	}

	
	
}

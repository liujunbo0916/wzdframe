package com.easaa.scenicspot.entity.ticket;

import java.io.Serializable;
import java.util.List;

public class TicketOrder implements Serializable {

	private static final long serialVersionUID = 1L;

	private Long id;
	
	private String thirdNo;
	
	//订单号
	private String orderNo;

	// 订单价格
	private String orderMoney;

	// 零售价格
	private String retailPrice;

	// 结算价格
	private String settlementPrice;

	// 购买数量
	private String quantity;

	// 出行时期
	private String travelDate;

	// 订单状态
	private String status;

	// 退款状态
	private String refundStatus;

	// 支付状态
	private String payStatus;

	// 联系人姓名
	private String contactName;

	// 联系人电话
	private String contactMobile;

	// 支付方式
	private String payMethod;

	// 景点名字
	private String scenicName;

	// 景点id
	private String scenicId;

	// 景点图片
	private String scenicLogo;

	// 是否实名认证预定
	private String isRealName;

	// 票类信息
	private String ticketName;

	// 打包类型
	private String packageType;

	// 下单时间
	private String createTime;

	// 票类id
	private String ticketId;

	// 门票类型
	private String cateName;

	// 出行人信息
	private List<Traveler> traveler;
	
	// 二维码信息
	private String toQrcode;
	
	private String open_id;
	
	public String getOpen_id() {
		return open_id;
	}

	public void setOpen_id(String open_id) {
		this.open_id = open_id;
	}

	public String getToQrcode() {
		return toQrcode;
	}

	public void setToQrcode(String toQrcode) {
		this.toQrcode = toQrcode;
	}

	public String getOrderMoney() {
		return orderMoney;
	}

	public void setOrderMoney(String orderMoney) {
		this.orderMoney = orderMoney;
	}

	private String user_id;

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public Long getId() {
		return id;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getThirdNo() {
		return thirdNo;
	}

	public void setThirdNo(String thirdNo) {
		this.thirdNo = thirdNo;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getRetailPrice() {
		return retailPrice;
	}

	public String getRefundStatus() {
		return refundStatus;
	}

	public void setRefundStatus(String refundStatus) {
		this.refundStatus = refundStatus;
	}

	public void setRetailPrice(String retailPrice) {
		this.retailPrice = retailPrice;
	}

	public String getSettlementPrice() {
		return settlementPrice;
	}

	public void setSettlementPrice(String settlementPrice) {
		this.settlementPrice = settlementPrice;
	}

	public String getQuantity() {
		return quantity;
	}

	public void setQuantity(String quantity) {
		this.quantity = quantity;
	}

	public String getTravelDate() {
		return travelDate;
	}

	public void setTravelDate(String travelDate) {
		this.travelDate = travelDate;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}

	public String getContactName() {
		return contactName;
	}

	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	public String getContactMobile() {
		return contactMobile;
	}

	public void setContactMobile(String contactMobile) {
		this.contactMobile = contactMobile;
	}

	public String getPayMethod() {
		return payMethod;
	}

	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}

	public String getScenicName() {
		return scenicName;
	}

	public void setScenicName(String scenicName) {
		this.scenicName = scenicName;
	}

	public String getScenicId() {
		return scenicId;
	}

	public void setScenicId(String scenicId) {
		this.scenicId = scenicId;
	}

	public String getTicketName() {
		return ticketName;
	}

	public void setTicketName(String ticketName) {
		this.ticketName = ticketName;
	}

	public String getTicketId() {
		return ticketId;
	}

	public void setTicketId(String ticketId) {
		this.ticketId = ticketId;
	}

	public List<Traveler> getTraveler() {
		return traveler;
	}

	public void setTraveler(List<Traveler> traveler) {
		this.traveler = traveler;
	}

	public String getIsRealName() {
		return isRealName;
	}

	public void setIsRealName(String isRealName) {
		this.isRealName = isRealName;
	}

	public String getPackageType() {
		return packageType;
	}

	public void setPackageType(String packageType) {
		this.packageType = packageType;
	}

	public String getScenicLogo() {
		return scenicLogo;
	}

	public void setScenicLogo(String scenicLogo) {
		this.scenicLogo = scenicLogo;
	}

	public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}
	
}

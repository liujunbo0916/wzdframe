package com.easaa.scenicspot.entity;

import java.util.List;

import com.easaa.scenicspot.entity.ticket.Traveler;

public class GroupTourOrder {
	
	
	private String userId;
	// 订单ID
	private String orderId;
	// 订单号
	private String orderSn;
	// 更团游ID
	private String grouptourId;
	// 更团游名称
	private String grouptourName;
	// 更团游图片
	private String grouptourImg;
	// 更团游服务电话
	private String grouptourPhone;
	// 总价
	private String totalPrice;
	// 支付价格
	private String payPrice;
	// 成人数量
	private String adultNum;
	// 成人价格
	private String adultPrice;
	// 儿童人数
	private String childrenNum;
	// 儿童价格
	private String childrenPrice;
	// 出发日期
	private String departureDate;
	// 联系人
	private String linkPerple;
	// 联系人电话
	private String linkPhone;
	// 订单状态
	private String orderState;
	// 支付状态
	private String payStatus;
	// 支付类型
	private String payType;
	// 订单时间
	private String createTime;
	//退款状态
	private String refundStatus;
	//退款备注
	private String refundMark;
	
	
	
	// 出行人信息
	private List<Traveler> traveler;
	
	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getOrderSn() {
		return orderSn;
	}

	public void setOrderSn(String orderSn) {
		this.orderSn = orderSn;
	}

	public String getGrouptourId() {
		return grouptourId;
	}

	public void setGrouptourId(String grouptourId) {
		this.grouptourId = grouptourId;
	}

	public String getGrouptourName() {
		return grouptourName;
	}

	public void setGrouptourName(String grouptourName) {
		this.grouptourName = grouptourName;
	}

	public String getGrouptourImg() {
		return grouptourImg;
	}

	public void setGrouptourImg(String grouptourImg) {
		this.grouptourImg = grouptourImg;
	}

	public String getGrouptourPhone() {
		return grouptourPhone;
	}

	public void setGrouptourPhone(String grouptourPhone) {
		this.grouptourPhone = grouptourPhone;
	}

	public String getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(String totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getPayPrice() {
		return payPrice;
	}

	public void setPayPrice(String payPrice) {
		this.payPrice = payPrice;
	}

	public String getAdultNum() {
		return adultNum;
	}

	public void setAdultNum(String adultNum) {
		this.adultNum = adultNum;
	}

	public String getAdultPrice() {
		return adultPrice;
	}

	public void setAdultPrice(String adultPrice) {
		this.adultPrice = adultPrice;
	}

	public String getChildrenNum() {
		return childrenNum;
	}

	public void setChildrenNum(String childrenNum) {
		this.childrenNum = childrenNum;
	}

	public String getChildrenPrice() {
		return childrenPrice;
	}

	public void setChildrenPrice(String childrenPrice) {
		this.childrenPrice = childrenPrice;
	}

	public String getDepartureDate() {
		return departureDate;
	}

	public void setDepartureDate(String departureDate) {
		this.departureDate = departureDate;
	}

	public String getLinkPerple() {
		return linkPerple;
	}

	public void setLinkPerple(String linkPerple) {
		this.linkPerple = linkPerple;
	}

	public String getLinkPhone() {
		return linkPhone;
	}

	public void setLinkPhone(String linkPhone) {
		this.linkPhone = linkPhone;
	}

	public String getOrderState() {
		return orderState;
	}

	public void setOrderState(String orderState) {
		this.orderState = orderState;
	}

	public String getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public List<Traveler> getTraveler() {
		return traveler;
	}

	public void setTraveler(List<Traveler> traveler) {
		this.traveler = traveler;
	}

	public String getRefundStatus() {
		return refundStatus;
	}

	public void setRefundStatus(String refundStatus) {
		this.refundStatus = refundStatus;
	}

	public String getRefundMark() {
		return refundMark;
	}

	public void setRefundMark(String refundMark) {
		this.refundMark = refundMark;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}
	
}

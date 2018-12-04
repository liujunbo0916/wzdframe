package com.easaa.scenicspot.entity.ticket;

import java.io.Serializable;
import java.util.List;

import com.easaa.entity.PageData;

/**
 * 
 * 票类详情
 * 
 * 成人票对应 一个列表的票类信息
 * @author liujunbo
 *
 */
public class TicketCateData  implements Serializable{

	
	
	private String cateId;
	//票类目名字
	private String cateName;
	
	//票类目logo
	private String cateFit;
	
	//票类列表
	private List<TicketData> tickets;



	public String getCateId() {
		return cateId;
	}

	public void setCateId(String cateId) {
		this.cateId = cateId;
	}

	public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}

	
	public String getCateFit() {
		return cateFit;
	}

	public void setCateFit(String cateFit) {
		this.cateFit = cateFit;
	}

	public List<TicketData> getTickets() {
		return tickets;
	}

	public void setTickets(List<TicketData> tickets) {
		this.tickets = tickets;
	}
	
	
	
}

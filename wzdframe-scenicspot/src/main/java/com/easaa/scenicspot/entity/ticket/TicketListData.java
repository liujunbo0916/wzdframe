package com.easaa.scenicspot.entity.ticket;

import java.io.Serializable;
import java.util.List;

import com.easaa.util.properties.PropertiesFactory;
import com.easaa.util.properties.PropertiesFile;
import com.easaa.util.properties.PropertiesHelper;

/**
 * 
 * 景点票类列表
 * 
 * @author liujunbo
 */
public class TicketListData  implements Serializable{

	private static final PropertiesHelper PROPERTIESHELPER = PropertiesFactory
			.getPropertiesHelper(PropertiesFile.SYS);
	
	//景点id
	private String scenicId;
	
	//景点名字
	private String scenicName;
	
	//景点logo
	private String scenicLogo;
	
	//景点标签
	private String scenicLable;
	
	//景点介绍
	private String scenicDesc;
	
	
	//景点价格
	private String scenicTicketPrice;
	
	//购买量
	private String scenicBuyCount;
	
	//预定须知
	private String scenicBookKnow;
	
	//交通指南
	private String scenicTraffic;
	
	
	//景点描述
	private String scenicContent;
	
	private List<TicketCateData> ticketCates;
	
	public String getScenicId() {
		return scenicId;
	}

	public void setScenicId(String scenicId) {
		this.scenicId = scenicId;
	}

	public String getScenicName() {
		return scenicName;
	}

	public void setScenicName(String scenicName) {
		this.scenicName = scenicName;
	}

	public String getScenicLogo() {
		return scenicLogo;
	}

	public void setScenicLogo(String scenicLogo) {
		if(!scenicLogo.startsWith("http")){
			scenicLogo = PROPERTIESHELPER.getValue("imageShowPath")+scenicLogo;
		}
		this.scenicLogo = scenicLogo;
	}

	public String getScenicLable() {
		return scenicLable;
	}

	public void setScenicLable(String scenicLable) {
		this.scenicLable = scenicLable;
	}

	public String getScenicDesc() {
		return scenicDesc;
	}

	public void setScenicDesc(String scenicDesc) {
		this.scenicDesc = scenicDesc;
	}

	public String getScenicContent() {
		return scenicContent;
	}

	public void setScenicContent(String scenicContent) {
		this.scenicContent = scenicContent;
	}

	public List<TicketCateData> getTicketCates() {
		return ticketCates;
	}

	public void setTicketCates(List<TicketCateData> ticketCates) {
		this.ticketCates = ticketCates;
	}

	public String getScenicTicketPrice() {
		return scenicTicketPrice;
	}

	public void setScenicTicketPrice(String scenicTicketPrice) {
		this.scenicTicketPrice = scenicTicketPrice;
	}

	public String getScenicBuyCount() {
		return scenicBuyCount;
	}

	public void setScenicBuyCount(String scenicBuyCount) {
		this.scenicBuyCount = scenicBuyCount;
	}

	public String getScenicBookKnow() {
		return scenicBookKnow;
	}

	public void setScenicBookKnow(String scenicBookKnow) {
		this.scenicBookKnow = scenicBookKnow;
	}

	public String getScenicTraffic() {
		return scenicTraffic;
	}

	public void setScenicTraffic(String scenicTraffic) {
		this.scenicTraffic = scenicTraffic;
	}
	
}

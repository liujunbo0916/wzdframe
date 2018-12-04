package com.easaa.wechat.model;

/**
 * 图片消息
 * @author WL
 *
 */
public class WXPReceivedImageMessage extends WXPReceivedMessage {
	private String pictureURL;

	public String getPictureURL() {
		return pictureURL;
	}

	public void setPictureURL(String pictureURL) {
		this.pictureURL = pictureURL;
	}
	
}

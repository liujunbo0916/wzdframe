package com.easaa.wechat.model;
/**
 * 回复文本消息
 * @author WL
 *
 */
public class WXPReplyTextMessage extends WXPReplyMessage {
	private String content;

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
}

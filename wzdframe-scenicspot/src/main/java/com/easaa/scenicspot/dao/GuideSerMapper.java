package com.easaa.scenicspot.dao;

import java.util.List;

import com.easaa.core.model.dao.EADao;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;

public interface GuideSerMapper  extends EADao{
	public List<PageData>  feedbackList(PageData pd);
	public void insertFeedBack(PageData pd);
	public List<PageData> feedBackListPage(Page page);
	public void deleteFeed(PageData pd);
	public void updateFeed(PageData pd);
	public PageData selectByOrderSn(String string);
}

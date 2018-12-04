package com.easaa.scenicspot.dao;

import java.util.List;

import com.easaa.core.model.dao.EADao;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;

public interface AgencyMapper  extends EADao{
	
	public List<PageData> selectGuiderByMap(Page page);
	
	public List<PageData> selectGuiderByPage(Page page);
	
	public List<PageData> selectByListPage(Page page);
	
	public List<PageData> selectGuiderByListPage(Page page);
	
	public PageData selectGuiderById(Integer id);
	
	public void insertGuider(PageData pd);
	
	public void updateGuider(PageData pd);
	
	public void deleteGuider(PageData pd);
}

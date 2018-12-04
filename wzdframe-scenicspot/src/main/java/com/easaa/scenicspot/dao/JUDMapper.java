package com.easaa.scenicspot.dao;

import java.util.List;

import com.easaa.core.model.dao.EADao;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;

/**
 * JUD项目的dao
 * @author liujunbo
 *
 */
public interface JUDMapper extends EADao{
    
	public List<PageData> selectNewsList(PageData pd);
	public PageData selectNewsDetail(PageData pd);
	public  void  insertContact(PageData pd);
	public List<PageData> countryList();
	public void insertUserInfo(PageData pd);
	public List<PageData> condomListPage(Page pd);
	public void updateCondom(PageData pd);
	public void addCondom(PageData pd);
	public void deleteCondom(PageData pd);
	public List<PageData> condomListByMap(PageData pd);
}

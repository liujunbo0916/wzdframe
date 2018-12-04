package com.easaa.scenicspot.dao;

import java.util.List;

import com.easaa.core.model.dao.EADao;
import com.easaa.entity.PageData;

public interface DiscountTimeLimitMapper  extends EADao{

	List<PageData> selectLimitProList(int stringToInt);
	
	public void deleteLimitGoods(PageData pd);
	
	public void updateLimitGoods(PageData pd);
	
	public void insertLimitGoods(PageData pd); 
	
	public PageData selectLimitGoodsByID(Integer id); 
	
	public List<PageData> selectLimitGoodsByMap(PageData id);

	public List<PageData> selectProductByMap(PageData pd); 
	
}

package com.easaa.scenicspot.dao;

import java.util.List;

import com.easaa.core.model.dao.EADao;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;

public interface HotelMapper  extends EADao{
	
	public List<PageData> selectHotelTypeByMap(Page page);
	
	public List<PageData> selectHotelTypeByPage(Page page);
	
	public List<PageData> selectByListPage(Page page);
	
	public PageData selectHotelTypeById(Integer id);
	
	public void insertHotelType(PageData pd);
	
	public void updateHotelType(PageData pd);
	
	public void deleteHotelType(PageData pd);
}

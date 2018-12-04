package com.easaa.scenicspot.dao;

import java.util.List;

import com.easaa.core.model.dao.EADao;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.entity.PageExtend;
import com.easaa.scenicspot.entity.StoreInfo;

public interface ShopMapper  extends EADao{
	
	public List<PageData> selectStayPage(Page pd);
	
	public PageData selectStaydata(PageData pd);
	
	public PageData selectBusinessJoinById(Integer pd);
	
	public PageData selectBusinessJoinByUserId(Integer pd);
	
	public int insertBusinessJoin(PageData pd);
	
	public List<PageData> selectBusinessJoinByPage(Page pd);
	
	public List<PageData> selectBusinessJoinByMap(PageData pd);
	
	public List<PageData> selectWxlistByPage(PageData pd);
	
	public int deleteBusinessJoin(PageData pd);
	
	public int updateBusinessJoin(PageData pd);
	
	public List<StoreInfo> selectBusinessInfoByPage(Page pd);
	
}

package com.easaa.scenicspot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easaa.core.model.dao.EADao;
import com.easaa.core.model.service.impl.EABaseService;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.dao.AgencyMapper;

@Service
public class AgencyService  extends EABaseService{
    @Autowired
	private AgencyMapper agencyMapper;
	
	@Override
	public EADao getDao() {
		return agencyMapper;
	}
	
	public List<PageData> selectByListPage(Page page){
		return agencyMapper.selectByListPage(page);
	}
	
	public List<PageData> selectGuiderByMap(PageData pd){
		Page page=new Page();
		page.setPd(pd);
		return agencyMapper.selectGuiderByMap(page);
	}
	
	public List<PageData> selectGuiderByPage(Page page){
		return agencyMapper.selectGuiderByPage(page);
	}
	
	public List<PageData> selectGuiderByListPage(Page page){
		return agencyMapper.selectGuiderByListPage(page);
	}
	public PageData selectGuiderById(Integer pd){
		return agencyMapper.selectGuiderById(pd);
	}
	
	public void insertGuider(PageData pd){
		agencyMapper.insertGuider(pd);
	}
	
	public void updateGuider(PageData pd){
		agencyMapper.updateGuider(pd);
	}
	
	public void deleteGuider(PageData pd){
		agencyMapper.deleteGuider(pd);
	}
}

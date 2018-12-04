package com.easaa.scenicspot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easaa.core.model.dao.EADao;
import com.easaa.core.model.service.impl.EABaseService;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.dao.CultureMapper;

@Service
public class CultureService  extends EABaseService{
    @Autowired
	private CultureMapper cultureMapper;
	
	@Override
	public EADao getDao() {
		return cultureMapper;
	}
	
	public List<PageData> categorySelectByMap(PageData pd){
		return cultureMapper.categorySelectByMap(pd);
	}
	
	
	public PageData categorySelectOneByMap(PageData pd){
		List<PageData> lists = cultureMapper.categorySelectByMap(pd);
		if(lists != null && lists.size() > 0){
			return lists.get(0);
		}
		return null;
	}
	
	public void categoryUpdate(PageData pd){
		 cultureMapper.categoryUpdate(pd);
	}
	
	public void categoryInsert(PageData pd){
		 cultureMapper.categoryInsert(pd);
	}
}

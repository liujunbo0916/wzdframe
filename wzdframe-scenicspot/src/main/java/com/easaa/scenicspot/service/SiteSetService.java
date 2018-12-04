package com.easaa.scenicspot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easaa.core.model.dao.EADao;
import com.easaa.core.model.service.impl.EABaseService;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.dao.GuideSerMapper;
import com.easaa.scenicspot.dao.SiteSetMapper;

@Service
public class SiteSetService  extends EABaseService{

	@Autowired
	private SiteSetMapper siteSetMapper;
	
	@Autowired
	private GuideSerMapper guideSerMapper;
	
	@Override
	public EADao getDao() {
		return siteSetMapper;
	}

	public PageData selectAll(){
		return siteSetMapper.selectAll();
	}
	//预约服务新增订单
	public void insertBooKOrder(PageData pd){
		guideSerMapper.insert(pd);
	}
}

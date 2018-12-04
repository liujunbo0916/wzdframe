package com.easaa.scenicspot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easaa.core.model.dao.EADao;
import com.easaa.core.model.service.impl.EABaseService;
import com.easaa.scenicspot.dao.ShopClassMapper;

/**
 * 店铺分类service
 * @author 
 */
@Service
public class ShopClassService  extends EABaseService{

	@Autowired
	private ShopClassMapper businessClassMapper;
	
	@Override
	public EADao getDao() {
		return businessClassMapper;
	}

}

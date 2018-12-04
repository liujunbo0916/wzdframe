package com.easaa.scenicspot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easaa.core.model.dao.EADao;
import com.easaa.core.model.service.impl.EABaseService;
import com.easaa.scenicspot.dao.ShopGradeMapper;

@Service
public class ShopGradeService extends EABaseService{

	@Autowired
	private ShopGradeMapper businessGradeMapper;
	@Override
	public EADao getDao() {
		return businessGradeMapper;
	}
}

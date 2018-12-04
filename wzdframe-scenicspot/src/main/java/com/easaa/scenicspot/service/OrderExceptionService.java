package com.easaa.scenicspot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easaa.core.model.dao.EADao;
import com.easaa.core.model.service.impl.EABaseService;
import com.easaa.scenicspot.dao.OrderExceptionMapper;

@Service
public class OrderExceptionService  extends EABaseService{

	@Autowired
	private OrderExceptionMapper orderExceptionMapper;
	
	@Override
	public EADao getDao() {
		return orderExceptionMapper;
	}

}

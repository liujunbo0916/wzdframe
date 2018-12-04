package com.easaa.scenicspot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easaa.core.model.dao.EADao;
import com.easaa.core.model.service.impl.EABaseService;
import com.easaa.scenicspot.dao.HolidayMapper;

@Service
public class HolidayService extends EABaseService{
	@Autowired
	private HolidayMapper holidayMapper;
	@Override
	public EADao getDao() {
		return holidayMapper;
	}
}

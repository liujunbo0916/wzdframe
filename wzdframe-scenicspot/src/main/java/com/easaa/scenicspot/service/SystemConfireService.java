package com.easaa.scenicspot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easaa.core.model.dao.EADao;
import com.easaa.core.model.service.impl.EABaseService;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.dao.SystemConfireMapper;

/**
 * 系统配置预加载数据
 * 
 * 
 * @author liujunbo
 *
 */
@Service
public class SystemConfireService extends EABaseService{
	
	private List<PageData> smsTplList;
	@Autowired
	private SystemConfireMapper systemConfireMapper;

	@Override
	public EADao getDao() {
		return systemConfireMapper;
	}
	public PageData getSmsTplByCode(String code){
		PageData resultPd = new PageData();
		if(smsTplList == null){
			smsTplList = systemConfireMapper.selectAllSmsTpl();
		}
		for(PageData tmp:smsTplList){
			if(code.equals(tmp.getAsString("tpl_var"))){
				resultPd = tmp;
			}
		}
		return resultPd;
	}
	
}

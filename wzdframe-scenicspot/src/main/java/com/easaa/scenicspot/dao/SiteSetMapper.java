package com.easaa.scenicspot.dao;

import com.easaa.core.model.dao.EADao;
import com.easaa.entity.PageData;
public interface SiteSetMapper  extends EADao{

	public PageData selectAll();
	
}

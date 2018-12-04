package com.easaa.scenicspot.dao;

import java.util.List;

import com.easaa.core.model.dao.EADao;
import com.easaa.entity.PageData;

public interface CultureMapper  extends EADao{
	/**
	 * 文化分类列表
	 */
	public List<PageData> categorySelectByMap(PageData pd);
	/**
	 * 分化分类更新
	 * @param pd
	 */
	public void categoryUpdate(PageData pd);
	
	/**
	 * 新增文化分类
	 * @param pd
	 */
	
	public void categoryInsert(PageData pd);
}

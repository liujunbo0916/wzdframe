package com.easaa.scenicspot.dao;

import java.util.List;

import com.easaa.core.model.dao.EADao;
import com.easaa.entity.PageData;

public interface SystemConfireMapper extends EADao{

	List<PageData> selectAllSmsTpl();

}

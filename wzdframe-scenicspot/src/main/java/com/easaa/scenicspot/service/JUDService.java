package com.easaa.scenicspot.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easaa.core.model.dao.EADao;
import com.easaa.core.model.service.impl.EABaseService;
import com.easaa.core.util.EADate;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.dao.JUDMapper;

@Service
public class JUDService   extends EABaseService{

	private static final String[]  ZHMONTH = new String[]{"JANUARY","FEBRUARY","MARCH","APRIL","MAY","JUNE","JULY","AUGUST","SEPTEMBER","OCTOBER","NOVEMBER","DECEMBER"};
	
	@Override
	public EADao getDao() {
		return jUDMapper;
	}
	@Autowired
	private JUDMapper jUDMapper;
	
	public List<PageData> newsList(PageData pd){
		List<PageData> newsList =  jUDMapper.selectNewsList(pd);
		for(PageData tpd : newsList){
			String puttimeStr = tpd.getAsString("PUTTIME");
			Date PUTTIME = EADate.stringToDate(puttimeStr);
			tpd.put("show_mouth", ZHMONTH[PUTTIME.getMonth()]);
			tpd.put("show_year", puttimeStr.substring(0, 4));
			tpd.put("show_day", PUTTIME.getDay());
		}
		return newsList;
	}
	
	public PageData newsDetail(PageData pd){
		
		PageData newsDetail = jUDMapper.selectNewsDetail(pd);
		String puttimeStr = newsDetail.getAsString("PUTTIME");
		Date PUTTIME = EADate.stringToDate(puttimeStr);
		newsDetail.put("show_mouth", ZHMONTH[PUTTIME.getMonth()]);
		newsDetail.put("show_year", puttimeStr.substring(0, 4));
		newsDetail.put("show_day", PUTTIME.getDay());
		return newsDetail;
	}
	
	
	public void insertContact(PageData pd){
		jUDMapper.insertContact(pd);
	}
	public List<PageData> countryList(){
		return jUDMapper.countryList();
	}
	public void insertUserInfo(PageData pd){
		jUDMapper.insertUserInfo(pd);
	}
	public List<PageData> condomListPage(PageData pd){
		Page page = new Page();
		page.setPd(pd);
		return jUDMapper.condomListPage(page);
	}
	public void updateCondom(PageData pd) {
		jUDMapper.updateCondom(pd);
	}
	public void addCondom(PageData pd) {
		jUDMapper.addCondom(pd);
	}
	public void deleteCondom(PageData pd) {
		jUDMapper.deleteCondom(pd);
	}
	public List<PageData> condomListByMap(PageData pd){
		return jUDMapper.condomListByMap(pd);
	}
	
}

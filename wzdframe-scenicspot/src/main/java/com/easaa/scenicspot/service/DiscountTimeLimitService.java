package com.easaa.scenicspot.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.easaa.scenicspot.dao.DiscountTimeLimitMapper;
import com.easaa.core.model.dao.EADao;
import com.easaa.core.model.service.impl.EABaseService;
import com.easaa.core.util.EADate;
import com.easaa.entity.PageData;

@Service
public class DiscountTimeLimitService extends EABaseService {

	@Autowired
	private DiscountTimeLimitMapper activityTimeLimitMapper;

	@Override
	public EADao getDao() {
		return activityTimeLimitMapper;
	}

	public List<PageData> limitAllProList(int stringToInt) {
		return activityTimeLimitMapper.selectLimitProList(stringToInt);
	}
	/**
	 * pd limit_id 或者id  必传其一  否则删除全部
	 * 
	 */
	public void deleteLimitGoods(PageData pd) {
		activityTimeLimitMapper.deleteLimitGoods(pd);
	}
	
	public void updateLimitGoods(PageData pd) {
		activityTimeLimitMapper.updateLimitGoods(pd);
	}
	public void insertLimitGoods(PageData pd) {
		activityTimeLimitMapper.insertLimitGoods(pd);
	}
	public PageData selectLimitGoodsByID(Integer pd) {
		return activityTimeLimitMapper.selectLimitGoodsByID(pd);
	}
	public List<PageData> selectLimitGoodsByMap(PageData pd) {
		return activityTimeLimitMapper.selectLimitGoodsByMap(pd);
	}
	
	public List<PageData> selectProductByMap(PageData pd){
		List<PageData> results =  activityTimeLimitMapper.selectProductByMap(pd);
		for(PageData tpd : results){
			if(StringUtils.isNotEmpty(tpd.getAsString("timelimit_end_time"))){
				long cutDown = (EADate.stringToDate(tpd.getAsString("timelimit_end_time")).getTime() - new Date().getTime())/1000;
				tpd.put("cutDown", cutDown > 0?cutDown:0);
			}else{
				tpd.put("cutDown", 0);
			}
		}
		return results;
	}
}

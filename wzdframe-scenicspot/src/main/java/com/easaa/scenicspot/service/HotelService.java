package com.easaa.scenicspot.service;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.easaa.core.model.dao.EADao;
import com.easaa.core.model.service.impl.EABaseService;
import com.easaa.core.util.EAString;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.dao.HotelMapper;

@Service
public class HotelService  extends EABaseService{
    @Autowired
	private HotelMapper hotelMapper;
	
	@Override
	public EADao getDao() {
		return hotelMapper;
	}
	
	public List<PageData> selectHotelTypeByMap(PageData pd){
		Page page=new Page();
		page.setPd(pd);
		return hotelMapper.selectHotelTypeByMap(page);
	}
	
	public List<PageData> selectHotelTypeByPage(Page page){
		return hotelMapper.selectHotelTypeByPage(page);
	}
	public List<PageData> selectByListPage(Page page){
		if(StringUtils.isEmpty(page.getPd().getAsString("currentLat"))){
			page.getPd().put("currentLat", "0.00");
		}
		if(StringUtils.isEmpty(page.getPd().getAsString("currentLng"))){
			page.getPd().put("currentLng", "0.00");
		}
		List<PageData> waitCal =  hotelMapper.selectByListPage(page);
		for(PageData tempPd : waitCal){
			double distance = Double.parseDouble(tempPd.getAsString("distance"));
			if(distance > 100){ //转换成KM
				distance = distance/1000;
				tempPd.put("isKm", true); //22.499278555211
			}else{
				tempPd.put("isKm", false);
			}
			String distanceStr = distance+"";
			if(distanceStr.indexOf(".") != -1 && (distanceStr.substring(distanceStr.indexOf("."), distanceStr.length()).length() > 2)){
				//如果小数点后面数字多余2位为其做数字格式化操作
				distanceStr = new java.text.DecimalFormat("#.00").format(Double.parseDouble(distanceStr));
			}
			tempPd.put("distance", distanceStr);
	     }
		return waitCal;
	}
	
	public PageData selectHotelTypeById(Integer pd){
		return hotelMapper.selectHotelTypeById(pd);
	}
	
	public void insertHotelType(PageData pd){
		hotelMapper.insertHotelType(pd);
	}
	
	public void updateHotelType(PageData pd){
		hotelMapper.updateHotelType(pd);
	}
	
	public void deleteHotelType(PageData pd){
		hotelMapper.deleteHotelType(pd);
	}
}

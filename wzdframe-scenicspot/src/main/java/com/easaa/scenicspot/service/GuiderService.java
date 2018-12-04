package com.easaa.scenicspot.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.easaa.core.model.dao.EADao;
import com.easaa.core.model.service.impl.EABaseService;
import com.easaa.core.util.EAUtil;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.dao.GuideSerMapper;

@Service
public class GuiderService  extends EABaseService{
    @Autowired
	private GuideSerMapper guideSerMapper;
	
	@Override
	public EADao getDao() {
		return guideSerMapper;
	}
	/**
	 * 导游订单回调
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public boolean callBackAllOrder(PageData param) throws Exception{
		//更改订单状态
		String order_sn=param.getAsString("out_trade_no");
		PageData guiderSerOrder = guideSerMapper.selectByOrderSn(EAUtil.isEmpty(order_sn)?"":order_sn);
		if(EAUtil.isEmpty(guiderSerOrder)){
			throw new Exception("微信回调异常。未找到微信回调的订单号");
		}
		if("1".equals(guiderSerOrder.getAsString("pay_status"))){
			return true;
		}
		guiderSerOrder.put("pay_type", param.getAsString("pay_type"));
		guiderSerOrder.put("pay_status", "1");
		guiderSerOrder.put("guide_status", "1");
		guideSerMapper.update(guiderSerOrder);
		return true;
	}
	
}

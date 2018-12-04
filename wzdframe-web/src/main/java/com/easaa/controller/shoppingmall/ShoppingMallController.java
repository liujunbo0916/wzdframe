package com.easaa.controller.shoppingmall;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.entity.PageData;
import com.easaa.goods.service.GoodsService;

/**
 * 商城控制器  如商城的全局设置
 * 
 * @author liujunbo
 *
 */

@Controller
@RequestMapping("/shopmall/")
public class ShoppingMallController extends BaseController{

	
	@Autowired
	private GoodsService goodsService;
	@RequestMapping("setting")
	public ModelAndView settingPage(){
		ModelAndView mv = this.getModelAndView();
		Map<String, PageData> settingMap = goodsService.selectGoodsSetting();
		mv.addObject("dataModel",settingMap);
		mv.setViewName("/goods/setting/setting");
		return mv;
	}
	@RequestMapping("settingAction")
	public ModelAndView settingAction(){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		PageData pointPd = new PageData();
		pointPd.put("setting_code", pd.getAsString("point_setting_code"));
		pointPd.put("setting_value", pd.getAsString("point_setting_value"));
		goodsService.updateGoodsSetting(pointPd);
		PageData proportionPd = new PageData();
		proportionPd.put("setting_code", pd.getAsString("proportion_setting_code"));
		proportionPd.put("setting_value", pd.getAsString("proportion_point")+":"+pd.getAsString("proportion_RMB"));
		goodsService.updateGoodsSetting(proportionPd);
		PageData quanPd = new PageData();
		quanPd.put("setting_code", pd.getAsString("quan_setting_code"));
		quanPd.put("setting_value", pd.getAsString("quan_setting_value"));
		goodsService.updateGoodsSetting(quanPd);
		PageData wrfeePd = new PageData();
		wrfeePd.put("setting_code", pd.getAsString("withdrawalsfee_code"));
		wrfeePd.put("setting_value", pd.getAsString("withdrawals_fee"));
		goodsService.updateGoodsSetting(wrfeePd);
		PageData wrdPd = new PageData();
		wrdPd.put("setting_code", pd.getAsString("withdrawalsday_code"));
		wrdPd.put("setting_value", pd.getAsString("withdrawals_day"));
		goodsService.updateGoodsSetting(wrdPd);
		PageData rcPd = new PageData();
		rcPd.put("setting_code", pd.getAsString("recharge_code"));
		rcPd.put("setting_value", pd.getAsString("recharge"));
		goodsService.updateGoodsSetting(rcPd);
		PageData wrPd = new PageData();
		wrPd.put("setting_code", pd.getAsString("withdrawals_code"));
		wrPd.put("setting_value", pd.getAsString("withdrawals"));
		goodsService.updateGoodsSetting(wrPd);
		PageData rcrPd = new PageData();
		rcrPd.put("setting_code", pd.getAsString("rechargeratio_code"));
		rcrPd.put("setting_value", pd.getAsString("rechargeratio_RMB")+":"+pd.getAsString("rechargeratio_point"));
		goodsService.updateGoodsSetting(rcrPd);
		PageData limitHour = new PageData();
		limitHour.put("setting_code", pd.getAsString("limitPayHour_code"));
		limitHour.put("setting_value", pd.getAsString("limitPayHour"));
		goodsService.updateGoodsSetting(limitHour);
		PageData givePointsSet = new PageData();
		givePointsSet.put("setting_code", pd.getAsString("givePointsSet_code"));
		givePointsSet.put("setting_value", pd.getAsString("givePointsSet_value"));
		goodsService.updateGoodsSetting(givePointsSet);
		PageData closeTime = new PageData();
		closeTime.put("setting_code", pd.getAsString("orderCloseTime_code"));
		closeTime.put("setting_value", pd.getAsString("orderCloseTime"));
		goodsService.updateGoodsSetting(closeTime);
		PageData servicePhone = new PageData();
		servicePhone.put("setting_code", pd.getAsString("servicePhoneCode"));
		servicePhone.put("setting_value", pd.getAsString("servicePhoneValue"));
		goodsService.updateGoodsSetting(servicePhone);
		mv.setViewName("redirect:/shopmall/setting");
		return mv;
	}
}

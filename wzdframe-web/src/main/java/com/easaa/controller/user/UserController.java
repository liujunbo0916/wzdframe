package com.easaa.controller.user;

import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EAUtil;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.upm.upm.Jurisdiction;
import com.easaa.user.service.UserAccountService;
import com.easaa.user.service.UserAddressService;
import com.easaa.user.service.UserService;
/**
 * 管理员管理
 * @author 约
 *
 */
@Controller
@RequestMapping("/sys/user/")
public class UserController extends BaseController{
	@Autowired
	private UserService  userService;
	@Autowired
	private UserAddressService  userAddressService;
	@Autowired
	private UserAccountService	userAccountService;
	
	/**
	 * 用户列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "listPage")
	public ModelAndView listPage(Page page)throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		if(StringUtils.isNotEmpty(pd.getAsString("start_create_time"))){
			pd.put("start_create_time", EADate.stringToDate(pd.getAsString("start_create_time"), "yyyy-MM-dd"));
		}
		if(StringUtils.isNotEmpty(pd.getAsString("end_create_time"))){
			pd.put("end_create_time", EADate.stringToDate(pd.getAsString("end_create_time"), "yyyy-MM-dd"));
		}
		List<PageData>	varList=userService.selectByAllPage(page);
		mv.addObject("varList", varList);
		mv.addObject("page", page);
		mv.addObject("pd", pd);
		mv.setViewName("user/userList");
		mv.addObject("QX",Jurisdiction.getHC());
		return mv;
	}
	
	/**
	 * 用户地址列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "userAddressList")
	public ModelAndView userAddressList(int userId)throws Exception{
		ModelAndView mv = this.getModelAndView();
		List<PageData>	varList=userAddressService.getUserAddressList(userId);
		mv.addObject("varList", varList);
		mv.setViewName("user/userAddressList");
		return mv;
	}
	
	@RequestMapping(value = "edit")
	public ModelAndView edit() {
		ModelAndView mv = this.getModelAndView();
		String id=getRequest().getParameter("user_id");
		mv.addObject("dataModel", userService.getById(EAString.stringToInt(id, 0)));
		mv.addObject("userAccount", userAccountService.getAccountByUserId(EAString.stringToInt(id, 0)));
		mv.setViewName("user/userEdit");
		return mv;
	}
	
	@RequestMapping(value="editAction")
	public ModelAndView editAction(){
		ModelAndView mv = this.getModelAndView();
		PageData userParam = this.getPageData();
		userService.edit(userParam);
		mv.setViewName("redirect:/sys/user/listPage");
		return mv;
	}
	
	
	@RequestMapping(value = "userAccountLog")
	public ModelAndView userAccountLog(Page page) {
		PageData pd=this.getPageData();
		page.setPd(pd);
		List<PageData>	varList=userAccountService.getAccountLogByPage(page);
		ModelAndView mv = this.getModelAndView();
		mv.addObject("varList", varList);
		mv.addObject("userModel", userService.getById(pd.getAsInt("user_id")));
		mv.addObject("accountModel", userAccountService.getAccountByUserId(pd.getAsInt("user_id")));
		mv.setViewName("user/userAccountLog");
		return mv;
	}
	@RequestMapping(value = "editUserAccountPage")
	public ModelAndView editUserAccountPage(int user_id) {
		PageData account=userAccountService.getAccountByUserId(user_id);
		ModelAndView mv = this.getModelAndView();
		mv.addObject("accountModel", account);
		mv.addObject("userModel", userService.getById(user_id));
		mv.setViewName("user/editUserAccount");
		return mv;
	}

	/**
	 * 保存管理员手动修改个人账号信息
	 * @return
	 */
	@RequestMapping(value = "saveUserAccount")
	public ModelAndView saveUserAccount() {
		PageData pd= this.getPageData();
		int user_id=pd.getAsInt("user_id");
		PageData account=userAccountService.getAccountByUserId(user_id);
		StringBuffer logStr=new StringBuffer();
		//用户总金额
		updateAccountItem("user_money",pd,account,false,logStr,"账户余额");
		//用户冻结金额
		updateAccountItem("frozen_money",pd,account,false,logStr,"冻结金额");
		//用户累计充值金额
		updateAccountItem("charge_money",pd,account,false,logStr,"累计充值");
		//用户累计提现金额
		updateAccountItem("withdraw_money",pd,account,false,logStr,"累计提现");
		//用户累计购物花费金额
		updateAccountItem("order_money",pd,account,false,logStr,"累计购物");
		//用户累计获得的佣金
		updateAccountItem("rebate_money",pd,account,true,logStr,"累计佣金");
		//用户总共积分
		updateAccountItem("user_points",pd,account,true,logStr,"账户积分");
		//用户冻结积分
		updateAccountItem("frozen_points",pd,account,true,logStr,"冻结积分");
		//用户累计充值赠送积分
		updateAccountItem("charge_points",pd,account,true,logStr,"充值积分");
		//用户累计使用的积分
		updateAccountItem("use_points",pd,account,true,logStr,"累计使用");
		//用户累计购物赠送的积分
		updateAccountItem("order_points",pd,account,true,logStr,"赠送积分");
		//用户累计返佣的积分
		updateAccountItem("rebate_points",pd,account,true,logStr,"返佣积分");
		//用户累计分享赠送的积分
		updateAccountItem("share_points",pd,account,false,logStr,"分享积分");
		account.put("change_time", EADate.getCurrentTime());
		userAccountService.edit(account);
		int isAdd=pd.getAsInt("add_user_money");
		float user_money = pd.getAsFloat("user_money");
		if(isAdd!=1){
			user_money=-user_money;
		}
		if(isAdd!=1){
			user_money=-user_money;
		}
		isAdd=pd.getAsInt("add_user_points");
		int user_points = pd.getAsInt("user_points");
		if(isAdd!=1){
			user_points=-user_points;
		}
		userAccountService.editUserAccount(account,getAdminName(), user_money, user_points,pd.getAsString("log_note"),logStr.toString());
		ModelAndView mv = this.getModelAndView();
		mv.addObject("dataModel", account);
		mv.setViewName("redirect:/sys/user/editUserAccountPage?user_id="+user_id);
		return mv;
	}
	
	private void updateAccountItem(String key,PageData form, PageData account,boolean isInt,StringBuffer logStr,String label){
		//用户总金额
		int isAdd=form.getAsInt("add_"+key);
		float nValue = form.getAsFloat(key);
		if(nValue<=0){
			return;
		}
		float oValue = account.getAsFloat(key);
		if(!EAString.isNullStr(logStr.toString())){
			logStr.append(";");
		}
		if(isAdd==1){
			logStr.append(label+":+"+nValue);
			if(isInt){
				account.put(key, (int)(oValue+nValue));
			}else{
				account.put(key, oValue+nValue);
			}
		}else{
			logStr.append(label+":-"+nValue);
			if(isInt){
				account.put(key, (int)(oValue-nValue));
			}else{
				account.put(key, oValue-nValue);
			}
		}
	}
	
}
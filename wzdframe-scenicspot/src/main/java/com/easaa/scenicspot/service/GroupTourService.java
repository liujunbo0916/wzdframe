package com.easaa.scenicspot.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easaa.core.model.dao.EADao;
import com.easaa.core.model.service.impl.EABaseService;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.dao.GroupTourMapper;
import com.easaa.scenicspot.entity.GroupTourOrder;
import com.easaa.scenicspot.entity.PageExtend;
import com.easaa.scenicspot.entity.ticket.Traveler;
import com.easaa.user.dao.UserMapper;
import com.easaa.util.properties.PropertiesFactory;
import com.easaa.util.properties.PropertiesFile;
import com.easaa.util.properties.PropertiesHelper;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Service
public class GroupTourService  extends EABaseService{
	
	private static final PropertiesHelper PROPERTIESHELPER = PropertiesFactory
			.getPropertiesHelper(PropertiesFile.SYS);
	
	
    @Autowired
	private GroupTourMapper groupTourMapper;
    
    @Autowired
    private UserMapper userMapper;
	
	@Override
	public EADao getDao() {
		return groupTourMapper;
	}
	
	
	/**
	 *  出游人 
	 */
	public List<PageData> selectTravelersListByPage(Page page){
		return groupTourMapper.selectTravelersListByPage(page);
	}
	
	public List<PageData> selectTravelersByPage(Page page){
		return groupTourMapper.selectTravelersByPage(page);
	}
	
	public List<PageData> selectTravelersByMap(PageData pd){
		Page page=new Page();
		page.setPd(pd);
		return groupTourMapper.selectTravelersByMap(page);
	}
	
	public List<PageData> selectTravelersByIds(PageData pd){
		return groupTourMapper.selectTravelersByIds(pd);
	}
	
	public PageData selectTravelersById(Integer pd){
		return groupTourMapper.selectTravelersById(pd);
	}
	
	public void insertTravelers(PageData pd){
		groupTourMapper.insertTravelers(pd);
	}
	
	public void updateTravelers(PageData pd){
		groupTourMapper.updateTravelers(pd);
	}
	
	public void deleteTravelers(PageData pd){
		groupTourMapper.deleteTravelers(pd);
	}
	
	
	/**
	 *  线路订单 
	 */
	public List<PageData> selectOrderListByPage(Page page){
		return groupTourMapper.selectOrderListByPage(page);
	}
	
	public List<PageData> selectOrderByPage(Page page){
		return groupTourMapper.selectOrderByPage(page);
	}
	
	public List<PageData> selectOrderByMap(PageData pd){
		Page page=new Page();
		page.setPd(pd);
		return groupTourMapper.selectOrderByMap(page);
	}
	
	public PageData selectOrderById(Integer pd){
		return groupTourMapper.selectOrderById(pd);
	}
	
	public void insertOrder(PageData pd){
		groupTourMapper.insertOrder(pd);
	}
	
	public void updateOrder(PageData pd){
		groupTourMapper.updateOrder(pd);
	}
	
	public void deleteOrder(PageData pd){
		groupTourMapper.deleteOrder(pd);
	}
	
	public List<PageData> selectPcByPage(PageExtend page){
		return groupTourMapper.selectPcByPage(page);
	}
	public PageData selectByOrderSn(String orderSn){
		return groupTourMapper.selectOrderByOrderSn(orderSn);
	}

	/**
	 * 添加跟团游订单
	 * @param paramJson
	 * @return
	 * @throws Exception
	 */
	public PageData createOrder(JSONObject paramJson,HttpServletRequest request) throws Exception {
		Page page = new Page();
    	PageData pd = new PageData();
    	String groupTourId =  paramJson.getString("groupTourId");
    	pd.put("grouptour_id", groupTourId);
    	page.setPd(pd);
    	List<PageData> ticketList = groupTourMapper.selectByMap(page);
    	if(ticketList == null || ticketList.size() == 0){
    		throw new Exception("所请求的跟团游信息有误");
    	}
    	
    	
    	/**
    	 * 判断是否为匿名购买
    	 * 如果匿名购买用联系人手机号 查询用户信息 如果存在 将这条订单 放在该用户下面
    	 * 
    	 * 如果查不出来创建用户信息
    	 */
    	if(paramJson.get("anonymous") != null && "1".equals(paramJson.getString("anonymous"))){
    		if(paramJson.get("ContactMobile") == null || StringUtils.isEmpty(paramJson.getString("ContactMobile"))){
    			throw new Exception("联系人手机号不能为空");
    		}
    		PageData userInfo = userMapper.selectByUserName(paramJson.getString("ContactMobile"));
    		if(userInfo == null){
    			//创建用户
    			userInfo = new PageData();
    			userInfo.put("phone", paramJson.getString("ContactMobile"));
    			userInfo.put("user_name", paramJson.getString("ContactMobile"));
    			userInfo.put("register_channel", 4);
    			userInfo.put("register_time", EADate.getCurrentTime());
    			userInfo.put("user_money", 0);
    			userInfo.put("user_points", 0);
    			userInfo.put("is_validated", 0);
    			userInfo.put("is_buyer", 1);
    			userInfo.put("is_loginer", 1);
    			userInfo.put("user_type", 1);
    			userMapper.insert(userInfo);
    		}
    		paramJson.put("user_id", userInfo.getAsString("user_id"));
    		//将用户信息放入session
    		request.getSession().setAttribute("userInfo", userInfo);
    	}
    	pd.put("order_sn", EAString.getFourSn());
    	pd.put("total_price", paramJson.get("orderMoney"));
    	pd.put("pay_price", paramJson.get("orderMoney"));
    	pd.put("adult_num", paramJson.get("adultNum"));
    	pd.put("adult_price", paramJson.get("adultPrice"));
    	pd.put("children_num", paramJson.get("childsNum"));
    	pd.put("children_price", paramJson.get("childrenPrice"));
    	pd.put("departure_date", paramJson.get("tourDate"));
    	pd.put("link_perple", paramJson.get("conName"));
    	pd.put("link_phone", paramJson.get("conPhone"));
    	pd.put("user_id",paramJson.get("user_id"));
    	pd.put("grouptour_name", ticketList.get(0).getAsString("grouptour_name"));
    	pd.put("order_state", "0");
    	pd.put("pay_status", "0");
    	pd.put("pay_type", "0");
    	pd.put("create_time", EADate.getCurrentTime());
    	groupTourMapper.insertOrder(pd);
    	JSONArray jsonAry = paramJson.getJSONArray("Tourists");
    	List<PageData> traveler = new ArrayList<PageData>();
    	Set<String> idcards = new HashSet<String>();
    	Set<String> phones = new HashSet<String>();
    	if(jsonAry.size() > 0){
    		PageData tempPd = null;
    		for(int i = 0;i<jsonAry.size();i++){
    			tempPd = new PageData();
    			idcards.add(jsonAry.getJSONObject(i).getString("IdCardNo"));
    			phones.add(jsonAry.getJSONObject(i).getString("Mobile"));
    			tempPd.put("to_id", pd.getAsString("order_id"));
    			tempPd.put("to_name", jsonAry.getJSONObject(i).get("Name"));
    			tempPd.put("to_phone", jsonAry.getJSONObject(i).get("Mobile"));
    			tempPd.put("to_idcard", jsonAry.getJSONObject(i).get("IdCardNo"));
    			tempPd.put("to_type", jsonAry.getJSONObject(i).get("checkType"));
    			traveler.add(tempPd);
        	}
    		groupTourMapper.insertTraver(traveler);
    	}
    	if(idcards.size() < traveler.size()){
    		throw new Exception("一张身份证只能订一张票");
    	}
    	if(phones.size() < traveler.size()){
    		throw new Exception("手机号重复");
    	}
    	return pd;
	}

	/**
	 * wx 跟团游订单列表
	 * @param page
	 * @return
	 */
	public List<GroupTourOrder> selectEntityByPage(Page page) {
		return groupTourMapper.selectEntityByPage(page);
	}

	/**
	 * 微信支付宝回调
	 * @param param
	 * @return
	 * out_trade_no
	 */
	public boolean callBack(PageData param) {
		try{
			String orderSn = param.getAsString("out_trade_no");
			PageData orderInfo = groupTourMapper.selectOrderByOrderSn(orderSn);
			orderInfo.put("pay_type", param.getAsString("pay_type"));
			orderInfo.put("order_state", 1);
			orderInfo.put("pay_status", 1);
			groupTourMapper.updateOrder(orderInfo);
			return true;
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
	}
    /**
     * 申请退款逻辑
     * @param travelOrder
     * @throws Exception 
     */
	public void doApplyRefund(GroupTourOrder travelOrder,JSONObject paramObj) throws Exception {
		String travelDateStr = travelOrder.getDepartureDate();
		if(EADate.stringToDate(travelDateStr, "yyyy-MM-dd").getTime() <= (new Date()).getTime()){
			throw new Exception("退款日期已过。无法退款");
		}
		//获取退款的人的id
		List<String> refundTravelers = JSONArray.toList(paramObj.getJSONArray("traveler"), String.class,new JsonConfig());
		
		if(refundTravelers == null || refundTravelers.size() == 0){
			throw new Exception("请选择要退款的出游人");
		}
		//订单对应的旅行人
		List<Traveler> travelers = travelOrder.getTraveler();
		Map<String,Traveler> bridgeMap = new HashMap<String,Traveler>();
		for(Traveler t:travelers){
			bridgeMap.put(t.getId(), t);
		}
		for(String tids : refundTravelers){
			Traveler tempTravel = bridgeMap.get(tids);
			Integer applyNum = EAString.stringToInt(tempTravel.getApplyNum(), 0);
			if("0".equals(tempTravel.getRefundStatus()) || "3".equals(tempTravel.getRefundStatus())){
				//如果未退款或者退款失败才能给予申请的资格   
				//只有小于 申请次数的 客户才能退款
				if(applyNum >=  EAString.stringToInt(PROPERTIESHELPER.getValue("MAX_APPLY_REFUND_NUM"), 3)){
					throw  new Exception(tempTravel.getName()+"该游客申请退款次数已超过3次，无法进行退款操作");
				}
				//进行退款申请更新
				tempTravel.setApplyNum(++applyNum +"");
				tempTravel.setRefundStatus("1");
				groupTourMapper.updateOrderTraver(tempTravel);
				//插入退款单
				PageData refundOrderParam = new PageData();
				refundOrderParam.put("order_id", paramObj.getString("order_id"));
				refundOrderParam.put("order_travel_id", tempTravel.getId());
				refundOrderParam.put("refund_no", "tk"+EAString.getFourSn());
				refundOrderParam.put("refund_status", "1");
				refundOrderParam.put("refund_type", travelOrder.getPayType());
				if("0".equals(tempTravel.getType())){
					refundOrderParam.put("refund_money", travelOrder.getChildrenPrice());
				}else if("1".equals(tempTravel.getType())){
					refundOrderParam.put("refund_money", travelOrder.getAdultPrice());
				}
				refundOrderParam.put("create_time", EADate.getCurrentTime());
				refundOrderParam.put("refund_reason", paramObj.get("refund_reson"));
				refundOrderParam.put("user_id", travelOrder.getUserId());
				groupTourMapper.insertRefundOrder(refundOrderParam);
			}
		}
		/**
		 * 检测 订单是否退款完成  
		 */
		PageData paramPd = new PageData();
		paramPd.put("order_id", EAString.stringToInt(paramObj.getString("order_id"), 0));
		//PageData travelOrder = groupTourService.selectOrderById(EAString.stringToInt(paramObj.getString("order_id"), 0));
		GroupTourOrder groupOrder = groupTourMapper.selectOrderEntity(paramPd);
		travelers = groupOrder.getTraveler();
		boolean refundFlag = false;
		//如果有一为游客没有退款 不改变订单状态
		for(Traveler tempTravel : travelers){
			if("0".equals(tempTravel.getRefundStatus()) || StringUtils.isEmpty(tempTravel.getRefundStatus())){
				refundFlag = true;
			}
		}
		//更新订单状态
		if(!refundFlag){
			paramPd.put("order_state", "4");
			groupTourMapper.updateOrder(paramPd);
		}
	}


	public GroupTourOrder selectOrderEntity(PageData pd) {
		return groupTourMapper.selectOrderEntity(pd);
	}
	
	public List<PageData> selectTravelRefundByPage(Page page){
		return groupTourMapper.selectTravelRefundByPage(page);
	}
	
	
}

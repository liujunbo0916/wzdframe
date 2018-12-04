package com.easaa.scenicspot.dao;

import java.util.List;

import com.easaa.core.model.dao.EADao;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.entity.GroupTourOrder;
import com.easaa.scenicspot.entity.PageExtend;
import com.easaa.scenicspot.entity.ticket.Traveler;

public interface GroupTourMapper  extends EADao{
	/**
	 * 出游人
	 */
	public List<PageData> selectTravelersByMap(Page page);
	
	public List<PageData> selectTravelersByPage(Page page);
	
	public List<PageData> selectTravelersListByPage(Page page);
	
	public PageData selectTravelersById(Integer id);
	
	public List<PageData> selectTravelersByIds(PageData pd);
	
	public void insertTravelers(PageData pd);
	
	public void updateTravelers(PageData pd);
	
	public void updateOrderTraver(Traveler pd);
	
	public void deleteTravelers(PageData pd);
	
	/**
	 * 线路订单
	 */
	public List<PageData> selectOrderByMap(Page page);
	
	public List<PageData> selectOrderByPage(Page page);
	
	public List<GroupTourOrder> selectEntityByPage(Page page);
	public GroupTourOrder selectOrderEntity(PageData pd);
	public List<PageData> selectOrderListByPage(Page page);
	
	public PageData selectOrderById(Integer id);
	
	public PageData selectOrderByOrderSn(String orderSn);
	
	public void insertOrder(PageData pd);
	
	public void updateOrder(PageData pd);
	
	public void deleteOrder(PageData pd);
	
	public void insertTraver(List<PageData> pd);
	
	public void deleteTraver(PageData pd);
	/**
	 * 
	 * 跟团旅游
	 * 
	 */
	public List<PageData> selectPcByPage(PageExtend page);
	
	
	/**
	 * 退款单部分
	 * @param pd
	 */
	public void insertRefundOrder(PageData pd);
	
	/**
	 * 退款订单列表
	 * 
	 */
	public List<PageData> selectTravelRefundByPage(Page page);
	
}

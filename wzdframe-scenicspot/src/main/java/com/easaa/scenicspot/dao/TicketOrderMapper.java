package com.easaa.scenicspot.dao;

import java.util.List;

import com.easaa.core.model.dao.EADao;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.entity.ticket.TicketOrder;

public interface TicketOrderMapper extends EADao{

	public List<TicketOrder> selectEntityByPage(Page page);
	
	public List<TicketOrder> selectEntityByMap(Page page);
	
	public void insertAllOrder(PageData pd);
	
	public PageData selectAllOrderById(String pd);
	
	
	public PageData selectByAllOrderNo(String orderSN);
	
	public void insertTraver(List<PageData> pd);
	
	public PageData selectByOrderNo(String pd);
	
	public void insertTicketCode(PageData pd);
	
	public void updateTicketCode(PageData pd);
	
	public List<PageData> selectTicketCodeByCondition(PageData pd);
	
	/**
	 * 退票时查询出行人信息
	 * @param pd
	 * @return
	 */
	public List<PageData> selectTicketCodeInfo(PageData pd);
	/**
	 * 退票订单
	 */
	public void insertRefund(PageData pd);
	
	/**
	 * 根据id查询退票订单
	 * 
	 */
	public PageData selectRefundById(Integer id);
	
	/**
	 * 分页查退票单
	 * 
	 */
	public List<PageData> selectRefundByPage(Page page);
	
	/**
	 * 根据退票单号查询
	 * @param pd
	 */
	public PageData selectRefundByOrderNo(String orderNo);
	
	
	
	public void updateRefund(PageData pd);
	
	/**
	 * 实名认证退票  需要退的票号
	 * @param refundTicketCode
	 */
	public void insertRefundTicketCode(PageData refundTicketCode);
	
	/**
	 * 查询退票的实名认证的票号
	 * 
	 */
	public List<PageData> selectRefundTicketCode(String refundNo);

	public void updateAllOrder(PageData totalOrder);
	
	
	
}

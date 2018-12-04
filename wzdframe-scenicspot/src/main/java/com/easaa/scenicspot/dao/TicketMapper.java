package com.easaa.scenicspot.dao;

import java.util.List;

import com.easaa.core.model.dao.EADao;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.entity.ticket.TicketListData;

public interface TicketMapper  extends EADao{

	
	public List<PageData> categorySelectByMap(PageData pd);
	
	public void categoryUpdate(PageData pd);
	
	public void categoryInsert(PageData pd);
	
	public void categoryDel(PageData pd);
	
	public TicketListData selectEntityTicket(PageData pd);
	
	public List<PageData> selectByIdsStr(PageData ticketIds);
}

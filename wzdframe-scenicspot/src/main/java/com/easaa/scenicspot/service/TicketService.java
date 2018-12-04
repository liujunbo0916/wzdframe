package com.easaa.scenicspot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easaa.core.model.dao.EADao;
import com.easaa.core.model.service.impl.EABaseService;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.dao.TicketMapper;
import com.easaa.scenicspot.entity.ticket.TicketListData;

@Service
public class TicketService  extends EABaseService{

	@Autowired
	private TicketMapper ticketMapper;
	@Override
	public EADao getDao() {
		return ticketMapper;
	}
	
	
	public List<PageData> categorySelectByMap(PageData pd){
		return ticketMapper.categorySelectByMap(pd);
	}
	
	public void  categoryUpdate(PageData pd){
		ticketMapper.categoryUpdate(pd);
	}
	
	public void categoryInsert(PageData pd){
		ticketMapper.categoryInsert(pd);
	}
	public void categoryDel(PageData pd){
		ticketMapper.categoryDel(pd);
	}
	public TicketListData selectEntityTicket(PageData pd){
		return ticketMapper.selectEntityTicket(pd);
	}
	
	public List<PageData> selectByIdsStr(PageData ticketIds){
	   return ticketMapper.selectByIdsStr(ticketIds);	
	}
	
}

package com.easaa.scenicspot.dao;

import java.util.List;

import com.easaa.core.model.dao.EADao;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.entity.PageExtend;

public interface ScenicLineMapper  extends EADao{

	public  List<PageData> selectScenicByLine(PageData pd);
	
	public void insertScenicLine(PageData pd);
	
	public List<PageData> selectScenicByLineScenic(PageData pd);
	
	public void deleteScenic(PageData pd);
	
	public List<PageData> selectCommentByCondition(PageData pd);
	
	public void insertComment(PageData pd);
	
	//某一景点评论数量
	public Integer countCommentByLine(PageData pd);
	//某一景点点赞数量
	public Integer countPraiseByLine(PageData pd);
	//查询是否点赞
	public PageData selectPraiseByUser(PageData pd);
	//点赞
	public void praise(PageData pd);
	
	
	//pc攻略列表
	public List<PageData> selectByPcPage(PageExtend page);
	
}

package com.easaa.scenicspot.dao;

import java.util.List;

import com.easaa.core.model.dao.EADao;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.entity.PageExtend;

public interface ScenicMapper extends EADao {
	public List<PageData> categorySelectByMap(PageData pd);

	public void categoryUpdate(PageData pd);

	public void categoryInsert(PageData pd);

	public void insertImg(PageData pd);

	public void deletecategory(Page page);
	
	/**
	 * 根据类别并排除某个攻略以外的景点
	 */
	public List<PageData> selectExcludeLine(PageData pd);
	
	/**
	 * 相册操作
	 */
	public List<PageData> selectImgByMap(PageData pd);
	
	/**
	 * 删除图片
	 * @param pd
	 */
	public void deleteImgsById(PageData pd);
	/**
	 * 点赞  评论
	 */
	public Integer selectCountPraise(PageData pd);
	
	/**
	 * 查看点赞列表  条件 （非必要）
	 * scenic_id  景点id
	 * 
	 * user_id  用户id
	 * @param pd
	 * @return
	 */
	public List<PageData> selectPraiseByMap(PageData pd);
	
	
	/**
	 * 查看评论列表 
	 *  条件 （非必要）
	 * scenic_show_status 1显示的评论  2 不显示的评论
	 * scenic_id  景点id
	 * 
	 * user_id  用户id
	 * limit 查询条数
	 * @param pd
	 * @return
	 */
	public List<PageData> selectCommentByMap(PageData pd);
	/**
	 * 统计评论数量
	 */
	public Integer selectCountComment(PageData pd);
	/**
	 * 添加评论
	 */
	public void insertComment(PageData pd);
	/**
	 * 添加点赞
	 */
	public void insertPraise(PageData pd);

	public List<PageData> explainList(PageData pd);
	
	/**
	 * ################收藏操作
	 */
	/**
	 * 添加收藏
	 */
	public void insertCollect(PageData pd);
	
	/**
	 * 统计收藏
	 */
	public Integer countCollect(PageData pd);
	
	/**
	 * 收藏列表
	 */
	public List<PageData> collectList(PageData pd);
	
	/**
	 * 用户轨迹
	 */
	public void userLatLng(PageData pd);
	
	/**
	 * 根据用户当前经纬度查询景点按距离升序排序
	 */
	public PageData selectScenicByLatLng(PageData pd);
	
	/**
	 * 涠洲足记
	 */
	public List<PageData> fotoPlace(PageData pd);
	
	/**
	 * 购票列表
	 */
	public List<PageData> selectScenicTicketByPage(Page pd);
	
	
	/**
	 * pc分页查询票务列表
	 * 
	 * 
	 */
	public List<PageData> selectPcTicketByPage(PageExtend page);
	
	/**
	 * pc分页查询票务列表
	 */
	public List<PageData> selectByPcPage(PageExtend page);
	
}

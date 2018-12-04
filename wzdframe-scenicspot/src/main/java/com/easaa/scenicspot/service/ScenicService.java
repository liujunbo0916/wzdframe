package com.easaa.scenicspot.service;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easaa.core.model.dao.EADao;
import com.easaa.core.model.service.impl.EABaseService;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EATools;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.dao.ScenicMapper;
import com.easaa.scenicspot.entity.PageExtend;
@Service
public class ScenicService  extends EABaseService{
	@Autowired
	private ScenicMapper scenicMapper;
	@Override
	public EADao getDao() {
		return scenicMapper;
	}
	
	/**
	 * ##################原子方法#############################
	 * @param pd
	 * @return
	 */
    public List<PageData> categorySelectByMap(PageData pd){
    	return scenicMapper.categorySelectByMap(pd);
    }
	public void categoryUpdate(PageData pd){
		scenicMapper.categoryUpdate(pd);
	}
	public void categoryInsert(PageData pd){
		scenicMapper.categoryInsert(pd);
	}
	public void deletecategory(PageData pd){
		Page page= new Page();
		page.setPd(pd);
		scenicMapper.deletecategory(page);
	}
	
	public List<PageData> selectImgByMap(PageData pd){
		return scenicMapper.selectImgByMap(pd);
	}
	
	public void insertImg(PageData pd){
		scenicMapper.insertImg(pd);
	}
	
	public List<PageData> commentList(PageData pd){
		return scenicMapper.selectCommentByMap(pd);
	}
	/**
	 * 根据类别并排除某个攻略以外的景点
	 */
	public List<PageData> selectExcludeLine(PageData pd){
		return scenicMapper.selectExcludeLine(pd);
	}
	
	
	/**
	 * 添加收藏
	 */
	public void insertCollect(PageData pd){
		
		
		scenicMapper.insertCollect(pd);
	}
	
	/**
	 * 统计收藏
	 */
	public Integer countCollect(PageData pd){
		return scenicMapper.countCollect(pd);
	}
	/**
	 * 涠洲足记
	 */
	public List<PageData> fotoPlace(PageData pd){
		return scenicMapper.fotoPlace(pd);
	}
	/**
	 * 收藏列表
	 */
	public List<PageData> collectList(PageData pd){
		return scenicMapper.collectList(pd);
	}
	/**
	 * #################业务方法########################
	 */
	//景点酒店等服务设施详情
	public  PageData scenicDetail(PageData pd){
		PageData detail = scenicMapper.selectById(EAString.stringToInt(pd.getAsString("id"), 0));
		if(StringUtils.isNotEmpty(detail.getAsString("scenic_voice_hour"))){
			
			int  hour = EAString.stringToInt(detail.getAsString("scenic_voice_hour"), 0);
			//将hour转成  分秒形式
			int sec = hour % 60;
			int min = hour / 60;
			String minStr = StringUtils.leftPad(min+"",2, "0");
			String secStr = StringUtils.leftPad(sec+"",2, "0");
			detail.put("voice_hour",  minStr+":"+secStr);
		}
		//如果有音频  将音频时间转成分钟秒的形式
		pd.put("detail", detail);
		String scenic_id = pd.getAsString("id");
		PageData imgPd = new PageData();
		imgPd.put("scenic_id", scenic_id);
		pd.put("IMGS", scenicMapper.selectImgByMap(imgPd));
		/**
		 * 查询点赞数量
		 */
		pd.put("praiseCount", scenicMapper.selectCountPraise(imgPd));
		/**
		 * 查询收藏数量
		 */
		pd.put("collectCount", scenicMapper.countCollect(imgPd));
		/**
		 * 查询是否点赞  是否收藏
		 */
		 if(StringUtils.isNotEmpty(pd.getAsString("user_id")) && !"-2".equals(pd.getAsString("user_id"))){
			 //如果用户id不等空   查询该用户是否点过赞
			 imgPd.put("user_id", pd.getAsString("user_id"));
			 List<PageData> praiseList = scenicMapper.selectPraiseByMap(imgPd);
			 if(praiseList != null && praiseList.size() > 0){
				 pd.put("isPraise", true);
			 }else{
				 pd.put("isPraise", false);
			 }
			 
			 //查询收藏
			 Integer countCollect = scenicMapper.countCollect(imgPd);
			 if(countCollect == null || countCollect == 0){
				 pd.put("isCollect", false);
			 }else{
				 pd.put("isCollect", true);
			 }
		 }else{
			 pd.put("isPraise", false);
			 pd.put("isCollect", false);
		 }
		/**
		 * 查询评论列表
		 */
		 imgPd.remove("user_id");
		 imgPd.put("limit", 6);
		 imgPd.put("scenic_show_status","1");
		 List<PageData> comments = scenicMapper.selectCommentByMap(imgPd);
		 for(PageData temp:comments){
			 temp.put("comment_time", EADate.getMMDD(temp.getAsString("scenic_comment_time")));
		 }
		 pd.put("comments",comments);
		 pd.put("commentCount", scenicMapper.selectCountComment(imgPd));
		return pd;
	}
	/**
	 * 讲解列表
	 * 
	 * 
	 */
	public  List<PageData> explainList(PageData pd){
		
		//如果金纬度没有获取到 默认设置成涠洲岛 中心位置
		double lat = StringUtils.isNotEmpty(pd.getAsString("lat")) ? Double.parseDouble(pd.getAsString("lat")):109.1237200735;
		double lng = StringUtils.isNotEmpty(pd.getAsString("lng")) ? Double.parseDouble(pd.getAsString("lng")):21.0423632498;
		List<PageData> scenicList =  scenicMapper.explainList(pd);
		for(PageData tpd :scenicList){
			Double distance = EATools.getDistance(lng,
					lat,tpd.getAsDouble("scenic_lng"), tpd.getAsDouble("scenic_lat"));
			if(distance > 100){ //转换成KM
				distance = distance/1000;
				tpd.put("isKm", true); //22.499278555211
			}else{
				tpd.put("isKm", false);
			}
			String distanceStr = distance+"";
			if(distanceStr.indexOf(".") != -1 && (distanceStr.substring(distanceStr.indexOf("."), distanceStr.length()).length() > 2)){
				//如果小数点后面数字多余2位为其做数字格式化操作
				distanceStr = new java.text.DecimalFormat("#.00").format(Double.parseDouble(distanceStr));
			}
			tpd.put("distance",distanceStr);
		}
	      Collections.sort(scenicList, new Comparator<PageData>(){  
	            public int compare(PageData o1, PageData o2) {  
	                if(o1.getAsDouble("distance") > o2.getAsDouble("distance")){  
	                    return 1;  
	                }  
	                if(o1.getAsDouble("distance") == o2.getAsDouble("distance")){  
	                    return 0;  
	                }  
	                return -1;  
	            }  
	        });   
		return scenicList;
	}
	/**
	 * 添加评论
	 * @param pd
	 */
	public void addComment(PageData pd) {
		pd.put("scenic_comment_time", EADate.getCurrentTime());
		pd.put("scenic_id", pd.getAsString("id"));
		pd.put("scenic_comment_content", pd.getAsString("comment_content"));
		pd.put("show_comment_time", EADate.getMMDD(pd.getAsString("scenic_comment_time")));
		scenicMapper.insertComment(pd);
	}

	public void praise(PageData pd) {
		pd.put("scenic_id", pd.getAsString("id"));
		scenicMapper.insertPraise(pd);
	}

	public void deleteImgsById(PageData pd) {
		scenicMapper.deleteImgsById(pd);
	}

	/**
	 * 根据前端的经纬度  来查询在其范围内的景点    （如果在多个景点范围内计算其离景点中心点的距离排序显示距离最小的）
	 * 参数  lat  lng
	 * @param pd
	 * @return
	 */
	public void findScenicByLngLat(PageData pd) {
		//根据距离减去半径  排序取最小值  取一条数据
		/*PageData limitShortScenic = scenicMapper.selectScenicByLatLng(pd);
		
		if(limitShortScenic != null && limitShortScenic.getAsInteger("distance") <= 0){*/
			//说明在圈内
			/**
			 * 插入用户轨迹
			 */
			PageData userLatLng = new PageData();
			userLatLng.put("user_id", pd.getAsString("user_id"));
			userLatLng.put("lat", pd.getAsString("lat"));
			userLatLng.put("lng", pd.getAsString("lng"));
			userLatLng.put("create_time", EADate.getCurrentTime());
			userLatLng.put("scenic_id", pd.getAsString("scenic_id"));
			scenicMapper.userLatLng(userLatLng);
		/*	return limitShortScenic;
		}
		return null;*/
	}
	
	
	/**
	 * 分页查询景区购票信息
	 */
	public List<PageData> selectScenicTicketByPage(Page page){
		PageData param = page.getPd();
		double lat = StringUtils.isNotEmpty(param.getAsString("currentLat")) ? Double.parseDouble(param.getAsString("currentLat")):109.1237200735;
		double lng = StringUtils.isNotEmpty(param.getAsString("currentLng")) ? Double.parseDouble(param.getAsString("currentLng")):21.0423632498;
		List<PageData> waitCal =  scenicMapper.selectScenicTicketByPage(page);
		for(PageData tpd :waitCal){
			try{
				Double distance = EATools.getDistance(lng,
						lat,tpd.getAsDouble("scenic_lng"), tpd.getAsDouble("scenic_lat"));
				if(distance > 100){ //转换成KM
					distance = distance/1000;
					tpd.put("isKm", true); //22.499278555211
				}else{
					tpd.put("isKm", false);
				}
				String distanceStr = distance+"";
				if(distanceStr.indexOf(".") != -1 && (distanceStr.substring(distanceStr.indexOf("."), distanceStr.length()).length() > 2)){
					//如果小数点后面数字多余2位为其做数字格式化操作
					distanceStr = new java.text.DecimalFormat("#.00").format(Double.parseDouble(distanceStr));
				}
				tpd.put("distance",distanceStr);
			}catch(Exception e){
				tpd.put("distance",0);
			}
		}
		return waitCal;
	}
	
	
	/**
	 * pc端票务列表
	 * 
	 * 
	 */
	public List<PageData> selectPcTicketByPage(PageExtend page){
		return scenicMapper.selectPcTicketByPage(page);
	}
	
	/**
	 * pc端景点列表
	 * 
	 * 
	 * 
	 */
	public List<PageData> selectByPcPage(PageExtend page){
		return scenicMapper.selectByPcPage(page);
	}
	
	
	
}

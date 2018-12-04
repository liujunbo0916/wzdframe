package com.easaa.scenicspot.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.easaa.core.model.dao.EADao;
import com.easaa.core.model.service.impl.EABaseService;
import com.easaa.core.util.EADate;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.scenicspot.dao.ScenicLineMapper;
import com.easaa.scenicspot.entity.PageExtend;

/**
 * 1攻略server
 * @author liujunbo
 *
 */
@Service
public class ScenicLineService  extends EABaseService{

	@Autowired
	private ScenicLineMapper scenicLineMapper;
	@Override
	public EADao getDao() {
		return scenicLineMapper;
	}
/**
 * ################原子方法##############################
 */
	public List<PageData> selectScenicByLine(PageData pd){
	   return scenicLineMapper.selectScenicByLine(pd);	
	}
	public void insertScenicLine(PageData pd){
		scenicLineMapper.insertScenicLine(pd);
		
	}
	public void deleteScenic(PageData pd){
		scenicLineMapper.deleteScenic(pd);
	}
	//点赞
	public void addPraise(PageData pd) {
		scenicLineMapper.praise(pd);
	}
	
	public List<PageData> commentList(PageData pd){
		List<PageData> comments =  scenicLineMapper.selectCommentByCondition(pd);
		for(PageData tpd :comments){
			tpd.put("comment_time", EADate.getMMDD(tpd.getAsString("create_time")));
			tpd.put("scenic_comment_content", tpd.getAsString("content"));
		}
		return comments;
	}
    //查询是否点赞
	public boolean selectPraiseByUser(PageData pd){
		PageData praisePd   = scenicLineMapper.selectPraiseByUser(pd);
		if(praisePd == null){
			return false;
		}
		return true;
	}
	public void insertComment(PageData pd){
		scenicLineMapper.insertComment(pd);
	}
	/**
	 * #######################业务方法###########################
	 * 
	 * @param data
	 */
	/**
	 * 查询前几条评论   并且返回评论数量和点赞数量
	 * @param pd
	 * @return
	 */
	public PageData selectCommentByCondition(PageData pd){
		PageData result = new PageData();
		List<PageData> comments =  scenicLineMapper.selectCommentByCondition(pd);
		for(PageData tpd :comments){
			tpd.put("create_time", EADate.getMMDD(tpd.getAsString("create_time")));
		}
		result.put("comments", comments);
		result.put("commentCount", scenicLineMapper.countCommentByLine(pd));
		result.put("praiseCount", scenicLineMapper.countPraiseByLine(pd));
		return result;
	}
	public void editCustom(PageData data) {
		//攻略景点映射
		String scenicLineStr = data.getAsString("scenicLine");
		String[] scenicLineItem  = scenicLineStr.split("\\|");
		PageData tempItem = new PageData();
		for(String s : scenicLineItem){
			String[] smallItem = s.split(",");
			tempItem.put("line_scenic_id", smallItem[0]);
			tempItem.put("line_scenic_desc", smallItem[1]);
			tempItem.put("line_id", data.getAsString("id"));
			//检测是否已经存在
			List<PageData> maps = scenicLineMapper.selectScenicByLineScenic(tempItem);
			if(maps == null || maps.size() == 0){
				scenicLineMapper.insertScenicLine(tempItem);
			}
		}
		scenicLineMapper.update(data);
	}
	public void insertCustom(PageData data) {
		data.put("create_time", EADate.getCurrentTime());
		scenicLineMapper.insert(data);
		String scenicLineStr = data.getAsString("scenicLine");
		String[] scenicLineItem  = scenicLineStr.split("\\|");
		PageData tempItem = new PageData();
		for(String s : scenicLineItem){
			String[] smallItem = s.split(",");
			tempItem.put("line_scenic_id", smallItem[0]);
			tempItem.put("line_scenic_desc", smallItem[1]);
			tempItem.put("line_id", data.getAsString("line_id"));
			scenicLineMapper.insertScenicLine(tempItem);
		}
	}
	/**
	 * 参数
	 * id 攻略id
	 * @param pd
	 */
	public void deleteLine(PageData pd) {
		Page page = new Page();
		page.setPd(pd);
		PageData mapPd = new PageData();
		mapPd.put("line_id", pd.getAsString("id"));
		scenicLineMapper.deleteScenic(mapPd);
		scenicLineMapper.delete(page);
	}
	/**
	 * 分页查询pc端攻略列表
	 */
	public List<PageData> selectByPcPage(PageExtend page){
		return scenicLineMapper.selectByPcPage(page);
	}
}

package com.easaa.controller.travel;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.core.util.EATools;
import com.easaa.core.util.FtpUtil;
import com.easaa.core.util.Tools;
import com.easaa.entity.ImageFormat;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;
import com.easaa.goods.entity.GoodsAttrList;
import com.easaa.goods.entity.StockList;
import com.easaa.log.annotation.MethodLog;
import com.easaa.scenicspot.service.HotelService;
import com.easaa.upm.upm.Jurisdiction;

/**
 * 酒店控制器
 * 
 * @author ryy
 */
@Controller
@RequestMapping("/sys/hotel/")
public class HotelController extends BaseController {

	@Autowired
	private HotelService hotelService;

	@RequestMapping(value = "listPage")
	public ModelAndView listPage(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		page.setPd(pd);
		List<PageData> hotelList = hotelService.selectByListPage(page); // 列出Content列表
		mv.addObject("dataModel", hotelList);
		mv.addObject("pd", pd);
		mv.setViewName("hotel/hotellist");
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	@RequestMapping(value = "editPage")
	public ModelAndView editPage() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		PageData data = hotelService.getById(EAString.stringToInt(pd.getAsString("hotel_id"), 0));
		//获取酒店类型
		List<PageData> hoteltype=hotelService.selectHotelTypeByMap(pd);
		mv.addObject("dataModel", data);
		mv.addObject("typeModel", hoteltype);
		mv.setViewName("hotel/hoteledit");
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}
	@MethodLog(remark="添加酒店信息")
	@RequestMapping(value = "savePage", method = RequestMethod.POST)
	public ModelAndView savePage(@RequestParam(required=false,value = "hotel_img") MultipartFile file, GoodsAttrList goodsAttr,
			HttpServletRequest request) {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		PageData data = getPageData(multipartRequest);
		ModelAndView mv = this.getModelAndView();
		try {
			if (StringUtils.isEmpty(data.getAsString("hotel_desc"))) {
				data.put("hotel_desc", data.getAsString("editorValue"));
			}
			if (file != null && !file.isEmpty() && file.getSize() > 0) {
				String savePath = FtpUtil.upload(file, "mallframe", "tuyun");
				data.put("hotel_img", savePath);
				try {
					// 保证缩放的图片的名字和原图片名字一样
					String fileName = savePath.substring(savePath.lastIndexOf("/"), savePath.lastIndexOf(".") + 1);
					ImageFormat[] imageFormats = new ImageFormat[] { new ImageFormat(750, 601, "detail", fileName),
							new ImageFormat(226, 226, "list", fileName), new ImageFormat(328, 328, "listbig", fileName),
							new ImageFormat(238, 238, "listmiddle", fileName),
							new ImageFormat(175, 175, "listsmall", fileName) }; // 网站图片规格
					EATools.dealWithImgs(file, imageFormats);
					for (ImageFormat tif : imageFormats) {
						FtpUtil.upload(tif, "mallframe", "tuyun");
						if (tif.getFile().exists()) {
							tif.getFile().delete();
						}
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			Tools.replaceEmpty(data);
			data.put("create_time", EADate.getCurrentTime());
			if (data.getAsInt("hotel_id") > 0) { // 如果主键hotel_id值大于0,说明是编辑
				hotelService.edit(data);
			} else {
				hotelService.create(data);
			}
			mv.setViewName("redirect:/sys/hotel/listPage");
		} catch (Exception e) {
			e.printStackTrace();
			if (e.getMessage().equals("DV0001")) {
				mv.setViewName("common/error2");
			} else {
				mv.setViewName("common/error");
			}
		}
		return mv;
	}

	@MethodLog(remark="删除酒店信息")
	@RequestMapping(value = "delPage")
	public void setStockAction(HttpServletResponse response){
		try {
			PageData pd= getPageData();
			if(pd.getAsString("grouptour_id") != null && pd.getAsString("grouptour_id") != ""){
				hotelService.delete(pd);
				super.outJson(response, REQUEST_SUCCESS, "操作成功", null);
			}else{
				super.outJson(response, REQUEST_FAILS, "操作失败", null);
			}
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "操作失败", e.getMessage());
		}
	}
	
	@RequestMapping(value = "typelistPage")
	public ModelAndView typelistPage(Page page) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		page.setPd(pd);
		List<PageData> hotelList = hotelService.selectHotelTypeByPage(page); // 列出Content列表
		mv.addObject("dataModel", hotelList);
		mv.addObject("pd", pd);
		mv.setViewName("hotel/hoteltypelist");
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	@RequestMapping(value = "typeeditPage")
	public ModelAndView typeeditPage() {
		ModelAndView mv = this.getModelAndView();
		PageData pd = getPageData();
		PageData data = hotelService.selectHotelTypeById(EAString.stringToInt(pd.getAsString("hotel_type_id"), 0));
		mv.addObject("dataModel", data);
		mv.setViewName("hotel/hoteltypeedit");
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}
    
	@MethodLog(remark="酒店类型添加")
	@RequestMapping(value = "typesavePage")
	public ModelAndView typesavePage(HttpServletResponse response) throws Exception {
		PageData pd = this.getPageData();
		ModelAndView mv = this.getModelAndView();
		try {
			pd.put("create_time", EADate.getCurrentTime());
			if (pd.getAsInt("hotel_type_id") > 0) { // 如果主键hotel_id值大于0,说明是编辑
				hotelService.updateHotelType(pd);
			} else {
				hotelService.insertHotelType(pd);
			}
			mv.setViewName("redirect:/sys/hotel/typelistPage");
		} catch (Exception e) {
			e.printStackTrace();
			mv.setViewName("common/error");
		}
		return mv;
	}
	@MethodLog(remark="酒店类型删除")
	@RequestMapping(value = "typedelPage")
	public void typedelPage(HttpServletResponse response) throws Exception {
		PageData pd = this.getPageData();
		try {
			if (pd.getAsInt("hotel_type_id") > 0) { // 如果主键hotel_id值大于0,说明是编辑
				hotelService.deleteHotelType(pd);
				super.outJson(response, REQUEST_SUCCESS, "删除成功", null);
			} else {
				super.outJson(response, REQUEST_FAILS, "删除失败", null);
			}
		} catch (Exception e) {
			e.printStackTrace();
			super.outJson(response, REQUEST_FAILS, "程序异常", null);
		}
	}
}

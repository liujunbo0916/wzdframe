package com.easaa.controller.upm;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.bank.service.BankService;
import com.easaa.controller.comm.BaseController;
import com.easaa.core.util.EAString;
import com.easaa.core.util.FtpUtil;
import com.easaa.entity.Page;
import com.easaa.entity.PageData;

@RequestMapping("/sys/bank/")
@Controller
public class BankController  extends BaseController{

	@Autowired
	private BankService brandService;
	
	@RequestMapping("listPage")
	public ModelAndView listPage(Page page){
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		page.setPd(pd);
		mv.addObject("bankList", brandService.getByPage(page));
		mv.addObject("pd", pd);
		mv.setViewName("bank/list");
		return mv;
	}
	
	@RequestMapping("editPage")
	public ModelAndView editPage(){
		ModelAndView mv = this.getModelAndView();
		mv.addObject("dataModel", brandService.getById(EAString.stringToInt(this.getPageData().getAsString("bank_id"), 0)));
		mv.setViewName("bank/edit");
		return mv;
	}
	@RequestMapping("editAction")
	public ModelAndView editAction(@RequestParam(value="bank_logo") MultipartFile file, HttpServletRequest request){
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		PageData pd = getPageData(multipartRequest);
		ModelAndView mv = this.getModelAndView();
		String savePath = null;
		try {
			savePath = FtpUtil.upload(file, "mallframe", "bank");
		} catch (Exception e) {
			e.printStackTrace();
		}
		pd.put("bank_logo", savePath);
		if(EAString.isNullStr(pd.getAsString("bank_id"))){
			PageData selectPd = new PageData();
			selectPd.put("bank_name", pd.getAsString("bank_name"));
			
			List<PageData> banks = brandService.getByMap(selectPd);
			if(banks == null || banks.size() == 0){
				brandService.create(pd);
			}
		}else{
			brandService.edit(pd);
		}
		if(!EAString.isNullStr(savePath)){
			PageData binPd = new PageData();
			binPd.put("bank_logo",savePath);
			binPd.put("bank_name",pd.getAsString("bank_name"));
			brandService.updateBankBin(binPd);
		}
		mv.setViewName("redirect:/sys/bank/listPage");
		return mv;
	}
	
	@RequestMapping("del")
	public void del(HttpServletResponse response){
		PageData pd = this.getPageData();
		try{
			brandService.delete(pd);
			super.outJson(response, this.REQUEST_SUCCESS, "删除成功", null);
		}catch(Exception e){
			e.printStackTrace();super.outJson(response, this.REQUEST_FAILS, "删除失败", null);
		}
	}
	
}

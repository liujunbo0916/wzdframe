package com.easaa.loader;

import java.util.List;

import com.easaa.entity.PageData;
import com.easaa.upm.service.SeoService;

public class SEOLoader {
	
	private SeoService seoService;
	
	private static List<PageData> seoCode;
	
	public SEOLoader(SeoService seoService){
		this.seoService = seoService;
		if(seoCode == null){
			try {
				seoCode = seoService.getByMap(new PageData());
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	/**
	 * 查询编码对应的值
	 * @param bianma
	 * @return
	 * @throws Exception
	 */
	public PageData getSeoCode(String seo_code) throws Exception {
		if(seoCode == null){
			seoCode = seoService.getByMap(new PageData());
		}
		seo_code = seo_code == null ?"":seo_code;
		for(PageData pd : seoCode){
			if(seo_code.equals(pd.getString("seo_code"))){
				return pd;
			}
		}
		return null;
	}
	public void clear() {
		seoCode = null;
	}
}

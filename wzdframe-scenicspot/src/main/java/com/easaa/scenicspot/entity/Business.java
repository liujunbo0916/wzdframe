package com.easaa.scenicspot.entity;

import java.io.Serializable;

/**
 * 店铺对象
 * @author liujunbo
 *
 */
public class Business  implements Serializable{
	
	
	private Integer bsId;
	
	/**
	 * 店铺名称
	 */
	private String bsName;
	
	/**
	 * 店铺等级
	 */
	private Integer bsLevel;
	
	private Integer bsGradeId;
	
	private Integer categoryId;
	
	private String companyName;

	/**
	 * 更多信息以后添加
	 */
	
	
	public Integer getBsId() {
		return bsId;
	}

	public void setBsId(Integer bsId) {
		this.bsId = bsId;
	}

	public String getBsName() {
		return bsName;
	}

	public void setBsName(String bsName) {
		this.bsName = bsName;
	}

	public Integer getBsLevel() {
		return bsLevel;
	}

	public void setBsLevel(Integer bsLevel) {
		this.bsLevel = bsLevel;
	}

	public Integer getBsGradeId() {
		return bsGradeId;
	}

	public void setBsGradeId(Integer bsGradeId) {
		this.bsGradeId = bsGradeId;
	}

	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
}

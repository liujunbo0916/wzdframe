package com.easaa.controller.comm;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.easaa.code.service.CodeService;
import com.easaa.core.util.EAUtil;
import com.easaa.entity.PageData;
import com.easaa.plugin.code.ControllerCreate;
import com.easaa.plugin.code.DaoCreate;
import com.easaa.plugin.code.MapperCreate;
import com.easaa.plugin.code.ServiceCreate;
import com.easaa.plugin.code.TableModel;

@Controller
@RequestMapping("/code/")
public class CodeController extends BaseController {
	@Autowired
	private CodeService codeService;
	@RequestMapping(value="/codePage")
	public ModelAndView codePage()throws Exception{
		ModelAndView mv = this.getModelAndView();
		String tableName=this.getRequest().getParameter("tableName");
		String moduleName=this.getRequest().getParameter("moduleName");
		if(EAUtil.isNotEmpty(tableName)){
			PageData pd=codeService.getCreateSql(tableName);
			String str=pd.getAsString("Create Table");
			TableModel table = new TableModel(str);
			table.setTableName(tableName);
			table.setModuleName(moduleName);
			MapperCreate mc=new MapperCreate(table);
			DaoCreate dao=new DaoCreate(table);
			ServiceCreate ser=new ServiceCreate(table);
			ControllerCreate ctr=new ControllerCreate(table);
			mv.addObject("sql", mc.doCreate());
			mv.addObject("dao", dao.doCreate());
			mv.addObject("service", ser.doCreate());
			mv.addObject("ctr", ctr.doCreate());
		}
		mv.addObject("tableName",tableName);
		mv.addObject("moduleName",moduleName);
		mv.setViewName("code/codePage");
		return mv;
	}
	
	@RequestMapping(value="/getCode")
	public void getCode(String tableName)throws Exception{
		
		
	}
	
	
}

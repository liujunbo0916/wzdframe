package wx.easaa.controller.comm;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.easaa.common.service.RegionService;
import com.easaa.core.util.EADate;
import com.easaa.core.util.EAString;
import com.easaa.entity.PageData;
import com.easaa.user.service.UserService;

@Controller
@RequestMapping("/api/")
public class CommonController extends BaseController {
	
	PageData result = new PageData();
	
	@Autowired
	private RegionService regionService;
	@Autowired
	private UserService userService;
	/**
	 * 读取全国行政区划信息
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/getArea")
	public void codePage(HttpServletResponse response)throws Exception{
		String id=getRequest().getParameter("id");//id即上级ID
		List<PageData>  reagionlist=regionService.getListByParentId(EAString.stringToInt(id, 1));
		this.outJson(REQUEST_SUCCESS, "", reagionlist,response);
	}
	/**
	 * 查询省市区
	 */
	@RequestMapping(value="getPCAData")
	public void getPCAData(HttpServletResponse response){
		//查询省
		List<PageData> province =regionService.selectByProvince(new PageData());
		PageData cityPd = new PageData();
		PageData distPd = new PageData();
		PageData pdParam = new PageData();
		PageData distPdParam = new PageData();
		for(PageData tp : province){
			pdParam.put("parent_id", tp.getAsString("value"));
			List<PageData> citys = regionService.selectByCity(pdParam);
			for(PageData city : citys){
				distPdParam.put("parent_id", tp.getAsString("value"));
				distPd.put(city.getAsString("region_id"), regionService.selectByCity(distPdParam));
			}
			cityPd.put(tp.getAsString("region_id"), citys);
		}
		result.put("province", province);
		result.put("dist", distPdParam);
		result.put("city", cityPd);
		this.outJson(REQUEST_SUCCESS, "查询成功", result,response);
	}
	/**
	 * 发送短信
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/sendSMS")
	public void sendSMS(HttpServletResponse response)throws Exception{
		String id=getRequest().getParameter("id");//id即上级ID
		List<PageData>  reagionlist=regionService.getListByParentId(EAString.stringToInt(id, 1));
		this.outJson(REQUEST_SUCCESS, "", reagionlist,response);
	}
	
	/**
	 * APP初始化时调用
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/appInit")
	public void appInit(HttpServletResponse response)throws Exception{
		
	}
	@RequestMapping(value="/testFun")
	public void testFun(HttpServletResponse response)throws Exception{
		PageData user = new PageData();
		user.put("phone", "1");
		user.put("user_name", "userName");
		user.put("nick_name", "userName");//注册时使用用户名作为别名
		user.put("password", "password");
		user.put("register_channel", 0);
		user.put("register_time", EADate.getCurrentTime());
		user.put("user_money", 0);
		user.put("user_points", 0);
		user.put("parent_id", 0);
		user.put("is_validated", 0);
		user.put("status", 1);
		user.put("session_id","did");
		userService.create(user);
		System.out.println(user);
	}
	
	/**
	 * APP所有图片前缀
	 * @param request
	 * @param response
	 */
	@RequestMapping("/serverUrl")
	public void serverUrl(HttpServletRequest request,HttpServletResponse response){
		super.outJson(REQUEST_SUCCESS, "查询成功", request.getSession().getServletContext().getAttribute("SETTINGPD"), response);
	}
	
}

package jp.co.netmile.cabbageroll.controller.backend;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import jp.co.netmile.cabbageroll.dto.Operator;
import jp.co.netmile.cabbageroll.service.BackendService;
import jp.co.netmile.cabbageroll.service.EnqService;
import jp.co.netmile.cabbageroll.service.FacebookService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/backend")
public class BackendController {
	
	@Autowired
	private EnqService enqService;
	
	@Autowired
	private FacebookService facebookService;
	
	@Autowired
	private BackendService backendService;
	
	@RequestMapping(value = "/welcome")
	public ModelAndView welcome() {
		
		ModelAndView modelAndView = new ModelAndView("backend/welcome");
		return modelAndView;
		
	}
	
	@RequestMapping(value = "/")
	public ModelAndView top() {
		
		return userList();
	}
	
	@RequestMapping(value = "/userList")
	public ModelAndView userList() {
		ModelAndView modelAndView = new ModelAndView("backend/users");
		modelAndView.addObject("users", backendService.getUsers());
		return modelAndView;
	}
	
	@RequestMapping(value = "/userDetail")
	public ModelAndView userDetail(@RequestParam("pid") String pid) {
		
		ModelAndView modelAndView = new ModelAndView("backend/userDetail");
		modelAndView.addObject("user", backendService.getUserProfile(pid));
		return modelAndView;
		
	}
	
	@RequestMapping(value = "/update")
	public ModelAndView updateUserInfo(@RequestParam("uid") String uid) {
		facebookService.saveUserInfo(uid);
		return top();
	}
	
	@RequestMapping(value = "login")
	public ModelAndView login(String password, HttpServletRequest request) {
		
		if(password.equals("netmile")) {
			Operator op = new Operator();
			op.setLoginTime(System.currentTimeMillis());
			HttpSession session = request.getSession();
			session.setAttribute(Operator.SESSION_KEY_OPERATOR, op);
			return top();
		}
		
		return welcome();
	}
	
	@RequestMapping(value = "/reload") 
	public void reload() {
		enqService.initPool();
	}
	
}

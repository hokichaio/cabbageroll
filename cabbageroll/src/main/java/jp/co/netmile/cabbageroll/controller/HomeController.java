package jp.co.netmile.cabbageroll.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jp.co.netmile.cabbageroll.dto.Enq;
import jp.co.netmile.cabbageroll.service.EnqService;
import jp.co.netmile.cabbageroll.social.SecurityContext;
import jp.co.netmile.cabbageroll.util.UserCookieGenerator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	
	@Autowired
	private EnqService enqService;
	
	@RequestMapping(value = "/signout")
	public ModelAndView signout(HttpServletRequest request, HttpServletResponse response) {
		UserCookieGenerator.removeCookie(response);
		return new ModelAndView("redirect:/");
	}
	
	@RequestMapping(value = "/")
	public ModelAndView home(HttpServletRequest request) {
		
		List<Enq> enqs;
		
		if(!SecurityContext.userSignedIn(request)) {
			enqs = enqService.getEnqsRandomly();
		} else {
			enqs = enqService.getAvailableEnqs(SecurityContext.getPid(request));
		}
		
		if(enqs==null || enqs.isEmpty()) {
			return new ModelAndView("main/noEnq");
		}
		
		ModelAndView modelAndView = new ModelAndView("main/top");
		modelAndView.addObject("enqs", enqs);
		return modelAndView;
	}
	
	@RequestMapping(value = "/create_init")
	public ModelAndView createInit(Enq enq, HttpServletRequest request) {
		
		if(!SecurityContext.userSignedIn(request)) {
			return home(request);
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("enq", enq);
		modelAndView.setViewName("main/create");
		return modelAndView;
	}
	
	@RequestMapping(value = "/create")
	public ModelAndView create(Enq enq, HttpServletRequest request) throws IllegalStateException, IOException {
		
		if(!SecurityContext.userSignedIn(request)) {
			return home(request);
		}
		enq.setOwner(SecurityContext.getPid(request));
		enqService.createEnq(enq);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("enqId", enq.getId());
		modelAndView.addObject("postWallFlg", true);
		modelAndView.setViewName("main/enq");
		return modelAndView;
	}
	
	@RequestMapping(value = "/goto") 
	public ModelAndView gotoEnq(@RequestParam("enqId") String enqId) {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("enqId", enqId);
		modelAndView.setViewName("main/enq");
		return modelAndView;
	}
	
	@RequestMapping(value = "/mypage") 
	public ModelAndView myPage(HttpServletRequest request) {
		if(!SecurityContext.userSignedIn(request)) {
			return home(request);
		}
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("enqs", enqService.getHistory(SecurityContext.getPid(request)));
		modelAndView.addObject("myenqs", enqService.getMyEnq(SecurityContext.getPid(request)));
		modelAndView.setViewName("main/mypage");
		return modelAndView;
	}
	
}

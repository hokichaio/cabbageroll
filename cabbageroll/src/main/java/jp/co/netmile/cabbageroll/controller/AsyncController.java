package jp.co.netmile.cabbageroll.controller;

import java.util.List;

import jp.co.netmile.cabbageroll.dto.AnswerForm;
import jp.co.netmile.cabbageroll.dto.Enq;
import jp.co.netmile.cabbageroll.dto.Result;
import jp.co.netmile.cabbageroll.service.EnqService;
import jp.co.netmile.cabbageroll.service.FacebookService;
import jp.co.netmile.cabbageroll.social.SecurityContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/async")
public class AsyncController {
	
	@Autowired
	private EnqService enqService;
	
	@Autowired
	private FacebookService facebookService;
	
	@RequestMapping(value = "/me") 
	public ModelAndView myPage() {
		if(!SecurityContext.userSignedIn()) {
			return null;
		}
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("enqs", enqService.getHistory(SecurityContext.getCurrentUser().getpId()));
		modelAndView.setViewName("async/me");
		return modelAndView;
	}
}

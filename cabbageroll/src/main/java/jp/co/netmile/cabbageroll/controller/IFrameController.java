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

@RequestMapping(value = "/iframe")
@Controller
public class IFrameController {
	
	@Autowired
	private EnqService enqService;
	
	@Autowired
	private FacebookService facebookService;
	
	@RequestMapping(value = "/")
	public ModelAndView home() {
		
		Enq enq;
		
		if(!SecurityContext.userSignedIn()) {
			enq = enqService.getEnqRandomly();
		} else {
			enq = enqService.getAvailableEnq(SecurityContext.getCurrentUser().getpId());
		}
		
		if(enq==null) {
			return new ModelAndView("iframe/noEnq");
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("enq", enq);
		modelAndView.addObject("qNo", 0);
		modelAndView.addObject("answerForm", new AnswerForm());
		modelAndView.setViewName("iframe/top");
		return modelAndView;
	}
	
	@RequestMapping(value = "/answer")
	public ModelAndView answer(AnswerForm answerForm) {
		
		if(!SecurityContext.userSignedIn()) {
			return new ModelAndView("/signin");
		}
		
		enqService.registAnswer(answerForm, SecurityContext.getCurrentUser().getpId());
		
		return gotoEnq(answerForm.getEnqId());
	}
	
	
	@RequestMapping(value = "/goto") 
	public ModelAndView gotoEnq(@RequestParam("enqId") String enqId) {
		
		if(!SecurityContext.userSignedIn()) {
			return home();
		}
		
		List<String> friends = facebookService.getFriends(SecurityContext.getCurrentUser().getpId());
		Result result = enqService.getResult(enqId, SecurityContext.getCurrentUser().getpId(), friends);
		Enq enq = enqService.getEnqById(enqId);
		if(result == null) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("enq", enq);
			modelAndView.addObject("qNo", 0);
			modelAndView.addObject("answerForm", new AnswerForm());
			modelAndView.setViewName("iframe/top");
			return modelAndView;
		} else {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("result", result);
			modelAndView.addObject("enq", enq);
			modelAndView.setViewName("iframe/result");
			return modelAndView;
		}
		
	}
	
	
}
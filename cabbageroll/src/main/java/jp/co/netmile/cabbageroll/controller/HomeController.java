package jp.co.netmile.cabbageroll.controller;

import javax.inject.Inject;

import jp.co.netmile.cabbageroll.dto.AnswerForm;
import jp.co.netmile.cabbageroll.dto.Enq;
import jp.co.netmile.cabbageroll.service.EnqService;
import jp.co.netmile.cabbageroll.social.SecurityContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {
	
	private final Facebook facebook;
	
	@Autowired
	private EnqService enqService;
	
	@Inject
	public HomeController(Facebook facebook) {
		this.facebook = facebook;
	}
	
	@RequestMapping(value = "/")
	public ModelAndView home() {
		
		Enq enq = enqService.getEnqRandomly();
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("enq", enq);
		modelAndView.addObject("qNo", 0);
		modelAndView.addObject("answerForm", new AnswerForm());
		modelAndView.setViewName("main/top");
		return modelAndView;
	}
	
	@RequestMapping(value = "/answer")
	public ModelAndView answer(AnswerForm answerForm) {
		
		if(!SecurityContext.userSignedIn()) {
			return home();
		}
		
		enqService.registAnswer(answerForm, SecurityContext.getCurrentUser().getpId());
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("enq", enqService.getAvailableEnqById(answerForm.getEnqId()));
		modelAndView.setViewName("main/result");
		return modelAndView;
	}
}

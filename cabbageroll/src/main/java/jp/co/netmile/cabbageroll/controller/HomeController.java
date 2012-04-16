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
public class HomeController {
	
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
			//TODO 答えられるアンケートがないと表示
		}
		
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
			return new ModelAndView("/signin");
			//TODO need redirect...
		}
		
		enqService.registAnswer(answerForm, SecurityContext.getCurrentUser().getpId());
		
		return result(answerForm.getEnqId());
	}
	
	@RequestMapping(value = "/result")
	public ModelAndView result(@RequestParam("enqId") String enqId) {
		
		if(!SecurityContext.userSignedIn()) {
			return home();
		}
		
		List<String> friends = facebookService.getFriends(SecurityContext.getCurrentUser().getpId());
		Result result = enqService.getResult(enqId, SecurityContext.getCurrentUser().getpId(), friends);
		
		if(result == null) {
			return home();
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("result", result);
		modelAndView.setViewName("main/result");
		return modelAndView;
	}
	
	
	@RequestMapping(value = "/create_init")
	public ModelAndView createInit(Enq enq) {
		
		if(!SecurityContext.userSignedIn()) {
			return home();
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("enq", enq);
		modelAndView.setViewName("main/create");
		return modelAndView;
	}
	
	@RequestMapping(value = "/create")
	public ModelAndView create(Enq enq) {
		
		if(!SecurityContext.userSignedIn()) {
			return home();
		}
		enq.setOwner(SecurityContext.getCurrentUser().getpId());
		enqService.createEnq(enq);
		
		return gotoEnq(enq.getId());
	}
	
	@RequestMapping(value = "/goto") 
	public ModelAndView gotoEnq(@RequestParam("enqId") String enqId) {
		
		if(!SecurityContext.userSignedIn()) {
			return home();
		}
		
		List<String> friends = facebookService.getFriends(SecurityContext.getCurrentUser().getpId());
		Result result = enqService.getResult(enqId, SecurityContext.getCurrentUser().getpId(), friends);
		
		if(result == null) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("enq", enqService.getEnqById(enqId));
			modelAndView.addObject("qNo", 0);
			modelAndView.addObject("answerForm", new AnswerForm());
			modelAndView.setViewName("main/top");
			return modelAndView;
		} else {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("result", result);
			modelAndView.setViewName("main/result");
			return modelAndView;
		}
		
	}
	
	@RequestMapping(value = "/mypage") 
	public ModelAndView myPage() {
		if(!SecurityContext.userSignedIn()) {
			return home();
		}
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("enqs", enqService.getHistory(SecurityContext.getCurrentUser().getpId()));
		modelAndView.setViewName("main/mypage");
		return modelAndView;
	}
}

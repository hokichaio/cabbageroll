package jp.co.netmile.cabbageroll.controller;

import java.io.IOException;
import java.util.List;

import jp.co.netmile.cabbageroll.dto.AnswerForm;
import jp.co.netmile.cabbageroll.dto.Enq;
import jp.co.netmile.cabbageroll.service.EnqService;
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
	
	@RequestMapping(value = "/")
	public ModelAndView home() {
		
		List<Enq> enqs;
		
		if(!SecurityContext.userSignedIn()) {
			enqs = enqService.getEnqsRandomly();
		} else {
			enqs = enqService.getAvailableEnqs(SecurityContext.getCurrentUser().getpId());
		}
		
		if(enqs==null || enqs.isEmpty()) {
			return new ModelAndView("main/noEnq");
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("enqs", enqs);
		modelAndView.addObject("qNo", 0);
		modelAndView.addObject("answerForm", new AnswerForm());
		modelAndView.setViewName("main/top");
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
	public ModelAndView create(Enq enq) throws IllegalStateException, IOException {
		
		if(!SecurityContext.userSignedIn()) {
			return home();
		}
		enq.setOwner(SecurityContext.getCurrentUser().getpId());
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
	public ModelAndView myPage() {
		if(!SecurityContext.userSignedIn()) {
			return home();
		}
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("enqs", enqService.getHistory(SecurityContext.getCurrentUser().getpId()));
		modelAndView.addObject("myenqs", enqService.getMyEnq(SecurityContext.getCurrentUser().getpId()));
		modelAndView.setViewName("main/mypage");
		return modelAndView;
	}
	
	@RequestMapping(value = "/reload") 
	public void reload() {
		enqService.initPool();
	}
	
}

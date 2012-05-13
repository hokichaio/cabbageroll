package jp.co.netmile.cabbageroll.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping(value = "/iframe")
@Controller
public class IFrameController {
	
//	@Autowired
//	private EnqService enqService;
//	
//	@Autowired
//	private FacebookService facebookService;
//	
//	@RequestMapping(value = "/answer")
//	public ModelAndView answer(AnswerForm answerForm, HttpServletRequest request) {
//		
//		if(!SecurityContext.userSignedIn(request)) {
//			//TODO signin機能
//			return gotoEnq(answerForm.getEnqId(),request);
//		}
//		
//		enqService.registAnswer(answerForm, SecurityContext.getPid(request));
//		
//		return gotoEnq(answerForm.getEnqId(),request);
//	}
//	
//	
//	@RequestMapping(value = "/goto") 
//	public ModelAndView gotoEnq(@RequestParam("enqId") String enqId, HttpServletRequest request) {
//		
//		Enq enq = enqService.getEnqById(enqId);
//		
//		if(!SecurityContext.userSignedIn(request)) {
//			ModelAndView modelAndView = new ModelAndView();
//			modelAndView.addObject("enq", enq);
//			modelAndView.addObject("qNo", 0);
//			modelAndView.addObject("answerForm", new AnswerForm());
//			modelAndView.setViewName("iframe/top");
//			return modelAndView;
//		}
//		
//		Integer qNo = enqService.getQno(enq, SecurityContext.getPid(request));
//		
//		if(qNo != null) {
//			ModelAndView modelAndView = new ModelAndView();
//			modelAndView.addObject("enq", enq);
//			modelAndView.addObject("qNo", qNo);
//			modelAndView.addObject("answerForm", new AnswerForm());
//			modelAndView.setViewName("iframe/top");
//			return modelAndView;
//		} else {
//			List<String> friends = facebookService.getFriends(SecurityContext.getUid(request));
//			List<Result> results = enqService.getResults(enqId, SecurityContext.getPid(request), friends);
//			ModelAndView modelAndView = new ModelAndView();
//			modelAndView.addObject("results", results);
//			modelAndView.addObject("enq", enq);
//			modelAndView.setViewName("iframe/result");
//			return modelAndView;
//		}
//		
//	}
	
	
}

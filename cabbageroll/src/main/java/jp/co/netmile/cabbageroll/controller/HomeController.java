package jp.co.netmile.cabbageroll.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jp.co.netmile.cabbageroll.dto.AnswerForm;
import jp.co.netmile.cabbageroll.dto.Enq;
import jp.co.netmile.cabbageroll.dto.Result;
import jp.co.netmile.cabbageroll.service.EnqService;
import jp.co.netmile.cabbageroll.service.FacebookService;
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
	
	@Autowired
	private FacebookService facebookService;
	
	@RequestMapping(value = "/signout")
	public ModelAndView signout(HttpServletRequest request, HttpServletResponse response) {
		UserCookieGenerator.removeCookie(response);
		return new ModelAndView("redirect:/");
	}
	
	@RequestMapping(value = "/")
	public ModelAndView home(HttpServletRequest request) {
		return new ModelAndView("main/top");
	}
	
	@RequestMapping(value = "/create_init")
	public ModelAndView createInit(Enq enq, HttpServletRequest request) {
		
		if(!SecurityContext.userSignedIn(request)) {
			return home(request);
		}
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("enq", enq);
		modelAndView.setViewName("main/create_step1");
		return modelAndView;
	}
	
	@RequestMapping(value = "/create_step2")
	public ModelAndView createStep1(Enq enq, HttpServletRequest request) {
		
		if(!SecurityContext.userSignedIn(request)) {
			return home(request);
		}
		
		if(enq.getQuestions()==null) {
			Enq sessionEnq = (Enq)request.getSession().getAttribute("enq_create");
			if(sessionEnq != null) {
				ModelAndView modelAndView = new ModelAndView();
				modelAndView.addObject("enq", sessionEnq);
				modelAndView.setViewName("main/create_step2");
				return modelAndView;
			} else {
				return createInit(enq, request);
			}
		}
		
		enq.arrangeData();
		request.getSession().setAttribute("enq_create", enq);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("enq", enq);
		modelAndView.setViewName("main/create_step2");
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
		modelAndView.addObject("qNo", 0);
		modelAndView.addObject("postWallFlg", true);
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
	
	@RequestMapping(value = "/answer")
	public ModelAndView answer(AnswerForm answerForm, HttpServletRequest request) {
		
		if(!SecurityContext.userSignedIn(request)) {
			//TODO signin機能
			return gotoEnq(answerForm.getEnqId(),request);
		}
		
		enqService.registAnswer(answerForm, SecurityContext.getPid(request));
		
		return gotoEnq(answerForm.getEnqId(),request);
	}
	
	
	@RequestMapping(value = "/goto") 
	public ModelAndView gotoEnq(@RequestParam("enqId") String enqId, HttpServletRequest request) {
		
		Enq enq = enqService.getEnqById(enqId);
		
		if(!SecurityContext.userSignedIn(request)) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("enq", enq);
			modelAndView.addObject("qNo", 0);
			modelAndView.addObject("answerForm", new AnswerForm());
			modelAndView.setViewName("main/enq");
			return modelAndView;
		}
		
		Integer qNo = enqService.getQno(enq, SecurityContext.getPid(request));
		
		if(qNo != null) {
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("enq", enq);
			modelAndView.addObject("qNo", qNo);
			modelAndView.addObject("answerForm", new AnswerForm());
			modelAndView.setViewName("main/enq");
			return modelAndView;
		} else {
			List<String> friends = facebookService.getFriends(SecurityContext.getUid(request));
			List<Result> results = enqService.getResults(enqId, SecurityContext.getPid(request), friends);
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("results", results);
			modelAndView.addObject("enq", enq);
			modelAndView.setViewName("main/result");
			return modelAndView;
		}
		
	}
	
}

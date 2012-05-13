package jp.co.netmile.cabbageroll.controller;

import java.io.File;
import java.io.IOException;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/async")
public class AsyncController {
	
	@Autowired
	private EnqService enqService;
	
	@Autowired
	private FacebookService facebookService;
	
//	@RequestMapping(value = "/upload")
//	public String handleFormUpload(@RequestParam("file") MultipartFile file,@RequestParam("userId") String userId, @RequestParam("enqId") String enqId) throws IOException {
//
//	        if (!file.isEmpty()) {
//	        	
//	        	String type = file.getContentType();
//	        	String name = file.getOriginalFilename();
//	        	
//	        	String fileName = name.split("\\.")[1];
//	        	
//	        	File dest = new File("/test/" + enqId + "_" + userId + "." + fileName);
//	        	file.transferTo(dest);
//	        	
//	           return "redirect:uploadSuccess";
//	       } else {
//	           return "redirect:uploadFailure";
//	       }
//	}
	
	@RequestMapping(value = "/enqs")
	public ModelAndView home(HttpServletRequest request) {
		
		List<Enq> enqs;
		
		if(!SecurityContext.userSignedIn(request)) {
			enqs = enqService.getEnqsRandomly();
		} else {
			enqs = enqService.getAvailableEnqs(SecurityContext.getPid(request));
		}
		
		if(enqs==null || enqs.isEmpty()) {
			return null;
		}
		
		ModelAndView modelAndView = new ModelAndView("async/enqs");
		modelAndView.addObject("enqs", enqs);
		return modelAndView;
	}
	
	@RequestMapping(value = "/mqmaker")
	public ModelAndView ModelAndView(@RequestParam("qno") Integer qno) {
		ModelAndView modelAndView = new ModelAndView("async/q_form");
		modelAndView.addObject("qno", qno);
		return modelAndView;
	}
	
	@RequestMapping(value = "del_enq")
	public ModelAndView delEnq(@RequestParam("enqId") String enqId, HttpServletRequest request) {
		if(!SecurityContext.userSignedIn(request)) {
			return null;
		} else {
			enqService.delEnq(enqId, SecurityContext.getPid(request));
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("myenqs", enqService.getMyEnq(SecurityContext.getPid(request)));
			modelAndView.setViewName("async/myenqs");
			return modelAndView;
		}
		
	}
	
	@RequestMapping(value = "report")
	public void report(@RequestParam("enqId") String enqId, HttpServletRequest request) {
		
	}
	
}

package jp.co.netmile.cabbageroll.controller;

import java.io.File;
import java.io.IOException;
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
import org.springframework.web.multipart.MultipartFile;
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
	
	@RequestMapping(value = "/upload")
	public String handleFormUpload(@RequestParam("file") MultipartFile file,@RequestParam("userId") String userId, @RequestParam("enqId") String enqId) throws IOException {

	        if (!file.isEmpty()) {
	        	
	        	String type = file.getContentType();
	        	String name = file.getOriginalFilename();
	        	
	        	String fileName = name.split("\\.")[1];
	        	
	        	File dest = new File("/test/" + enqId + "_" + userId + "." + fileName);
	        	file.transferTo(dest);
	        	
	           return "redirect:uploadSuccess";
	       } else {
	           return "redirect:uploadFailure";
	       }
	}
}

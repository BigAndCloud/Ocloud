package com.ourselec.ocloud.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping("/timers")
@Controller
//@RooWebScaffold(path = "timers", formBackingObject = Timer.class)
public class TimerController {
	Logger logger = Logger.getLogger(TimerController.class);
	@RequestMapping("/user")
	public ModelAndView getuser(ModelAndView view){
		logger.info("user/login");
		System.out.println("/user/login1");
		view.setViewName("user/login1");
		return view;
	}
}

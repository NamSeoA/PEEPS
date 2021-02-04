package com.gnjk.post.mypost.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/test")
public class TestPageController {
	
	@RequestMapping(method = RequestMethod.GET)
	public String getRegForm() {
		return "mypost/test";
	}

}
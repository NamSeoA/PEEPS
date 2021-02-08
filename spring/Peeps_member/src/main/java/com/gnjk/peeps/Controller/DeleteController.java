package com.gnjk.peeps.Controller;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.gnjk.peeps.Service.DeleteService;
import com.gnjk.peeps.domain.Peeps;

@Controller
@RequestMapping("/profile/delete")
public class DeleteController {
	
	@Autowired
	private DeleteService deleteService;

	@RequestMapping(method = RequestMethod.GET)
	public String DeletePage() {
		
		return "member/profile_del";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String EditPwPost(HttpServletResponse response, @ModelAttribute Peeps peeps) throws IOException{
		
		deleteService.Delete(peeps, response);
		
		return "member/LoginForm";
	}
}

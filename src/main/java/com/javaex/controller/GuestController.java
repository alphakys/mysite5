package com.javaex.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import com.javaex.service.GuestService;
import com.javaex.vo.GuestVo;

@Controller
@RequestMapping(value="guest")
public class GuestController {
	
	//필드
	@Autowired
	private GuestService guService;
	
	//방명록 리스트 보여주기
	@RequestMapping(value="list", method = {RequestMethod.GET, RequestMethod.POST})
	public String list(Model model) {
		
		model.addAttribute("guList", guService.getList());
		
		return "guestbook/addList";
	}
	
	
	@RequestMapping(value="add", method = {RequestMethod.GET, RequestMethod.POST})
	public String add(@ModelAttribute GuestVo guVo) {
		
		guService.insert(guVo);
			
		return "redirect:list";
	}
	
	
	@RequestMapping(value="deleteForm", method = {RequestMethod.GET, RequestMethod.POST})
	public String deleteForm() {
		
		
		return "guestbook/deleteForm";
	}
	
	
	@RequestMapping(value="delete", method = {RequestMethod.GET, RequestMethod.POST})
	public String delete(@ModelAttribute GuestVo guVo) {
		
		int result = guService.delete(guVo);
		
		if(result ==1) 
		{	
			
			return "redirect:list";
		}
		
		else {
			
			return "redirect:deleteForm?result=fail&no="+guVo.getNo();	
			 }
		
		
	}
	
	@RequestMapping(value="ajaxList", method = {RequestMethod.GET, RequestMethod.POST})
	public String ajaxList() {
		
		
		return "guestbook/ajaxList";
	}
		
		
		
}	
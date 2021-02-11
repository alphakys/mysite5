package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.GuestService;
import com.javaex.vo.GuestVo;

@Controller
@RequestMapping(value="api/guest")
public class ApiGuestController {
	
	@Autowired
	private GuestService guService;
	
	
	@ResponseBody
	@RequestMapping(value="write", method= {RequestMethod.GET, RequestMethod.POST})
	public GuestVo write(@RequestBody GuestVo guVo) {
		
		return guService.writeResultVo(guVo);
	}
	
	@ResponseBody
	@RequestMapping(value="list", method= {RequestMethod.GET, RequestMethod.POST})
	public List<GuestVo> list() {
			
		return guService.getList();
	}
	
	
	@ResponseBody
	@RequestMapping(value="remove", method= {RequestMethod.GET, RequestMethod.POST})
	public int remove(@ModelAttribute GuestVo guVo) {
				
		int count = guService.delete(guVo);
		
		return count;
	}
	

	@ResponseBody
	@RequestMapping(value="write2", method= {RequestMethod.GET, RequestMethod.POST})
	public GuestVo write2(@RequestBody GuestVo guVo) {
		
		System.out.println(guVo.toString());
		
		return guService.writeResultVo(guVo);
	}
	
	
	
	
	
	}
	

	




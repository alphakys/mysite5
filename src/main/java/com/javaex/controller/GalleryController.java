package com.javaex.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.GalleryService;
import com.javaex.vo.GalleryVo;
import com.javaex.vo.UserVo;

@Controller
@RequestMapping(value="gallery")
public class GalleryController {
	
	@Autowired
	private GalleryService galService;
	
	
	
	@RequestMapping(value="list", method= {RequestMethod.GET, RequestMethod.POST})
	public String list(Model model) {
		
		model.addAttribute("gaList", galService.getList());
		
		return "gallery/list";
	}
	
	
	@RequestMapping(value="upload", method= {RequestMethod.GET, RequestMethod.POST})
	public String upload(HttpSession session,
						 @RequestParam("mulFile") MultipartFile mulFile,
						 @RequestParam("content") String content) {
		
		//세션에서 유저 번호 가져오기
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		int userNo = authUser.getNo();
		
		
		galService.restore(mulFile, content, userNo);
		
		
		return "redirect:list";
	}
	
	@ResponseBody
	@RequestMapping(value="delete", method= {RequestMethod.GET, RequestMethod.POST})
	public int delete(@RequestParam("no") int no) {
		
				
		
		return galService.delete(no);
	}



}
package com.javaex.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.javaex.service.BoardService;
import com.javaex.vo.BoardVo;
import com.javaex.vo.UserVo;

@Controller
@RequestMapping(value="board")
public class BoardController {
	
	//<필드>
	@Autowired
	private BoardService boService;
	
	
	@RequestMapping(value="list", method= {RequestMethod.GET, RequestMethod.POST})
	public String list(Model model, @RequestParam("page") int page) {
		
		int totalPost = boService.getTotalPost();
		
		model.addAttribute("boList", boService.getList(page));
		model.addAttribute("totalPost", totalPost);
		
		return "board/list";
	}
	
	
	
	@RequestMapping(value="read", method= {RequestMethod.GET, RequestMethod.POST})
	public String read(Model model, @RequestParam("no") int no) {
		
		boService.updateHit(no);
		BoardVo post = boService.getPost(no);
		
		model.addAttribute("post", post);
		return "board/read";
	}
	
	
	
	@RequestMapping(value="modifyForm", method= {RequestMethod.GET, RequestMethod.POST})
	public String modifyForm(Model model, @RequestParam("no") int no) {
		
		BoardVo modiPost = boService.getPost(no);
		
		model.addAttribute("modiPost", modiPost);
		
		return "board/modifyForm";
	}
	
	
	@RequestMapping(value="modify", method= {RequestMethod.GET, RequestMethod.POST})
	public String modify(@ModelAttribute BoardVo modiPost) {
		
		boService.modify(modiPost);
		
		return "redirect:read?no="+modiPost.getNo();
	}
	
	
	
	
	
	
	
	@RequestMapping(value="writeForm", method= {RequestMethod.GET, RequestMethod.POST})
	public String writeForm() {
		
		
		return "board/writeForm";
	}
	
	
	@RequestMapping(value="write", method= {RequestMethod.GET, RequestMethod.POST})
	public String write(@ModelAttribute BoardVo boVo, HttpSession session) {
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		boVo.setUserNo(authUser.getNo());
		
		boService.write(boVo);
		
		return "redirect:list";
	}
	
	
	
	
	
	
	
	
	
	
	
	
}

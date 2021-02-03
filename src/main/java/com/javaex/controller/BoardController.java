package com.javaex.controller;

import java.util.List;

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
import com.javaex.vo.PageVo;
import com.javaex.vo.UserVo;

@Controller
@RequestMapping(value="board")
public class BoardController {
	
	//<필드>
	@Autowired
	private BoardService boService;
	
	
	@RequestMapping(value="list", method= {RequestMethod.GET, RequestMethod.POST})
	public String list(Model model, @RequestParam("page") int page) {
		
		List<BoardVo> boList = boService.getList(page);
		PageVo paVo = boService.paging(page);
		
		model.addAttribute("boList", boList);
		model.addAttribute("pageVo", paVo);
		
		
		return "board/list";
	}
	
	
	
	@RequestMapping(value="read", method= {RequestMethod.GET, RequestMethod.POST})
	public String read(Model model, @RequestParam("no") int no) {
		
		
		BoardVo post = boService.read(no);
		
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
	
	
	@RequestMapping(value="delete", method= {RequestMethod.GET, RequestMethod.POST})
	public String delete(@RequestParam("no") int no) {
		
		boService.delete(no);
		return "redirect:list?page=1";
	}
	
	
	
	
	
	@RequestMapping(value="writeForm", method= {RequestMethod.GET, RequestMethod.POST})
	public String writeForm() {
		
		
		return "board/writeForm";
	}
	
	
	
	
	@RequestMapping(value="write", method= {RequestMethod.GET, RequestMethod.POST})
	public String write(@ModelAttribute BoardVo boVo, HttpSession session,@RequestParam("type") String type) {
				
		if("reply".equals(type)) {
			
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		boVo.setUserNo(authUser.getNo());
		
		boService.replyWrite(boVo);
		
		}
		else {
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
			boVo.setUserNo(authUser.getNo());
		
			boService.write(boVo);
			
		}
		
		
		return "redirect:list?page=1";
	}
	
	
	
	
	
	
	
	
	
	
	
	
}

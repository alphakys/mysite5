package com.javaex.controller;

import java.util.HashMap;
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
	
	//게시판 리스트 출력 
	@RequestMapping(value="list", method= {RequestMethod.GET, RequestMethod.POST})
	public String list(Model model, @RequestParam("page") int page) {
		
		//1페이지에 해당하는 게시물 10개 가져오기 위한 메소드(service 영역에서 map에 담아 페이지 처리를 위한 pageVo, 
		//게시판 list return받아 스프링 사용 목적에 맞는 방식으로 사용하고자 시도)
		HashMap<String, Object> listMap = boService.getList(page);
		//(page-1)은 게시판의 10개씩 페이징하기 위한 알고리즘.page의 일의 자리가 0~9일 때 1부터 10까지의 페이징 하는 알고리즘
		//10부터 19까지 일때 즉 일의 자리가 0~9일 때 10개의 페이징을 할 수 있는 알고리즘만 떠올라 page-1을 해서 페이징 처리
		List<BoardVo> boList = (List<BoardVo>)listMap.get("boList");
		PageVo pageVo = (PageVo)listMap.get("pageVo");
		
		model.addAttribute("boList", boList);
		model.addAttribute("pageVo", pageVo);
		
		
		return "board/list";
	}
	
	
	@RequestMapping(value="search", method= {RequestMethod.GET, RequestMethod.POST})
	public String search(@RequestParam("keyword") String keyword,
						 @RequestParam("page") int page,
						 Model model) {
							 
		HashMap<String, Object> keywordMap = new HashMap<>();
		keywordMap.put("keyword", keyword);
		keywordMap.put("page", page);
		
		List<BoardVo> searchList = (List<BoardVo>)boService.getSearchList(keywordMap).get("searchList");
		PageVo pageVo = (PageVo)boService.getSearchList(keywordMap).get("pageVo");
		
		model.addAttribute("boList", searchList);
		model.addAttribute("pageVo", pageVo);
	
		return "board/list";
	}
	
	
	
	
	
	//게시글 읽는 메소드
	@RequestMapping(value="read", method= {RequestMethod.GET, RequestMethod.POST})
	public String read(Model model, @RequestParam("no") int no) {
		
		
		BoardVo post = boService.read(no);
		
		model.addAttribute("post", post);
		return "board/read";
	}
	
	
	//게시글 수정 메소드
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
	
	
	//게시글 삭제 메소드 로그인 시 자기 글만 삭제가능
	@RequestMapping(value="delete", method= {RequestMethod.GET, RequestMethod.POST})
	public String delete(@RequestParam("no") int no) {
		
		boService.delete(no);
		return "redirect:list?page=1";
	}
	
	
	//게시판에 글쓰기 위한 메소드
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

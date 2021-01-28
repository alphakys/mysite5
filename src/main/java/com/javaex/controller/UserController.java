package com.javaex.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.javaex.service.UserService;
import com.javaex.vo.UserVo;

@Controller
@RequestMapping(value="user")
public class UserController {
	
	@Autowired
	private UserService usService;
		
	//회원가입 페이지로 넘김
	@RequestMapping(value="joinForm", method= {RequestMethod.GET, RequestMethod.POST})
	public String joinForm() {
		
		return "user/joinForm";
	}
	
	//DB에 회원가입 정보 등록
	@RequestMapping(value="join", method= {RequestMethod.GET, RequestMethod.POST})
	public String join(@ModelAttribute UserVo usVo) {
		
		usService.insert(usVo);
		
		return "user/joinOk";
	}
	
	
<<<<<<< HEAD
=======
	
>>>>>>> refs/remotes/origin/master
	//로그인 페이지
	@RequestMapping(value="loginForm", method ={RequestMethod.GET, RequestMethod.POST})
	public String loginForm() {
		
		
		return "user/loginForm";
	}
	
	//DB에서 아이디 패스워드 일치할 시 사용자 정보 no, 이름 가져옴
	//그리고 세션에 넣어줌
	//*******session*******
	@RequestMapping(value="login", method ={RequestMethod.GET, RequestMethod.POST})
	public String login(@ModelAttribute UserVo usVo, HttpSession session) {
		
		UserVo authUser = (UserVo)usService.login(usVo);
		
		
		if(authUser == null) {
			
			return "redirect:loginForm?result=fail";
		}
		else {
			
			session.setAttribute("authUser", authUser);
			return "redirect:/";
		}
		
	}
	
	//로그아웃시 세션 정보 리셋
	@RequestMapping(value="logout", method={RequestMethod.GET, RequestMethod.POST})
	public String logout(HttpSession session) {
		
		session.removeAttribute("authUser");
		session.invalidate();
		
		return "redirect:/";
	}
	
	
	//유저 정보 변경시 필요한 기존의 데이터 전송 그리고 유저 정보 변경
	@RequestMapping(value="modifyForm", method={RequestMethod.GET, RequestMethod.POST})
	public String modifyForm(HttpSession session, Model model) {
		
		UserVo authUser = (UserVo)session.getAttribute("authUser");
		
		if(authUser == null) 
		{		
			return "redirect:/";
		}
		
		else {
				int no = authUser.getNo();
		
				UserVo usInfo = usService.getInfo(no);
		
				model.addAttribute("userInfo", usInfo);
		
				return "user/modifyForm";
		
		     }
	
	}
	
	
	//1. modifyForm에서 hidden으로 유저 no를 포함한  모든 정보 modelAttribute로 받아서 Vo로 --> Dao에 넘겨주기
	//2. modifyForm에서 no를 제외한 나머지 정보 받고 controller에서 세션으로 no 값 넘겨주기 ***usDao.update(modiVo, no)***
	//	 1번 방식 채택
	@RequestMapping(value="modify", method={RequestMethod.GET, RequestMethod.POST})
	public String modify(@ModelAttribute UserVo modiVo, HttpSession session) {
		
			int count = usService.update(modiVo);
		//세션에 변경된 정보 재저장
			
			if(count==1) {
				
				UserVo authUser = (UserVo)session.getAttribute("authUser");
				authUser.setName(modiVo.getName());
			
				return "redirect:/";
			}
			else {
				
				return "redirect:modifyForm";
			}
		
		
	}
	
	
	
	
	
	
	
	
	
}

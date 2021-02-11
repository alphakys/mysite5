package com.javaex.controller;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.BoardService;
import com.javaex.vo.BoardVo;

@Controller
@RequestMapping(value="api/board")
public class ApiBoardController {
	
	@Autowired
	private BoardService boService;
	
	@ResponseBody
	@RequestMapping(value="list", method= {RequestMethod.GET, RequestMethod.POST})
	public List<BoardVo> list(@RequestParam int page){
		
		List<BoardVo> boList = (List<BoardVo>)boService.getList(page).get("boList");
				
		return boList;
	}
	
	@ResponseBody
	@RequestMapping(value="delete", method= {RequestMethod.GET, RequestMethod.POST})
	public int ajaxDel(@RequestParam Map<String, Object> map) {
		
		
		
		return boService.ajaxDel(map);
	}
	
	
	
}

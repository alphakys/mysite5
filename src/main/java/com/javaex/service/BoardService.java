package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.BoardDao;
import com.javaex.vo.BoardVo;

@Service
public class BoardService {
	
	//<필드>
	@Autowired
	private BoardDao boDao;
	
	
	public List<BoardVo> getList(int page){
		
		List<BoardVo> boList = boDao.selectList(page);	
		
		return boList;
	}
	
	
	public int getTotalPost() {
		
		int totalPost = boDao.selectTotalPost();
		
		return totalPost;
	}
	
	
	
	
	
	
	public BoardVo getPost(int no) {
		
		BoardVo post = boDao.selectPost(no);
				
		return post;
		
	}
	
	
	public void updateHit(int no) {
		
		boDao.updateHit(no);
		
	}
	
	
	public void write(BoardVo boVo) {
		
		boDao.insert(boVo);
	}
	
	
	
	
	
	
}

package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.BoardDao;
import com.javaex.vo.BoardVo;
import com.javaex.vo.PageVo;



@Service
public class BoardService {
	
	//<필드>
	@Autowired
	private BoardDao boDao;
	
	
	public List<BoardVo> getList(int page){
		
		List<BoardVo> boList = boDao.selectList(page);	
		
		return boList ;
	}
	
	
	public PageVo paging(int page) {
		
		int startPage = ((page/10)*10)+1;
		int endPage = ((page/10)+1)*10;
		
		PageVo paVo = new PageVo();
		
		paVo.setStartPage(startPage);
		paVo.setEndPage(endPage);
		
		return paVo;
	}
	
	
	
	
	
	
	public int getTotalPost() {
		
		int totalPost = boDao.selectTotalPost();
		
		return totalPost;
	}
	
	
	
	public BoardVo read(int no) {
		
		boDao.updateHit(no);
		
		BoardVo post = boDao.selectPost(no);
				
		return post;
		
	}

	

	
	

		
		
	public void modify(BoardVo modiPost) {
		
		boDao.update(modiPost);
		
	}
	
	
	public void delete(int no) {
		
		boDao.delete(no);
	}
	
	
	public BoardVo getPost(int no) {
		
		BoardVo post = boDao.selectPost(no);
		
		return post;
	}
	
	
	
	
	public void write(BoardVo boVo) {
		
		boDao.insert(boVo);
	}
	
	
	public void replyWrite(BoardVo boVo) {
		
		boDao.updateOrderNo(boVo.getGroupNo());

		String tab = "  ";
		for(int i=0; i<boVo.getDepth(); i++) {
			
			tab+=tab.concat(tab);
			
		}
		
		
		String title = tab.concat(boVo.getTitle());
		
		boVo.setTitle(title);
	
		boDao.replyInsert(boVo);
		
	}
	
	
	
}

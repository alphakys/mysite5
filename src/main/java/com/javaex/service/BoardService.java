package com.javaex.service;

import java.util.HashMap;
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
	
	
	public HashMap<String, Object> getList(int page){
		
		List<BoardVo> boList = boDao.selectList(page);	
		PageVo pageVo = paging(page-1);
		
		HashMap<String, Object> listMap = new HashMap<>();
		
		listMap.put("boList", boList);
		listMap.put("pageVo", pageVo);
		
		
		return listMap;
	}
	
	public HashMap<String, Object> getSearchList(HashMap<String, Object> keywordMap){
		
		List<BoardVo> searchList = boDao.selectSearchList(keywordMap);
		
		int page = (int)(keywordMap.get("page"))-1;
		PageVo pageVo = paging(page);
		
		HashMap<String, Object> searchListMap = new HashMap<>();
		
		searchListMap.put("searchList", searchList);
		searchListMap.put("pageVo", pageVo);

		return searchListMap;
	}
	
	
	
	
	public PageVo paging(int page) {
		//첫 페이지
		int startPage = ((page/10)*10)+1;
		//10개 단위중 끝 페이지 10,20,30~~
		int endPage = ((page/10)+1)*10;
		//총 게시글의 마지막 페이지를 알기 위한 모든 게시글 count해서 가져온 값
		int totalPost = boDao.selectTotalPost();
		
		//게시판의 가장 마지막 페이지
		int lastPage;
		
		//게시글을 10개씩 리스트로 뿌려주기로 해서 나머지가 0보다 클 경우는 게시글의 총 합을 나눈 몫에 +1
		//게시글이 100, 200, 10으로 나누어 떨어질 때는 총 게시글을 10으로 나눈 몫이 마지막 페이지
		if(totalPost%10 !=0) {
			lastPage = (totalPost/10)+1;
			
			
		}
		else {
			lastPage = totalPost/10;
			
		}
		
		//만약 출력해야할 끝 페이지가 총 게시글중 마지막 페이지 보다 클 경우 총 게시글 마지막 페이지 출력
		if(endPage> lastPage) {
				endPage=lastPage;
			}
		
		PageVo paVo = new PageVo();
		
		paVo.setStartPage(startPage);
		paVo.setEndPage(endPage);
		paVo.setLastPage(lastPage);
		
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

package com.javaex.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.BoardDao;
import com.javaex.vo.BoardVo;




@Service
public class BoardService {
	
	//<필드>
	@Autowired
	private BoardDao boDao;
	
	/* 페이지 객체로 만들어서 페이징 했던 내가 한 방식
	public HashMap<String, Object> getList(int page){
		
		List<BoardVo> boList = boDao.selectList(page);	
		PageVo pageVo = paging(page-1);
		
		HashMap<String, Object> listMap = new HashMap<>();
		
		listMap.put("boList", boList);
		listMap.put("pageVo", pageVo);
		
		
		return listMap;
	}
	
	*/
	
	public Map<String, Object> getList(String keyword, int crtPage){
		
		int lastPage;
		int totalPost = boDao.selectTotalPost(keyword);
		
		int listCnt = 10;
		
		if(totalPost%listCnt !=0) {
			lastPage = (totalPost/listCnt)+1;
				
		}
		
		else {
			lastPage = totalPost/listCnt;
			
		}
		//페이지당 글 갯수
		crtPage = (crtPage >0) ? crtPage : (crtPage=1);
		crtPage = (crtPage> lastPage) ? crtPage=lastPage : crtPage;	
		
		
		int startNum = ((crtPage-1)* listCnt) +1;
		
		int endNum = crtPage * listCnt;
		
		
		//페이징
		
		int pageCount = 5;
		
		int startPage = (((crtPage-1)/pageCount)*pageCount)+1;
		
		int endPage = startPage+4;
		
		
		//만약 출력해야할 끝 페이지가 총 게시글중 마지막 페이지 보다 클 경우 총 게시글 마지막 페이지 출력
		
		endPage = (endPage> lastPage) ? endPage=lastPage : endPage;
		
		crtPage = (crtPage> lastPage) ? crtPage=lastPage : crtPage;
		
		Map<String, Object> paMap = new HashMap<>();	
			
		paMap.put("boList", boDao.selectList(keyword, startNum, endNum));
		paMap.put("startPage", startPage);
		paMap.put("endPage", endPage);
		paMap.put("lastPage", lastPage);
			
		return paMap;
	}
	
	
	
	/*내가 스스로 생각한 10개씩 페이징
	
	public PageVo paging(int page, String keyword) {
		//첫 페이지
		int startPage = ((page/10)*10)+1;
		//10개 단위중 끝 페이지 10,20,30~~
		int endPage = ((page/10)+1)*10;
		//총 게시글의 마지막 페이지를 알기 위한 모든 게시글 count해서 가져온 값
		int totalPost = boDao.selectTotalPost(keyword);
		
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
	
	*/

	public int getTotalPost(String keyword) {
		
		int totalPost = boDao.selectTotalPost(keyword);
	
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
	
	
	public int ajaxDel(Map<String, Object> map) {
		
		
		
		return boDao.ajaxDel(map);
	}
	
	
	
	
	
	
	
}

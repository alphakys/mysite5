package com.javaex.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.javaex.vo.BoardVo;


@Repository
public class BoardDao {
	
	//<필드>
	@Autowired
	private SqlSession sqlSession;
	
	
	public List<BoardVo> selectList(int page){
		
		List<BoardVo> boList = sqlSession.selectList("board.selectList", page);
		
		return boList;
		

	}
	
	
	public List<BoardVo> selectSearchList(HashMap<String, Object> keywordMap){
		
		List<BoardVo> searchList = sqlSession.selectList("board.selectSearchList", keywordMap);
		
		return searchList;
		
	}
	
	
	
	
	
	
	public int selectTotalPost() {
		
		int totalPost = sqlSession.selectOne("board.selectTotalPost");
		
		return totalPost;
	}
	
	
	
	public BoardVo selectPost(int no) {
		
		BoardVo post = sqlSession.selectOne("board.selectPost", no);
		return post;
	}
	
	
	
	public void updateHit(int no) {
		
		sqlSession.update("board.updateHit", no);
		
	}
	
	
	public void update(BoardVo modiPost) {
		
		sqlSession.update("board.update", modiPost);
		
	}
	
	
	public void delete(int no) {
		
		sqlSession.delete("board.delete", no);
	}
	
	
	
	public void insert(BoardVo boVo) {
		
		sqlSession.insert("board.insert", boVo);
		
	}
	
	
	public void replyInsert(BoardVo boVo) {
		
		sqlSession.insert("board.replyInsert", boVo);
	}
	
	
	public void updateOrderNo(int groupNo) {
		
		sqlSession.update("board.updateOrderNo", groupNo);

	}
	
	
	
	
	
	
	
	
	
	
}

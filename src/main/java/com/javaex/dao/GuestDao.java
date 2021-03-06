package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.GuestVo;

@Repository
public class GuestDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<GuestVo> selectList(){
		
		List<GuestVo> guList = sqlSession.selectList("guest.selectList");
		
		return guList;
	}
	
	
	public void insert(GuestVo guVo) {
		
		sqlSession.insert("guest.insert", guVo);
				
				
	}
	
	
	public int delete(GuestVo guVo) {
		
		int count = sqlSession.delete("guest.delete", guVo);
				
		return count;		
	}
	
	
	//ajax 글저장
	public void insertSelectKey(GuestVo guVo) {
		
		sqlSession.insert("guest.insertSelectKey", guVo);
		
	}
	
	
	
	public GuestVo selectOne(int no) {
		
		GuestVo guVo = sqlSession.selectOne("guest.selectOne", no);
		
		return guVo;
	}
	

	
}

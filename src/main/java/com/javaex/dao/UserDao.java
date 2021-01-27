package com.javaex.dao;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.UserVo;

@Repository
public class UserDao {
	
	//<<필드>>
	@Autowired
	private SqlSession sqlSession;
	
	//로그인 정보 등록
	public int insert(UserVo usVo) {
		//성공시 count(int)를 넘겨줌
		int count;
		
		count = sqlSession.insert("user.insert", usVo);
		return count;
	}
	
	//로그인을 위한 메서드 
	//id와 비번 일치하는지 확인 후 맞을시 세션에 넣을 정보 얻어옴
	public UserVo getOne(UserVo usVo) {
		
		UserVo authUser = sqlSession.selectOne("user.selectUser", usVo);
		
		return authUser;
	}
	
	
	//유저 정보 변경시 필요한 기존의 데이터 전송(usInfo라 표현) 그리고 유저 정보 변경
	//세션에 저장된 name이 있기에 이 메소드에서는 name을 제외한 나머지 데이터를 받아옴
	public UserVo getInfo(int no) {
		
		UserVo usInfo = sqlSession.selectOne("user.selectInfo", no);
		
		return usInfo;
	}
	
	
	public int update(UserVo modiVo) {
		
		int count = sqlSession.update("user.update", modiVo);
		
		return count;
	}
	
	
	

	
}

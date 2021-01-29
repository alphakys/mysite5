package com.javaex.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.UserDao;
import com.javaex.vo.UserVo;

@Service
public class UserService {
	
	
	@Autowired
	private UserDao usDao;
	
	//DB에 회원가입 정보 등록
	public void insert(UserVo usVo) {
		
		usDao.insert(usVo);
		
	}
	
	
	//로그인
	public UserVo login(UserVo usVo) {
		
		UserVo authUser = usDao.getOne(usVo);
		
		return authUser;
	}
	
	
	public UserVo getInfo(int no) {
		
		UserVo usInfo = usDao.getInfo(no);
		
		return usInfo;
	}
	
	
	public int update(UserVo modiVo) {
		
		int count = usDao.update(modiVo);
		
		return count;
		
	}
	
	
	
	
	
}

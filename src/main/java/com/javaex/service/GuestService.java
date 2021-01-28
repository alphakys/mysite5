package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.dao.GuestDao;
import com.javaex.vo.GuestVo;

@Repository
public class GuestService {
	
	@Autowired
	private GuestDao guDao;
	
	public List<GuestVo> getList(){
		
		List<GuestVo> guList = guDao.selectList();
		
		return guList;
	}
	
	public void insert(GuestVo guVo) {
		
		guDao.insert(guVo);
		
		
	}
	
	
	public int delete(GuestVo guVo) {
		
		int result = guDao.delete(guVo);
		
		return result;
	}
	
	
	
}

package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.GuestDao;
import com.javaex.vo.GuestVo;

@Service
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
		
		int count = guDao.delete(guVo);
		
		return count;
	}
	
	
	public GuestVo writeResultVo(GuestVo guVo) {
		
		guDao.insertSelectKey(guVo);
		
		int no = guVo.getNo();
	
		return guDao.selectOne(no);
	}
	

	
	
}

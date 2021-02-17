package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.GalleryVo;

@Repository
public class GalleryDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	
	public void insert(GalleryVo galVo) {
		
		sqlSession.insert("gallery.insert", galVo);
		
	}
	
	
	public List<GalleryVo> selectList(){

		return sqlSession.selectList("gallery.selectList");
		
	}

	
	public int delete(int no) {
		
		return sqlSession.delete("gallery.delete", no);
	}
	
	
}

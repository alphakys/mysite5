package com.javaex.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.dao.GalleryDao;
import com.javaex.vo.GalleryVo;

@Service
public class GalleryService {
		
	@Autowired
	private GalleryDao galDao;
	
	public List<GalleryVo> getList(){
	
		return galDao.selectList();
		
	}
	
	
	public int delete(int no) {
		
		return galDao.delete(no);
	}
	
	
	
	public void restore(MultipartFile mulFile, String content, int userNo) {
		
		//오리지널 이름, 사용자!!!가 업로드한 파일의 원이름
		String orgName = mulFile.getOriginalFilename();
		
		//파일 확장자, 
		String exName = orgName.substring(orgName.lastIndexOf("."));
		
		//파일 사이즈
		long fileSize = mulFile.getSize();
		
		//사이트!!!측 서버에 사용자의 업로드 파일이 저장된 경로
		String saveDir = "C:\\Users\\gys11\\Desktop\\JavaStudy\\upload";
		
		//파일 저장 이름, 사용자가 업로드한 파일 이름 그대로 사용시 중복의 위험이 있기에 사이트측에서 임의의 중복되지 않을 이름을 지정하고 
		//확장자를 마지막에 붙여준다
		String saveName = System.currentTimeMillis() + UUID.randomUUID().toString() + exName;
		
		//**********파일이 사이트측 서버에 저장된 경로와 중복 방지를 위해 명명한 이름을 같이 붙여 만듬**********
		String filePath = saveDir+"\\"+saveName;

		
		//중요!!!! 꼭 기억하기 byte 형식으로 이미지를 읽어들여 배열에 저장!!!!
		try {
			byte[] fileData = mulFile.getBytes();
			
			//!!!저장할 파일 이름을 arg로 삽입
			FileOutputStream fos = new FileOutputStream(filePath);
			BufferedOutputStream bos = new BufferedOutputStream(fos);
			
			bos.write(fileData);
			
			bos.close();
			
		}catch(IOException e) {
			e.printStackTrace();
		}
		
		//upload에 올라온 정보를 긁어 galVo에 저장
		GalleryVo galVo = new GalleryVo();
		
		//유저 번호는 service에서 객체 만들면서 한꺼번에 넣기 위해 일부러 파라미터로 받아와서 같이 넣음
		galVo.setUserNo(userNo);
		galVo.setOrgName(orgName);
		galVo.setFileSize(fileSize);
		galVo.setContent(content);
		galVo.setFilePath(filePath);
		galVo.setSaveName(saveName);
		
		
		galDao.insert(galVo);
		
		
	}
	
	
	
	
}

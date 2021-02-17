package com.javaex.service;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;



@Service
public class FileUploadService  {
	

	public String restore(MultipartFile file) {
		
		//<<db 저장할 정보 수집>>
		
		//오리지날 파일 이름
		String orgName = file.getOriginalFilename();
		
		//확장자
		String exName = orgName.substring(orgName.lastIndexOf("."));
		
		//서버 하드디스크 저장
		String saveName = System.currentTimeMillis()+UUID.randomUUID().toString()+ exName;
		
		
		
		//하드디스크 저장 경로
		String saveDir = "C:\\Users\\gys11\\Desktop\\JavaStudy\\upload";
		
		//서버 파일 패스 --> 저장 경로
		String filePath = saveDir + "\\" +saveName;
		
		//파일 사이즈
		long fileSize = file.getSize();
		
		//서버 하드디스크 저장
		try{
			
			byte[] fileData = file.getBytes();
			//fileoutputstream은 instance 생성시 파일 arg로 주기
			FileOutputStream fos = new FileOutputStream(filePath);
			//buffer 방식으로 output 
			BufferedOutputStream bos = new BufferedOutputStream(fos);
			
			bos.write(fileData);
			
		}catch(IOException e) {
			e.printStackTrace();
		}
		
		
		
		return saveName;

	}
	
	
	
}

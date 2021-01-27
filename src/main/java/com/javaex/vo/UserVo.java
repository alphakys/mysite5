package com.javaex.vo;

public class UserVo {
	
	//필드
	private int no;
	private String id, pw, name, gender;
	
	//default 생성자
	public UserVo() {}
	

	// G||S


	public int getNo() {
		return no;
	}


	public void setNo(int no) {
		this.no = no;
	}


	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getPw() {
		return pw;
	}


	public void setPw(String pw) {
		this.pw = pw;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getGender() {
		return gender;
	}


	public void setGender(String gender) {
		this.gender = gender;
	}


	@Override
	public String toString() {
		return "UserVo [id=" + id + ", pw=" + pw + "]";
	}
	
	
	
	
	
}

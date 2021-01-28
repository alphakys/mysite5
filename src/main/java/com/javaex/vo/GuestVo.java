package com.javaex.vo;

public class GuestVo {
	
	//필드
	private int no;
	private String name, pw, content, date;
	
	
	

	//생성자
	public GuestVo() {}
	
	

	//g/s
	
	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
	
	//메서드
	
	@Override
	public String toString() {
		return "GuestBookVo [no=" + no + ", name=" + name + ", password=" + pw + ", content=" + content
				+ ", date=" + date + "]";
	}
	
	
}
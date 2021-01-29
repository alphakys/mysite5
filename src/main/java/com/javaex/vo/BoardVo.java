package com.javaex.vo;

public class BoardVo {
	
	//<<필드>>
	
	private int no;
	private String title;
	private String content;
	private int hit;
	private String date;
	private int userNo;
	
	// users에서 가져온 이름(게시판 리스트에 보여줄 userName)
	private String name;
	
	
	
	//<<생성자>>
	BoardVo(){}
	
	//Getter/Setter
	


	public int getNo() {
		return no;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setNo(int no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	
	
	//메서드
	@Override
	public String toString() {
		return "BoardVo [no=" + no + ", title=" + title + ", content=" + content + ", hit=" + hit + ", date=" + date
				+ ", userNo=" + userNo + ", name=" + name + "]";
	}
	
	

	
	
	
	
	
	
}

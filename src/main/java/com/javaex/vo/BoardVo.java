package com.javaex.vo;

public class BoardVo {
	
		private int no, userNo, hit, groupNo, orderNo, depth;
		private String name, title, content, date;
			
		
		
		
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public int getNo() {
			return no;
		}
		public void setNo(int no) {
			this.no = no;
		}
		public int getUserNo() {
			return userNo;
		}
		public void setUserNo(int userNo) {
			this.userNo = userNo;
		}
		public int getHit() {
			return hit;
		}
		public void setHit(int hit) {
			this.hit = hit;
		}
		public int getGroupNo() {
			return groupNo;
		}
		public void setGroupNo(int groupNo) {
			this.groupNo = groupNo;
		}
		public int getOrderNo() {
			return orderNo;
		}
		public void setOrderNo(int orderNo) {
			this.orderNo = orderNo;
		}
		public int getDepth() {
			return depth;
		}
		public void setDepth(int depth) {
			this.depth = depth;
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
		public String getDate() {
			return date;
		}
		public void setDate(String date) {
			this.date = date;
		}
		
		
		
		@Override
		public String toString() {
			return "RboardVo [no=" + no + ", userNo=" + userNo + ", hit=" + hit + ", groupNo=" + groupNo + ", orderNo="
					+ orderNo + ", depth=" + depth + ", title=" + title + ", content=" + content + ", date=" + date
					+ "]";
		}
		
		
	
	
}

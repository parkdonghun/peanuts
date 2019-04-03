package kr.co.hta.peanuts.vo;

import java.util.Date;

public class Likes {

	private int no;
	private String userId;
	private String category;
	private Date createDate;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		return "Likes [no=" + no + ", userId=" + userId + ", category=" + category + ", createDate=" + createDate + "]";
	}
	
}

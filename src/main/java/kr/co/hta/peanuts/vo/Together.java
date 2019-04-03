package kr.co.hta.peanuts.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Together {
	
	private int boardNo;
	private String title;
	private String userId;
	private Date createDate;
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getTitle() {
		return title;
	}
	public String getTitleWithDots() {
		if(title != null) {
			if(title.length() >= 25) {
				return title.substring(0, 25) + "...";
			}
			return title;
		} 
		return "";
	}	
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public String getCreateDateToString() {
		if(createDate != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			return sdf.format(createDate);
		}
		return "";
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		return "Together [boardNo=" + boardNo + ", title=" + title + ", userId=" + userId + ", createDate=" + createDate
				+ "]";
	}
	
}

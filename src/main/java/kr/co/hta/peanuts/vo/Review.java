package kr.co.hta.peanuts.vo;

import java.util.Date;

public class Review {

	private int reviewNo;
	private int ticketNo;
	private String userId;
	private int ticketGrade;
	private String reviewContents;
	private Date createDate;
	
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public int getTicketNo() {
		return ticketNo;
	}
	public void setTicketNo(int ticketNo) {
		this.ticketNo = ticketNo;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getTicketGrade() {
		return ticketGrade;
	}
	public void setTicketGrade(int ticketGrade) {
		this.ticketGrade = ticketGrade;
	}
	public String getReviewContents() {
		return reviewContents;
	}
	public void setReviewContents(String reviewContents) {
		this.reviewContents = reviewContents;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		return "Review [reviewNo=" + reviewNo + ", ticketNo=" + ticketNo + ", userId=" + userId + ", ticketGrade="
				+ ticketGrade + ", reviewContents=" + reviewContents + ", createDate=" + createDate + "]";
	}
}

package kr.co.hta.peanuts.vo;

import java.util.Date;

public class Qna {

	private int qnaNo;
	private int ticketNo;
	private User user;
	private String questionContents;
	private Date questionDate;
	private String answerContents;
	private Date answerDate;
	public int getQnaNo() {
		return qnaNo;
	}
	public void setQnaNo(int qnaNo) {
		this.qnaNo = qnaNo;
	}
	public int getTicketNo() {
		return ticketNo;
	}
	public void setTicketNo(int ticketNo) {
		this.ticketNo = ticketNo;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getQuestionContents() {
		return questionContents;
	}
	public void setQuestionContents(String questionContents) {
		this.questionContents = questionContents;
	}
	public Date getQuestionDate() {
		return questionDate;
	}
	public void setQuestionDate(Date questionDate) {
		this.questionDate = questionDate;
	}
	public String getAnswerContents() {
		return answerContents;
	}
	public void setAnswerContents(String answerContents) {
		this.answerContents = answerContents;
	}
	public Date getAnswerDate() {
		return answerDate;
	}
	public void setAnswerDate(Date answerDate) {
		this.answerDate = answerDate;
	}
	@Override
	public String toString() {
		return "Qna [qnaNo=" + qnaNo + ", ticketNo=" + ticketNo + ", user=" + user + ", questionContents="
				+ questionContents + ", questionDate=" + questionDate + ", answerContents=" + answerContents
				+ ", answerDate=" + answerDate + "]";
	}
}

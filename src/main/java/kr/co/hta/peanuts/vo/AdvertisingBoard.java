package kr.co.hta.peanuts.vo;

import java.util.Date;

public class AdvertisingBoard {

	private String no;
	private String title;
	private String id;
	private String noPwd;		// 게시글 비밀번호
	private String status;
	private String image;
	private String startDate;
	private String endDate;
	private String manager;
	private String term;
	private String type;		// 광고타입
	private Date createDate;
	
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getNoPwd() {
		return noPwd;
	}
	public void setNoPwd(String noPwd) {
		this.noPwd = noPwd;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getManager() {
		return manager;
	}
	public String getTerm() {
		return term;
	}
	public void setTerm(String term) {
		this.term = term;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		return "AdvertisingBoard [no=" + no + ", title=" + title + ", id=" + id + ", noPwd=" + noPwd + ", status="
				+ status + ", image=" + image + ", startDate=" + startDate + ", endDate=" + endDate + ", manager="
				+ manager + ", term=" + term + ", type=" + type + ", createDate=" + createDate + "]";
	}
}

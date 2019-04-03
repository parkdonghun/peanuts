package kr.co.hta.peanuts.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class Reply {

	private int boardNo;
	private int repNo;
	private String category;
	private String userId;
	private String contents;
	private String status;
	private Date createDate;
	private String profile;
	
	private boolean isComComs;
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public int getRepNo() {
		return repNo;
	}
	public void setRepNo(int repNo) {
		this.repNo = repNo;
	}
	public String getCategoryName() {
		String name = "";
		if ("PLANNER".equals(this.category)) {
			name = "플래너";
		} else if ("ALL".equals(this.category)) {
			name = "광장게시판";
		} else if ("TOGETHER".equals(this.category)) {
			name = "동행게시판";
		} else if ("QNA".equals(this.category)) {
			name = "QNA";
		} else if ("REPLY".equals(this.category)) {
			name = "REPLY";
		}
		return name;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getContensWithEnter() {
		return contents.replaceAll("\n", "<br/>");
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCreateDateToString() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(createDate);
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreteDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	
	public boolean getIsComComs() {
		return isComComs;
	}
	public void setIsComComs(boolean isComComs) {
		this.isComComs = isComComs;
	}
	@Override
	public String toString() {
		return "Reply [boardNo=" + boardNo + ", repNo=" + repNo + ", category=" + category + ", userId=" + userId
				+ ", contents=" + contents + ", status=" + status + ", createDate=" + createDate + ", profile="
				+ profile + ", isComComs=" + isComComs + "]";
	}
	
	
}

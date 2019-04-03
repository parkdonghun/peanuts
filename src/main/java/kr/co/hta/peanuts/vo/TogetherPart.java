package kr.co.hta.peanuts.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TogetherPart {

	private int boardNo;
	private String userId;
	private Date createDate;
	private String userStatus;
	private String profile;
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
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
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if(createDate != null) {
			return sdf.format(createDate);
		}
		return "";
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getUserStatus() {
		return userStatus;
	}
	public void setUserStatus(String userStatus) {
		this.userStatus = userStatus;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	@Override
	public String toString() {
		return "TogetherPart [boardNo=" + boardNo + ", userId=" + userId + ", createDate=" + createDate
				+ ", userStatus=" + userStatus + ", profile=" + profile + "]";
	}
	
}

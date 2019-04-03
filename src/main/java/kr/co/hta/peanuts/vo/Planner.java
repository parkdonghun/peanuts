package kr.co.hta.peanuts.vo;

import java.util.Date;

public class Planner {

	private int no;
	private String userId;
	private String title;
	private String startDate;
	private String endDate;
	private int member;
	private Date createDate;
	private String status;
	private String open;
	private String hashTag;
	
	private String mapImg;
	private int likeCnt;
	private boolean isSampDate;
	private String planType;
	private User profile;
	
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
	public String getTitle() {
		return title;
	}
	public String getTitleWithDots() {
		if(title != null) {
			if(title.length() >= 12) {
				return title.substring(0, 12) + "...";
			}
			return title;
		}
		return "";
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStartDate() {
		return startDate;
	}
	public String getStartMonth() {
		String[] dates = startDate.split("-");
		return dates[0]+"년 "+dates[1]+"월";
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
	public int getMember() {
		return member;
	}
	public void setMember(int member) {
		this.member = member;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getOpen() {
		return open;
	}
	public void setOpen(String open) {
		this.open = open;
	}
	
	public String getOpenText() {
		if ("N".equals(open)) {
			return "비공개";
		}
		return "공개";
	}
	public String getHashTag() {
		return hashTag;
	}
	public String[] getHashTags() {
		if(hashTag == null) {
			return null;
		}
		if(hashTag.length() == 0) {
			return null;
		}
		return hashTag.split(",");
	}
	public void setHashTag(String hashTag) {
		this.hashTag = hashTag;
	}
	public String getMapImg() {
		return mapImg;
	}
	public void setMapImg(String mapImg) {
		this.mapImg = mapImg;
	}
	
	public int getLikeCnt() {
		return likeCnt;
	}
	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}
	public String getPlanType() {
		return planType;
	}
	public void setPlanType(String planType) {
		this.planType = planType;
	}
	
	public User getProfile() {
		return profile;
	}
	public void setProfile(User profile) {
		this.profile = profile;
	}
	@Override
	public String toString() {
		return "Planner [no=" + no + ", userId=" + userId + ", title=" + title + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", member=" + member + ", createDate=" + createDate + ", status=" + status
				+ ", open=" + open + ", hashTag=" + hashTag + ", mapImg=" + mapImg + ", likeCnt=" + likeCnt
				+ ", isSampDate=" + isSampDate + ", planType=" + planType + ", profile=" + profile + "]";
	}
	

}

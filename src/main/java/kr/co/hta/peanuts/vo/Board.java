package kr.co.hta.peanuts.vo;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class Board {

	private int no;
	private String userId;
	private String category;
	private String title;
	private String contents;
	private int view;
	private Date createDate;
	private String status;
	private int planNo;

	private int likes;
	private int together;
	private String profile;
	private List<Reply> replyList;
	
	
	
	public List<Reply> getReplyList() {
		return replyList;
	}
	public void setReplyList(List<Reply> replyList) {
		this.replyList = replyList;
	}
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
	public String getContents() {
		return contents;
	}
	public String getContentsWithBr() {
		if(contents != null) {
			return contents.replaceAll("\n", "<br/>");
		}
		return "";
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getView() {
		return view;
	}
	public void setView(int view) {
		this.view = view;
	}
	public Date getCreateDate() {
		return createDate;
	}
	SimpleDateFormat sdf = new SimpleDateFormat("MM.dd hh:mm");
	public String getCreateDateToString() {
		return sdf.format(createDate);
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
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public int getTogether() {
		return together;
	}
	public void setTogether(int together) {
		this.together = together;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	
	public int getPlanNo() {
		return planNo;
	}
	public void setPlanNo(int planNo) {
		this.planNo = planNo;
	}
	@Override
	public String toString() {
		return "Board [no=" + no + ", userId=" + userId + ", category=" + category + ", title=" + title + ", contents="
				+ contents + ", view=" + view + ", createDate=" + createDate + ", status=" + status + ", planNo="
				+ planNo + ", likes=" + likes + ", together=" + together + ", profile=" + profile + "]";
	}
	
	
}

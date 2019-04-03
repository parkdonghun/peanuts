package kr.co.hta.peanuts.vo;

import java.util.Date;

public class Plaza {

	private int no;
	private String id;
	private String category;
	private String content;
	private Date createDate;
	private String profile;
	private int likes;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	@Override
	public String toString() {
		return "Plaza [no=" + no + ", id=" + id + ", category=" + category + ", content=" + content + ", createDate="
				+ createDate + ", profile=" + profile + ", likes=" + likes + "]";
	}	
}

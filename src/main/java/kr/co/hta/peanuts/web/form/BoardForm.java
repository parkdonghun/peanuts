package kr.co.hta.peanuts.web.form;

import java.text.SimpleDateFormat;
import java.util.Date;

public class BoardForm {

	private int no;
	private String userId;
	private String category;
	private String title;
	private String contents;
	private int view;
	private Date createDate;
	private String status;
	
	private boolean isSameDate;
	private boolean hasReply;
	
	private int people;

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

	public void setTitle(String title) {
		this.title = title;
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

	public int getView() {
		return view;
	}

	public void setView(int view) {
		this.view = view;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	public String getStringCreateDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(this.createDate);
	}
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public boolean getIsSameDate() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String today = sdf.format(new Date());
		String day = sdf.format(createDate);
		
		if (today.equals(day)) {
			return true;
		} else {
			return false;
		}
	}
	
	public boolean getHasReply() {
		return hasReply;
	}
	
	public void setHasReply(boolean hasReply) {
		this.hasReply = hasReply;
	}
	
	public int getPeople() {
		return people;
	}
	public void setPeople(int people) {
		this.people = people;
	}

	@Override
	public String toString() {
		return "BoardForm [no=" + no + ", userId=" + userId + ", category=" + category + ", title=" + title
				+ ", contents=" + contents + ", view=" + view + ", createDate=" + createDate + ", status=" + status
				+ ", isSameDate=" + isSameDate + ", hasReply=" + hasReply + ", people=" + people + "]";
	}
}

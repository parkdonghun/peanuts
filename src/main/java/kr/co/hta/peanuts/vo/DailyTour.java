package kr.co.hta.peanuts.vo;

import java.util.Date;

public class DailyTour {

	private int key;
	private String title;
	private Date createDate;
	private int tourKey;
	
	public int getKey() {
		return key;
	}
	public void setKey(int key) {
		this.key = key;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public int getTourKey() {
		return tourKey;
	}
	public void setTourKey(int tourKey) {
		this.tourKey = tourKey;
	}
	@Override
	public String toString() {
		return "DailyTour [key=" + key + ", title=" + title + ", createDate=" + createDate + ", tourKey=" + tourKey
				+ "]";
	}
	
}

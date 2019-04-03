package kr.co.hta.peanuts.vo;

import java.util.Date;

public class DailyHotel {

	private int key;
	private String title;
	private int term;
	private int hotelKey;
	private Date createDate;
	
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
	public int getTerm() {
		return term;
	}
	public void setTerm(int term) {
		this.term = term;
	}
	public int getHotelKey() {
		return hotelKey;
	}
	public void setHotelKey(int hotelKey) {
		this.hotelKey = hotelKey;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		return "DailyHotel [key=" + key + ", title=" + title + ", term=" + term + ", hotelKey=" + hotelKey
				+ ", createDate=" + createDate + "]";
	}
	
}

package kr.co.hta.peanuts.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Daily {

	private int planNo;
	private int key;
	private int index;
	private Date date;
	
	public int getPlanNo() {
		return planNo;
	}
	public void setPlanNo(int planNo) {
		this.planNo = planNo;
	}
	public int getKey() {
		return key;
	}
	public void setKey(int key) {
		this.key = key;
	}
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	public String getMonth() {
		SimpleDateFormat sdf = new SimpleDateFormat("M");
		return sdf.format(this.date);
	}
	public String getDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("d");
		return sdf.format(this.date);
	}
	public String getWeekDay() {
		SimpleDateFormat sdf = new SimpleDateFormat("EEEE");
		return sdf.format(this.date);
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "Daily [planNo=" + planNo + ", key=" + key + ", index=" + index + ", date=" + date + "]";
	}
	
}

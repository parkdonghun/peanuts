package kr.co.hta.peanuts.vo;

import java.util.Date;

public class TransLocation {

	private int key;
	private int transKey;
	private String category;
	private String startLocation;
	private String startlocationId;
	private String startTime;
	private String endLocation;
	private String endlocationId;
	private String endTime;
	private String memo;
	private Date createDate;
	
	public int getKey() {
		return key;
	}
	public void setKey(int key) {
		this.key = key;
	}
	public int getTransKey() {
		return transKey;
	}
	public void setTransKey(int transKey) {
		this.transKey = transKey;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getStartLocation() {
		return startLocation;
	}
	public void setStartLocation(String startLocation) {
		this.startLocation = startLocation;
	}
	public String getStartlocationId() {
		return startlocationId;
	}
	public void setStartlocationId(String startlocationId) {
		this.startlocationId = startlocationId;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndLocation() {
		return endLocation;
	}
	public void setEndLocation(String endLocation) {
		this.endLocation = endLocation;
	}
	public String getEndlocationId() {
		return endlocationId;
	}
	public void setEndlocationId(String endlocationId) {
		this.endlocationId = endlocationId;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	@Override
	public String toString() {
		return "TransLocation [key=" + key + ", transKey=" + transKey + ", category=" + category + ", startLocation="
				+ startLocation + ", startlocationId=" + startlocationId + ", startTime=" + startTime + ", endLocation="
				+ endLocation + ", endlocationId=" + endlocationId + ", endTime=" + endTime + ", memo=" + memo
				+ ", createDate=" + createDate + "]";
	}
	
}

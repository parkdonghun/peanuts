package kr.co.hta.peanuts.web.form;

public class TransportationForm {
	private int pno;
	private int key;
	private String startLocation;
	private String startTime;
	private String category;
	private String endLocation;
	private String endTime;
	private String memo;
	
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
	public int getKey() {
		return key;
	}
	public void setKey(int key) {
		this.key = key;
	}
	public String getStartLocation() {
		return startLocation;
	}
	public void setStartLocation(String startLocation) {
		this.startLocation = startLocation;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getEndLocation() {
		return endLocation;
	}
	public void setEndLocation(String endLocation) {
		this.endLocation = endLocation;
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
	@Override
	public String toString() {
		return "TransportationForm [pno=" + pno + ", key=" + key + ", startLocation=" + startLocation + ", startTime="
				+ startTime + ", category=" + category + ", endLocation=" + endLocation + ", endTime=" + endTime
				+ ", memo=" + memo + "]";
	}
	
}

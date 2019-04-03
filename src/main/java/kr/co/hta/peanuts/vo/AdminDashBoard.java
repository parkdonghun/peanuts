package kr.co.hta.peanuts.vo;

public class AdminDashBoard {

	private int planNo;
	private String locationId;
	private String locationCity;
	private String locationName;
	private String lineX;
	private String lineY;
	private int cnt;
	private int avg;
	private int date;
	private int month;
	
	private String markers;
	
	public int getPlanNo() {
		return planNo;
	}
	public void setPlanNo(int planNo) {
		this.planNo = planNo;
	}
	public String getLocationId() {
		return locationId;
	}
	public void setLocationId(String locationId) {
		this.locationId = locationId;
	}
	public String getLocationCity() {
		return locationCity;
	}
	public void setLocationCity(String locationCity) {
		this.locationCity = locationCity;
	}
	public String getLocationName() {
		return locationName;
	}
	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}
	public String getLineX() {
		return lineX;
	}
	public void setLineX(String lineX) {
		this.lineX = lineX;
	}
	public String getLineY() {
		return lineY;
	}
	public void setLineY(String lineY) {
		this.lineY = lineY;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getAvg() {
		return avg;
	}
	public void setAvg(int avg) {
		this.avg = avg;
	}
	public int getDate() {
		return date;
	}
	public void setDate(int date) {
		this.date = date;
	}
	public int getMonth() {
		return month;
	}
	public void setMonth(int month) {
		this.month = month;
	}
	public String getMarkers() {
		return markers;
	}
	public void setMarkers(String markers) {
		this.markers = markers;
	}
	@Override
	public String toString() {
		return "AdminDashBoard [planNo=" + planNo + ", locationId=" + locationId + ", locationCity=" + locationCity
				+ ", locationName=" + locationName + ", lineX=" + lineX + ", lineY=" + lineY + ", cnt=" + cnt + ", avg="
				+ avg + ", date=" + date + ", month=" + month + ", markers=" + markers + "]";
	}
}

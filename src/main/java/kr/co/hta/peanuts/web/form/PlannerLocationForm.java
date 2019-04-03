package kr.co.hta.peanuts.web.form;

import java.util.Date;

public class PlannerLocationForm {

	private int planNo;
	private String startDate;
	private String endDate;
	private String locationId;
	
	private String locationCity;
	private String locationName;
	private String lineX;
	private String lineY;
	private Date createDate;
	
	public int getPlanNo() {
		return planNo;
	}
	public void setPlanNo(int planNo) {
		this.planNo = planNo;
	}
	public String getStartDate() {
		return startDate;
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
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	@Override
	public String toString() {
		return "PlannerLocationForm [planNo=" + planNo + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", locationId=" + locationId + ", locationCity=" + locationCity + ", locationName=" + locationName
				+ ", lineX=" + lineX + ", lineY=" + lineY + ", createDate=" + createDate + "]";
	}
}

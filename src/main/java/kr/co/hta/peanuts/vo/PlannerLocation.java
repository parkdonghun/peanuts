package kr.co.hta.peanuts.vo;

import java.util.Date;

public class PlannerLocation {

	private int planNo;
	private Date startDate;
	private Date endDate;
	private Date createDate;
	private String locationId;
	private String locationCode;
	private String locationName;
	
	public int getPlanNo() {
		return planNo;
	}
	public void setPlanNo(int planNo) {
		this.planNo = planNo;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getLocationId() {
		return locationId;
	}
	public void setLocationId(String locationId) {
		this.locationId = locationId;
	}
	public String getLocationCode() {
		return locationCode;
	}
	public void setLocationCode(String locationCode) {
		this.locationCode = locationCode;
	}
	public String getLocationName() {
		return locationName;
	}
	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}
	@Override
	public String toString() {
		return "PlannerLocation [planNo=" + planNo + ", startDate=" + startDate + ", endDate=" + endDate
				+ ", createDate=" + createDate + ", locationId=" + locationId + ", locationCode=" + locationCode
				+ ", locationName=" + locationName + "]";
	}
	
}

package kr.co.hta.peanuts.vo;

public class Location {

	private String id;
	private String code;
	private String city;
	private String name;
	private String lineX;
	private String lineY;
	private String weatherId;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getWeatherId() {
		return weatherId;
	}
	public void setWeatherId(String weatherId) {
		this.weatherId = weatherId;
	}
	
	@Override
	public String toString() {
		return "Location [id=" + id + ", code=" + code + ", city=" + city + ", name=" + name + ", lineX=" + lineX
				+ ", lineY=" + lineY + ", weatherId=" + weatherId + "]";
	}
}

package kr.co.hta.peanuts.vo;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Ticket {

	private int no;
	private String name;
	private Integer price;
	private String category;
	private String images;
	private Double discountRate;
	private Date sellingStart;
	private Date sellingEnd;
	private String locationCity;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public String getPriceToString() {
		DecimalFormat df= new DecimalFormat("#,###");
		if(price != null) {
			Integer finalPrice = (int) (price * ((100 - discountRate)/100));
			return df.format(finalPrice);
		}
		return "";
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getImages() {
		return images;
	}
	public void setImages(String images) {
		this.images = images;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public Double getDiscountRate() {
		return discountRate;
	}
	public void setDiscountRate(Double discountRate) {
		this.discountRate = discountRate;
	}
	public Date getSellingStart() {
		return sellingStart;
	}
	public String getSellingStartToString() {
		if(sellingStart != null) {
			return sdf.format(sellingStart);
		}
		return "";
	}
	public void setSellingStart(Date sellingStart) {
		this.sellingStart = sellingStart;
	}
	public Date getSellingEnd() {
		return sellingEnd;
	}
	public String getSellingEndToString() {
		if(sellingEnd != null) {
			return sdf.format(sellingEnd);
		}
		return "";
	}	
	public Long getSellingEndTime() {
		return sellingEnd.getTime();
	}
	public void setSellingEnd(Date sellingEnd) {
		this.sellingEnd = sellingEnd;
	}
	public String getLocationCity() {
		return locationCity;
	}
	public void setLocationCity(String locationCity) {
		this.locationCity = locationCity;
	}
	
	@Override
	public String toString() {
		return "Ticket [no=" + no + ", name=" + name + ", price=" + price + ", Category=" + category + ", images="
				+ images + ", discountRate=" + discountRate + ", sellingStart=" + sellingStart + ", sellingEnd="
				+ sellingEnd + ", locationCity=" + locationCity + "]";
	}
}

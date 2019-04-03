package kr.co.hta.peanuts.web.form;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

/**
 * @author JHTA
 *
 */
public class AddTicketForm {

	private String name;
	private int price;
	private String category;
	private MultipartFile image;
	private List<MultipartFile> topImages;
	private List<MultipartFile> mainImages;
	private Double discountRate;
	private Date sellingEnd;
	private String locationCity;
	private String cityname;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public MultipartFile getImage() {
		return image;
	}
	public void setImage(MultipartFile image) {
		this.image = image;
	}
	public List<MultipartFile> getTopImages() {
		return topImages;
	}
	public void setTopImages(List<MultipartFile> topImages) {
		this.topImages = topImages;
	}
	public List<MultipartFile> getMainImages() {
		return mainImages;
	}
	public void setMainImages(List<MultipartFile> mainImages) {
		this.mainImages = mainImages;
	}
	public Double getDiscountRate() {
		return discountRate;
	}
	public void setDiscountRate(Double discountRate) {
		this.discountRate = discountRate;
	}
	public Date getSellingEnd() {
		return sellingEnd;
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
	public String getCityname() {
		return cityname;
	}
	public void setCityname(String cityname) {
		this.cityname = cityname;
	}
	@Override
	public String toString() {
		return "AddTicketForm [name=" + name + ", price=" + price + ", category=" + category + ", image=" + image
				+ ", topImages=" + topImages + ", mainImages=" + mainImages + ", discountRate=" + discountRate
				+ ", sellingEnd=" + sellingEnd + ", locationCity=" + locationCity + ", cityname=" + cityname + "]";
	}
}

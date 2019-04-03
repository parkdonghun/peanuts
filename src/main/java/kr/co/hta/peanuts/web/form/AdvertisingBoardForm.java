package kr.co.hta.peanuts.web.form;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class AdvertisingBoardForm {

	private String type;
	private MultipartFile image;
	private String title;
	private String noPwd;
	private Date startDate;
	private String term;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public MultipartFile getImage() {
		return image;
	}
	public void setImage(MultipartFile image) {
		this.image = image;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getNoPwd() {
		return noPwd;
	}
	public void setNoPwd(String noPwd) {
		this.noPwd = noPwd;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public String getTerm() {
		return term;
	}
	public void setTerm(String term) {
		this.term = term;
	}
	@Override
	public String toString() {
		return "AdvertisingBoardForm [type=" + type + ", image=" + image + ", title=" + title + ", noPwd=" + noPwd
				+ ", startDate=" + startDate + ", term=" + term + "]";
	}
	
	
}

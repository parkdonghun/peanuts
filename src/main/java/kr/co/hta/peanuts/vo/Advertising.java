package kr.co.hta.peanuts.vo;

import java.util.Date;

public class Advertising {

	private String id;		// 사업자 아이디
	private String category;
	private String name;
	private String tel;
	private String manager;
	private String email;
	private Date createDate;
	private String pwd;
	private String serial;	// 사업자번호
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getManager() {
		return manager;
	}
	public void setManager(String manager) {
		this.manager = manager;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getSerial() {
		return serial;
	}
	public void setSerial(String serial) {
		this.serial = serial;
	}
	@Override
	public String toString() {
		return "Advertising [id=" + id + ", category=" + category + ", name=" + name + ", tel=" + tel + ", manager="
				+ manager + ", email=" + email + ", createDate=" + createDate + ", pwd=" + pwd + ", serial=" + serial
				+ "]";
	}
	
	
}

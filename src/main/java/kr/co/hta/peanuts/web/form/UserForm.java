package kr.co.hta.peanuts.web.form;

import org.springframework.web.multipart.MultipartFile;

public class UserForm {

	private String name;
	private String id;
	private String pwd;
	private String email;
	private String phone;
	private MultipartFile profile;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public MultipartFile getProfile() {
		return profile;
	}
	public void setProfile(MultipartFile profile) {
		this.profile = profile;
	}
	@Override
	public String toString() {
		return "UserForm [name="+ name +" , id=" + id + ", pwd=" + pwd + ", email=" + email + ", phone=" + phone + ", profile=" + profile
				+ "]";
	}
}

package kr.co.hta.peanuts.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class User {

	private String id;
	private String pwd;
	private String name;
	private String status;
	private String email;
	private String tel;
	private String profile;	
	private Date createDate;
	private int peanuts;
	
	private int repoReplyCnt;
	
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	public String getCreateDateToString() {
		if(createDate != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			return sdf.format(createDate);
		}
		return "";
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public int getRepoReplyCnt() {
		return repoReplyCnt;
	}
	public void setRepoReplyCnt(int repoReplyCnt) {
		this.repoReplyCnt = repoReplyCnt;
	}
	public int getPeanuts() {
		return peanuts;
	}
	public void setPeanuts(int peanuts) {
		this.peanuts = peanuts;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", pwd=" + pwd + ", name=" + name + ", status=" + status + ", email=" + email
				+ ", tel=" + tel + ", profile=" + profile + ", createDate=" + createDate + ", peanuts=" + peanuts
				+ ", repoReplyCnt=" + repoReplyCnt + "]";
	}
}

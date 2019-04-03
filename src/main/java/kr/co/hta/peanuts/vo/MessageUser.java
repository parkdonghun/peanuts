package kr.co.hta.peanuts.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

public class MessageUser {

	private String id;
	private String contents;
	private Date createDate;
	private String status;
	private int msgKey;
	private String profile;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContents() {
		return contents;
	}
	public String getContentsWithBr() {
		return contents.replaceAll("\n", "<br/>");	
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public String getCreateDateToString() {
		return sdf.format(createDate);
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getMsgKey() {
		return msgKey;
	}
	public void setMsgKey(int msgKey) {
		this.msgKey = msgKey;
	}
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	@Override
	public String toString() {
		return "MessageUser [id=" + id + ", contents=" + contents + ", createDate=" + createDate + ", status=" + status
				+ ", msgKey=" + msgKey + ", profile=" + profile + ", sdf=" + sdf + "]";
	}
	
}

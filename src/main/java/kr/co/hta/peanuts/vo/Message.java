package kr.co.hta.peanuts.vo;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class Message {

	private String userId;
	private String contents;
	private String receiver;
	private String status;
	private Date createDate; //발송일
	private int msgKey;
	private Date readDate;
	private Date delDate;
	private String mark;
	private String criteria;
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getContents() {
		return contents;
	}
	public String getContentsWithDots() {
		if(contents.length() <= 25) {
			return contents;
		} else {
			return contents.substring(0, 25)+ "...";
		}
	}
	public String getContentsWithBr() {
		return contents.replaceAll("\n", "<br/>");
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public String getCreateDateToStringWithTime() {
		return sdf.format(createDate);
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public int getMsgKey() {
		return msgKey;
	}
	public void setMsgKey(int msgKey) {
		this.msgKey = msgKey;
	}
	public Date getReadDate() {
		return readDate;
	}
	public String getReadDateToStringWithTime() {
		if(readDate != null) {
			return sdf.format(readDate);
		} else {
			return "";
		}		
	}
	public void setReadDate(Date readDate) {
		this.readDate = readDate;
	}
	public Date getDelDate() {
		return delDate;
	}
	public String getDelDateToStringWithTime() {
		if(delDate != null) {
			return sdf.format(delDate);
		} else {
			return "";
		}			
	}
	public void setDelDate(Date delDate) {
		this.delDate = delDate;
	}
	public String getMark() {
		return mark;
	}
	public void setMark(String mark) {
		this.mark = mark;
	}
	public String getCriteria() {
		return criteria;
	}
	public void setCriteria(String criteria) {
		this.criteria = criteria;
	}
	@Override
	public String toString() {
		return "Message [userId=" + userId + ", contents=" + contents + ", receiver=" + receiver + ", status=" + status
				+ ", createDate=" + createDate + ", msgKey=" + msgKey + ", readDate=" + readDate + ", delDate="
				+ delDate + ", mark=" + mark + ", criteria=" + criteria + ", sdf=" + sdf + "]";
	}

}

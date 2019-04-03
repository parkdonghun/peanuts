package kr.co.hta.peanuts.web.form;

public class DailyHotelForm {

	private int pno;
	private int key;
	private String title;
	private int term;
	
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
	public int getKey() {
		return key;
	}
	public void setKey(int key) {
		this.key = key;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getTerm() {
		return term;
	}
	public void setTerm(int term) {
		this.term = term;
	}
	@Override
	public String toString() {
		return "DailyHotelForm [pno=" + pno + ", key=" + key + ", title=" + title + ", term=" + term + "]";
	}
}

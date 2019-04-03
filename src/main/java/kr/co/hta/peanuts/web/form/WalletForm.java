package kr.co.hta.peanuts.web.form;

public class WalletForm {

	private int pno;
	private int dayIndex;
	private int keyno;
	private String category;
	private String title;
	private int money;
	private String memo;
	
	public int getPno() {
		return pno;
	}
	public void setPno(int pno) {
		this.pno = pno;
	}
	public int getDayIndex() {
		return dayIndex;
	}
	public void setDayIndex(int dayIndex) {
		this.dayIndex = dayIndex;
	}
	public int getKeyno() {
		return keyno;
	}
	public void setKeyno(int keyno) {
		this.keyno = keyno;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getMoney() {
		return money;
	}
	public void setMoney(int money) {
		this.money = money;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	@Override
	public String toString() {
		return "WalletForm [pno=" + pno + ", dayIndex=" + dayIndex + ", keyno=" + keyno + ", category=" + category
				+ ", title=" + title + ", money=" + money + ", memo=" + memo + "]";
	}
	
	
}

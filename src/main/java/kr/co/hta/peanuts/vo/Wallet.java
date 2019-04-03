package kr.co.hta.peanuts.vo;

import java.util.Date;

public class Wallet {

	private int planNo;
	private Date startDate;
	private Date planerDays;
	private int daily;
	private int dailyIndex;
	private String category;
	private String title;
	private int term;
	private int money;
	private String memo;
	private Date createDate;
	private int walletKey;
	private int frgKey;
	
	public int getPlanNo() {
		return planNo;
	}
	public void setPlanNo(int planNo) {
		this.planNo = planNo;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getPlanerDays() {
		return planerDays;
	}
	public void setPlanerDays(Date planerDays) {
		this.planerDays = planerDays;
	}
	public int getDaily() {
		return daily;
	}
	public void setDaily(int daily) {
		this.daily = daily;
	}
	public int getDailyIndex() {
		return dailyIndex;
	}
	public void setDailyIndex(int dailyIndex) {
		this.dailyIndex = dailyIndex;
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
	public int getTerm() {
		return term;
	}
	public void setTerm(int term) {
		this.term = term;
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
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public int getWalletKey() {
		return walletKey;
	}
	public void setWalletKey(int walletKey) {
		this.walletKey = walletKey;
	}
	public int getFrgKey() {
		return frgKey;
	}
	public void setFrgKey(int frgKey) {
		this.frgKey = frgKey;
	}
	@Override
	public String toString() {
		return "Wallet [planNo=" + planNo + ", startDate=" + startDate + ", planerDays=" + planerDays + ", daily="
				+ daily + ", dailyIndex=" + dailyIndex + ", category=" + category + ", title=" + title + ", term="
				+ term + ", money=" + money + ", memo=" + memo + ", createDate=" + createDate + ", walletKey="
				+ walletKey + ", frgKey=" + frgKey + "]";
	}
	
}

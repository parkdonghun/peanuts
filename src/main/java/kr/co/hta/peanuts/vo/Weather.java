package kr.co.hta.peanuts.vo;

public class Weather {

	private String hour;
	private String day;
	private String temp;
	private String tmx;
	private String tmn;
	private String sky;
	private String pty;
	private String wfKor;
	private String wfEn;
	private String pop;
	private String r12;
	private String s12;
	private String ws;
	private String wd;
	private String wdKor;
	private String wdEn;
	private String reh;
	private String r06;
	private String s06;
	public String getHour() {
		return hour;
	}
	public void setHour(String hour) {
		this.hour = hour;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getTemp() {
		return temp;
	}
	public void setTemp(String temp) {
		this.temp = temp;
	}
	public String getTmx() {
		return tmx;
	}
	public void setTmx(String tmx) {
		this.tmx = tmx;
	}
	public String getTmn() {
		return tmn;
	}
	public void setTmn(String tmn) {
		this.tmn = tmn;
	}
	public String getSky() {
		return sky;
	}
	public void setSky(String sky) {
		this.sky = sky;
	}
	public String getPty() {
		return pty;
	}
	public void setPty(String pty) {
		this.pty = pty;
	}
	public String getWfKor() {
		return wfKor;
	}
	public void setWfKor(String wfKor) {
		this.wfKor = wfKor;
	}
	public String getWfEn() {
		return wfEn;
	}
	public void setWfEn(String wfEn) {
		this.wfEn = wfEn;
	}
	public String getPop() {
		return pop;
	}
	public void setPop(String pop) {
		this.pop = pop;
	}
	public String getR12() {
		return r12;
	}
	public void setR12(String r12) {
		this.r12 = r12;
	}
	public String getS12() {
		return s12;
	}
	public void setS12(String s12) {
		this.s12 = s12;
	}
	public String getWs() {
		return ws;
	}
	public void setWs(String ws) {
		this.ws = ws;
	}
	public String getWd() {
		return wd;
	}
	public void setWd(String wd) {
		this.wd = wd;
	}
	public String getWdKor() {
		return wdKor;
	}
	public void setWdKor(String wdKor) {
		this.wdKor = wdKor;
	}
	public String getWdEn() {
		return wdEn;
	}
	public void setWdEn(String wdEn) {
		this.wdEn = wdEn;
	}
	public String getReh() {
		return reh;
	}
	public void setReh(String reh) {
		this.reh = reh;
	}
	public String getR06() {
		return r06;
	}
	public void setR06(String r06) {
		this.r06 = r06;
	}
	public String getS06() {
		return s06;
	}
	public void setS06(String s06) {
		this.s06 = s06;
	}
	
	@Override
	public String toString() {
		return "Weather [hour=" + hour + ", day=" + day + ", temp=" + temp + ", tmx=" + tmx + ", tmn=" + tmn + ", sky="
				+ sky + ", pty=" + pty + ", wfKor=" + wfKor + ", wfEn=" + wfEn + ", pop=" + pop + ", r12=" + r12
				+ ", s12=" + s12 + ", ws=" + ws + ", wd=" + wd + ", wdKor=" + wdKor + ", wdEn=" + wdEn + ", reh=" + reh
				+ ", r06=" + r06 + ", s06=" + s06 + "]";
	}
	
	
	
}

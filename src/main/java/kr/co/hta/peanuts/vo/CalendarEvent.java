package kr.co.hta.peanuts.vo;

public class CalendarEvent {

	private String title;
	private String start;
	private String end;
	private String color;
	private String textColor;
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public String getColor() {
		String[] colors = {
			"#C0392B",
			"#F9690E",
			"#F7CA18",
			"#1E824C",
			"#336E7B",
			"#2C3E50",
			"#947CB0",
			"#E08283",
			"#BDC3C7",
			"#013243",
			"#6C7A89",
			"#947CB0"
		};
		int no = (int) (Math.random()*12)+1;
		return colors[no];
	}
	public String getTextColor() {
		return "#FFFAF0";
	}
	@Override
	public String toString() {
		return "CalendarEvent [title=" + title + ", start=" + start + ", end=" + end + ", color=" + color
				+ ", textColor=" + textColor + "]";
	}
	
}

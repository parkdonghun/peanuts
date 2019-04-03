package kr.co.hta.peanuts.vo;

public class Images {

	private int no;
	private String category;
	private String name;

	// 앨범에서 사용할 인덱스
	private int index;
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
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
	public int getIndex() {
		return index;
	}
	public void setIndex(int index) {
		this.index = index;
	}
	@Override
	public String toString() {
		return "Images [no=" + no + ", category=" + category + ", name=" + name + ", index=" + index + "]";
	}
	
}

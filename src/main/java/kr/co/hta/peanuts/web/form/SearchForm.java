package kr.co.hta.peanuts.web.form;

public class SearchForm {

	private String searchTitle;
	private String searchId;
	private String searchLocations;
	private Integer searchMemebers;
	private String searchTerm;
	private String searchHashtags;
	
	public String getSearchTitle() {
		return searchTitle;
	}
	public void setSearchTitle(String searchTitle) {
		this.searchTitle = searchTitle;
	}
	public String getSearchId() {
		return searchId;
	}
	public void setSearchId(String searchId) {
		this.searchId = searchId;
	}
	public String getSearchLocations() {
		return searchLocations;
	}
	public void setSearchLocations(String searchLocations) {
		this.searchLocations = searchLocations;
	}
	public String[] getArrayLocations() {
		if (searchLocations == null) {
			return null;
		}
		if (searchLocations.isEmpty()) {
			return null;
		}
		return searchLocations.split(",");
	}
	public Integer getSearchMemebers() {
		return searchMemebers;
	}
	public void setSearchMemebers(Integer searchMemebers) {
		this.searchMemebers = searchMemebers;
	}
	public String getSearchTerm() {
		return searchTerm;
	}
	public void setSearchTerm(String searchTerm) {
		this.searchTerm = searchTerm;
	}
	public String getSearchHashtags() {
		return searchHashtags;
	}
	public void setSearchHashtags(String searchHashtags) {
		this.searchHashtags = searchHashtags;
	}
	public String[] getArrayHashtags() {
		if(searchHashtags == null) {
			return null;
		}
		if(searchHashtags.isEmpty()) {
			return null;
		}
		return searchHashtags.split(",");
	}

	@Override
	public String toString() {
		return "SearchForm [searchTitle=" + searchTitle + ", searchId=" + searchId + ", searchLocations="
				+ searchLocations + ", arrayLocations=" +  getArrayLocations() + ", searchMemebers=" + searchMemebers
				+ ", searchTerm=" + searchTerm + ", searchHashtags=" + searchHashtags + ", arrayHashtags="
				+ getArrayHashtags() + "]";
	}
	
}

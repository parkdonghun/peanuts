package kr.co.hta.peanuts.vo;

import java.util.HashMap;
import java.util.Map;

public class Pagination {

	private int totalCnt = 1;		// 전체 컨텐츠 수
	private int totalPageNo;		// 전체 페이지 수 (컨텐츠수 / 10)
	private int totalBlocks;		// 전체 블록수 (페이지수 / nav 올림)
	
	private int beginPage;			// 시작 페이지
	private int endPage;			// 끝 페이지
	private int beginIndex;			// 시작 인덱스
	private int endIndex;			// 끝 인덱스
	
	private int currentBlock = 1;	// 현재 블록
	private int currentPageNo = 1;	// 현재 페이지 수
	
	private int rows = 10;			// 한 화면에 표시할 행의 갯수
	private int nav = 5;			// 한 화면에 표시할 블록의 갯수
	
	public Map<String, Object> pagination(int totalCnt) {
		Map<String, Object> pageInfo = new HashMap<>();
		
		this.totalCnt = totalCnt;
		totalPageNo = (int) Math.ceil((double)totalCnt / rows);
		totalBlocks = (int) Math.ceil((double)totalPageNo / nav);
		currentBlock = (int) Math.ceil((double)currentPageNo / nav);
		
		beginPage = (currentBlock - 1) * nav + 1;
		endPage = currentBlock * nav;
		
		if (currentBlock == totalBlocks) {
			endPage = totalPageNo;
		}
		
		beginIndex = (currentPageNo - 1) * rows + 1;
		endIndex = currentPageNo * rows;
		
		pageInfo.put("totalPageNo", totalPageNo);
		pageInfo.put("totalBlocks", totalBlocks);
		pageInfo.put("currentPageNo", currentPageNo);
		pageInfo.put("currentBlock", currentBlock);
		pageInfo.put("beginPage", beginPage);
		pageInfo.put("endPage", endPage);
		pageInfo.put("beginIndex", beginIndex);
		pageInfo.put("endIndex", endIndex);
		
		return pageInfo;
	}
	
	public Map<String, Object> pagination(int totalCnt, int currentPageNo, int currentBlock) {
		Map<String, Object> pageInfo = new HashMap<>();
		
		this.totalCnt = totalCnt;
		this.currentPageNo = currentPageNo;
		this.currentBlock = currentBlock;
		

		totalPageNo = (int) Math.ceil((double)totalCnt / rows);
		totalBlocks = (int) Math.ceil((double)totalPageNo / nav);
		this.currentBlock = (int) Math.ceil((double)this.currentPageNo / nav);
		
		beginPage = (currentBlock - 1) * nav + 1;
		endPage = currentBlock * nav;

		if (currentBlock == totalBlocks) {
			endPage = totalPageNo;
		}
		
		beginIndex = (currentPageNo - 1) * rows + 1;
		endIndex = currentPageNo * rows;
		
		pageInfo.put("totalPageNo", totalPageNo);
		pageInfo.put("totalBlocks", totalBlocks);
		pageInfo.put("currentPageNo", this.currentPageNo);
		pageInfo.put("currentBlock", this.currentBlock);
		pageInfo.put("beginPage", beginPage);
		pageInfo.put("endPage", endPage);
		pageInfo.put("beginIndex", beginIndex);
		pageInfo.put("endIndex", endIndex);
		
		return pageInfo;
	}

	@Override
	public String toString() {
		return "Pagination [totalPageNo=" + totalPageNo + ", totalBlocks=" + totalBlocks + ", beginPage=" + beginPage
				+ ", endPage=" + endPage + ", beginIndex=" + beginIndex + ", endIndex=" + endIndex + ", currentBlock="
				+ currentBlock + ", currentPageNo=" + currentPageNo + ", rows=" + rows + ", nav=" + nav + "]";
	}
}

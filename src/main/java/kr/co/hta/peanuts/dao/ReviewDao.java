package kr.co.hta.peanuts.dao;

import java.util.HashMap;
import java.util.List;

import kr.co.hta.peanuts.vo.Review;

public interface ReviewDao {
	
	// 티켓의 총 리뷰갯수
	Integer getTicketReviewAmount(int ticketNo);
	// 티켓의 평점당 리뷰 갯수
	HashMap<String,Object> getTicketReviewAmountGroupByGrade(int ticketNo);
	// 티켓의 리뷰 평균값
	Double getTicketGradeAverage(int ticketNo);
	// 티켓의 모든 리뷰이미지
	List<HashMap<String,Object>> getReviewImagesByTicketNo(int ticketNo);
	// 티켓의 모든 리뷰
	List<HashMap<String, Object>> getAllReviewByTicketNo(int ticketNo);
	// 리뷰 추가
	int getBoardSeq();
	void addReview(Review review);
	void addReviewImage(HashMap<String, Object> reviewImage);
	// 리뷰 수정
	void updateReview(HashMap<String, Object> review);
	void updateReviewImage(HashMap<String, Object> reviewImage);
	void addReviewImageByReviewNo(HashMap<String, Object> reviewImage);
	// 해당 리뷰번호의 리뷰
	Review getReviewByReviewNo(int reviewNo);
	HashMap<String, Object> getReviewImageByReviewNo(int reviewNo);
	// 해당 리뷰번호의 리뷰 삭제
	void deleteReview(int reviewNo);
	// 리뷰 10개씩 가져오기
	List<HashMap<String, Object>> getReviewByRange(HashMap<String, Object> index);
	int getReviewCnt(int ticketNo);
	// 리뷰 이미지 갯수
	int getReviewImageCnt(int ticketNo);
}

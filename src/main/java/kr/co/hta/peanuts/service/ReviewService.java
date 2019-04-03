package kr.co.hta.peanuts.service;

import java.util.HashMap;

import org.springframework.transaction.annotation.Transactional;

import kr.co.hta.peanuts.vo.Review;

@Transactional
public interface ReviewService {

	HashMap<String, Object> detail(int ticketNo);
	void addReview(Review review,HashMap<String, Object> reviewImage);
	Review getReviewByReviewNo(int reviewNo);
	HashMap<String, Object> getReviewImageByReviewNo(int reviewNo);
	void updateReview(HashMap<String, Object> review, HashMap<String, Object> reviewImage);
	void deleteReview(int reviewNo);
	HashMap<String, Object> getReviewByRange(int ticketNo, int ModalPageNo);
}

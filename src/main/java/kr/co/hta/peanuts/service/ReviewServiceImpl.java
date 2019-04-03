package kr.co.hta.peanuts.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hta.peanuts.dao.ReviewDao;
import kr.co.hta.peanuts.vo.Review;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
	ReviewDao reviewDao;
	
	@Override
	public HashMap<String, Object> detail(int ticketNo) {
		List<HashMap<String, Object>> reviewList = reviewDao.getAllReviewByTicketNo(ticketNo);
		List<HashMap<String, Object>> reviewImages = reviewDao.getReviewImagesByTicketNo(ticketNo);
		Double ticketGradeAvg = reviewDao.getTicketGradeAverage(ticketNo);
		Integer reviewAmount = reviewDao.getTicketReviewAmount(ticketNo);
		HashMap<String, Object> reviewPercent = reviewDao.getTicketReviewAmountGroupByGrade(ticketNo);
		int imageCnt = reviewDao.getReviewImageCnt(ticketNo);
		
		HashMap<String, Object> review = new HashMap<>();
		review.put("list", reviewList);
		review.put("images", reviewImages);
		review.put("avg", ticketGradeAvg);
		review.put("sum", reviewAmount);
		review.put("ratio", reviewPercent);
		review.put("imgCnt", imageCnt);
		
		return review;
	}
	@Override
	public void addReview(Review review, HashMap<String, Object> reviewImage) {
		int reviewNo = reviewDao.getBoardSeq();
		review.setReviewNo(reviewNo);
		if(reviewImage == null) {
			reviewDao.addReview(review);			
		} else {
			reviewImage.put("reviewNo", reviewNo);
			reviewDao.addReview(review);
			reviewDao.addReviewImage(reviewImage);
		}
	}
	
	@Override
	public Review getReviewByReviewNo(int reviewNo) {
		Review review  = reviewDao.getReviewByReviewNo(reviewNo);
		return review;
	}
	
	@Override
	public HashMap<String, Object> getReviewImageByReviewNo(int reviewNo) {
		HashMap<String, Object> image = reviewDao.getReviewImageByReviewNo(reviewNo);
		return image;
	}
	
	@Override
	public void updateReview(HashMap<String, Object> review, HashMap<String, Object> reviewImage) {
		HashMap<String, Object> existReviewImage = reviewDao.getReviewImageByReviewNo((int)review.get("reviewNo"));
		
		if(reviewImage == null) {
			reviewDao.updateReview(review);
		} else {
			if (existReviewImage == null) {
				reviewDao.updateReview(review);
				reviewDao.addReviewImageByReviewNo(reviewImage);
			} else {
				reviewDao.updateReview(review);
				reviewDao.updateReviewImage(reviewImage);
			}
		}
	}
	
	@Override
	public void deleteReview(int reviewNo) {
		reviewDao.deleteReview(reviewNo);	
	}
	
	@Override
	public HashMap<String, Object> getReviewByRange(int ticketNo, int modalPageNo) {
		int totalCnt = reviewDao.getReviewCnt(ticketNo);
		
		int beginIndex = ((modalPageNo-1)*10+1);
		int endIndex = modalPageNo*10;
		
		HashMap<String, Object> index = new HashMap();
		index.put("ticketNo", ticketNo);
		index.put("beginIndex", beginIndex);
		index.put("endIndex", endIndex);
		
		List<HashMap<String, Object>> list = reviewDao.getReviewByRange(index);
		List<HashMap<String, Object>> reviewImages = reviewDao.getReviewImagesByTicketNo(ticketNo);
		
		HashMap<String, Object> map = new HashMap();
		map.put("list", list);
		map.put("images", reviewImages);
		map.put("totalCnt", totalCnt);
		return map;
	}
}

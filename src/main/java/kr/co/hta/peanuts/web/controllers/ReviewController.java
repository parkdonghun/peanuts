package kr.co.hta.peanuts.web.controllers;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hta.peanuts.service.ReviewService;

@Controller
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	private ReviewService reviewService;
	
	@RequestMapping("/allReview.do")
	public @ResponseBody HashMap<String, Object> getAllReview(int ticketNo, int modalPageNo) {
		
		HashMap<String, Object> map = reviewService.getReviewByRange(ticketNo,modalPageNo);
		return map;
	}
}

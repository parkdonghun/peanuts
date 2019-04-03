package kr.co.hta.peanuts.web.controllers;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.hta.peanuts.annotation.LoginUser;
import kr.co.hta.peanuts.service.OrderService;
import kr.co.hta.peanuts.service.QnaService;
import kr.co.hta.peanuts.service.ReviewService;
import kr.co.hta.peanuts.service.TicketService;
import kr.co.hta.peanuts.service.UserService;
import kr.co.hta.peanuts.vo.Qna;
import kr.co.hta.peanuts.vo.Review;
import kr.co.hta.peanuts.vo.Ticket;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.web.form.AddTicketForm;

@Controller
@RequestMapping("/ticket")
public class TicketController {
	
	@Value("${review.photo.saved.directory}")
	private String path;
	
	@Value("${ticket.photo.saved.directory}")
	private String ticketPath;
	
	private List<MultipartFile> topImages;
	private List<MultipartFile> mainImages;
	
	@Autowired
	private TicketService ticketService;
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private QnaService qnaService;
	@Autowired
	private OrderService orderService;
	@Autowired
	private UserService UserService;

	@RequestMapping("/main.do")
	public String main(Model model) {
		List<Ticket> tickets = ticketService.getTicketList();
		model.addAttribute("tickets", tickets);
		
		return "ticket/main.jsp";
	}
	
	@RequestMapping("/form2.do")
	public String form2() {
		return "ticket/form2.jsp";
	}
	
	@RequestMapping("/detail.do")
	public String detail(@RequestParam int ticketNo, Model model) {
		
		HashMap<String, Object> ticket = ticketService.detail(ticketNo);
		HashMap<String, Object> review = reviewService.detail(ticketNo);
		
		model.addAttribute("ticket", ticket);
		model.addAttribute("review", review);
		return "ticket/detail.jsp";
	}
	
	@RequestMapping("/addReview.do")
	public String addReview( @RequestParam("images") MultipartFile images, @RequestParam("contents") String contents, @RequestParam("grade") int grade, @RequestParam("ticketNo") int ticketNo, Model model, @LoginUser User user) throws IOException {
		Review review = new Review();
		review.setTicketNo(ticketNo);
		review.setTicketGrade(grade);
		review.setUserId(user.getId());
		review.setReviewContents(contents);
		
		HashMap<String, Object> reviewImage = new HashMap<>();
		
		MultipartFile upfile = images;
		if(!images.isEmpty()) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String date = sdf.format(new Date());
			String newFileName = date + user.getId();
			FileCopyUtils.copy(upfile.getBytes(), new File(path,newFileName));
			
			reviewImage.put("ticketNo", ticketNo);
			reviewImage.put("userId", user.getId());
			reviewImage.put("imagesName", newFileName);
		} else {
			reviewImage = null;
		}
		
		reviewService.addReview(review, reviewImage);
		
		
		return "redirect:/ticket/detail.do?ticketNo="+ticketNo;
	}
	@RequestMapping("/addQna.do")
	public String addQna(@RequestParam String questionContents, int ticketNo, @LoginUser User user) {
		
		if(user == null) {
			return "redirect:/user/login.do?err=deny";
		}
		
		Qna qna = new Qna();
		qna.setUser(user);
		qna.setQuestionContents(questionContents);
		qna.setTicketNo(ticketNo);
		
		qnaService.addQna(qna);
		
		return  "redirect:/ticket/detail.do?ticketNo="+ ticketNo;
	}
	
	@RequestMapping("/addQnaAnswer.do")
	public String qnaAnswer(@RequestParam String answerContents, int qnaNo, int ticketNo) {
		
		Qna qna = new Qna();
		qna.setAnswerContents(answerContents);
		qna.setQnaNo(qnaNo);
		qna.setTicketNo(ticketNo);
		qnaService.addQnaAnswer(qna);
		
		return  "redirect:/ticket/detail.do?ticketNo="+ qna.getTicketNo();
	}
	
	@RequestMapping("/ticketOrder.do")
	public String order(@RequestParam int ticketQty, @RequestParam int ticketNo, @LoginUser User user) {
			HashMap<String, Object> order = new HashMap<>();
			order.put("ticketNo", ticketNo);
			order.put("ticketQty", ticketQty);
			order.put("user", user);
			
			Ticket ticket = ticketService.getTicketByNo(ticketNo);
			double price = ticket.getPrice()*((100-ticket.getDiscountRate())/100)*ticketQty;
			int peanuts = user.getPeanuts() + (int) Math.floor((price/5000))*2;
			String userId = user.getId(); 
			HashMap<String, Object> peanut = new HashMap<>();
			peanut.put("peanuts", peanuts);
			peanut.put("userId", userId);
			
			UserService.addPeanut(peanut);
			orderService.addOrder(order);
		return "redirect:/ticket/detail.do?ticketNo=" + ticketNo;
	}
	@RequestMapping("/reviewDetail.do")
	public @ResponseBody HashMap<String, Object> reviewDetail (int reviewNo) {
		
		HashMap<String, Object> map = new HashMap<>();
		Review review = reviewService.getReviewByReviewNo(reviewNo);
		HashMap<String, Object> image = reviewService.getReviewImageByReviewNo(reviewNo);
		
		if (review == null) {
			map.put("success", false);
		} else {
			map.put("success", true);
			map.put("review", review);
			if (image == null) {
				map.put("image", null);
			} else {				
				map.put("image", image);
			}
		}
		
		return map;
	}
	
	@RequestMapping("/updateReview.do")
	public String updateReview(int reviewNo, int grade, String contents, MultipartFile images, int ticketNo, @LoginUser User user) throws IOException {
		HashMap<String, Object> review = new HashMap<>();
		review.put("reviewNo", reviewNo);
		review.put("grade", grade);
		review.put("contents", contents);
		
		MultipartFile upfile = images;
		if(!images.isEmpty()) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String date = sdf.format(new Date());
			String newFileName = date + user.getId();
			FileCopyUtils.copy(upfile.getBytes(), new File(path,newFileName));
			
			HashMap<String, Object> reviewImage = new HashMap<>();
			reviewImage.put("reviewNo", reviewNo);
			reviewImage.put("ticketNo", ticketNo);
			reviewImage.put("userId", user.getId());
			reviewImage.put("imageName", newFileName);
			
			reviewService.updateReview(review, reviewImage);
		} else {
			HashMap<String, Object> reviewImage = null;
			reviewService.updateReview(review, reviewImage);			
		}
		
		return "redirect:/ticket/detail.do?ticketNo=" + ticketNo;
	}
	
	@RequestMapping("/deleteReview.do")
	public String updateReview(int reviewNo, int ticketNo) {
		reviewService.deleteReview(reviewNo);
		
		return "redirect:/ticket/detail.do?ticketNo=" + ticketNo;
	}
	
	@RequestMapping("/deleteQna.do")
	public String deleteQna(int qnaNo,int ticketNo) {
		qnaService.deleteQna(qnaNo);
		
		return "redirect:/ticket/detail.do?ticketNo=" + ticketNo;
	}
	
	@RequestMapping("/list.do")
	public @ResponseBody HashMap<String, Object> list(int currentModalPageNo, int currentModalPageNo2, int currentModalPageNo3, String criteria, String value, String category) {
		
		HashMap<String, Object> cr = new HashMap<>();
		cr.put("beginIndex", (((currentModalPageNo-1)*10)+1));
		cr.put("endIndex", (currentModalPageNo*10));
		cr.put("criteria", criteria);
		cr.put("value", value);
		cr.put("category", category);
		
		int totalCnt = ticketService.getTotalCnt(cr);
		List<Ticket> tickets = ticketService.getCriteriaTicketByPageNo(cr);
		
		cr.put("beginIndex", (((currentModalPageNo2-1)*10)+1));
		cr.put("endIndex", (currentModalPageNo2*10));
		int nTicketCnt = ticketService.getNewTicketCnt(cr);
		List<Ticket> nTickets = ticketService.getNewTicket(cr);
		
		cr.put("beginIndex", (((currentModalPageNo3-1)*10)+1));
		cr.put("endIndex", (currentModalPageNo3*10));
		int deadLineTicketCnt = ticketService.getDeadlineTicketCnt(cr);
		List<Ticket> deadLineTickets = ticketService.getDeadlineTicket(cr);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("tickets", tickets);
		map.put("totalCnt", totalCnt);
		map.put("nTickets", nTickets);
		map.put("nTicketCnt", nTicketCnt);
		map.put("deadLineTickets", deadLineTickets);
		map.put("deadLineTicketCnt", deadLineTicketCnt);
		return map;
	}
	
	@RequestMapping(value="/orderList.do", method=RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> orderList(int pno, String startDate, String endDate, @LoginUser User user) {
		HashMap<String, Object> index = new HashMap<>();
		int beginIndex = (pno-1)*10 +1;
		int endIndex = pno*10;
		index.put("beginIndex", beginIndex);
		index.put("endIndex", endIndex);
		index.put("userId", user.getId());
		index.put("startDate", startDate);
		index.put("endDate", endDate);
		
		HashMap<String, Object> map = new HashMap<>();
		List<HashMap<String, Object>> list = orderService.getAllOrder(index);
		int totalCnt = orderService.getOrderCnt(index);
		boolean success = true;
		if(list.isEmpty()) {
			success = false;
		} 
		map.put("list", list);
		map.put("success", success);
		map.put("totalCnt", totalCnt);
		return map;
	}
	
	@RequestMapping(value="/orderList.do", method=RequestMethod.GET)
	public String orderListPage() {
		
		return "user/orderList.jsp";
	}
	
	@RequestMapping("/orderCancel.do")
	public @ResponseBody HashMap<String, Object> orderCancel(int orderNo) {
		orderService.deleteOrder(orderNo);
		boolean success = true;
		HashMap<String, Object> map = new HashMap<>();
		map.put("success", success);
		return map;
	}
	@RequestMapping("/dashboard.do")
	public @ResponseBody HashMap<String, Object> dashboard() {
		List<Ticket> list = new ArrayList<>();
		HashMap<String, Object> cr = new HashMap<>();
		cr.put("criteria", "list");
		cr.put("value", "asc");
		cr.put("beginIndex", 1);
		cr.put("endIndex", 5);
		list = ticketService.getCriteriaTicketByPageNo(cr);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("list", list);
		return map;
	}
	
	@RequestMapping("/deleteTicket.do")
	public @ResponseBody HashMap<String, Object> deleteTicket(int ticketNo) {
		ticketService.deleteTicket(ticketNo);
		Ticket ticket = ticketService.getTicketByNo(ticketNo);
		boolean success = false;
		if(ticket == null) {
			success = true;
		}
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("success", success);
		return map;
	}
}

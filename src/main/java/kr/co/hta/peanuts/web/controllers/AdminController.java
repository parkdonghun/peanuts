package kr.co.hta.peanuts.web.controllers;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.hta.peanuts.service.AdminService;
import kr.co.hta.peanuts.service.TicketService;
import kr.co.hta.peanuts.vo.AdminDashBoard;
import kr.co.hta.peanuts.vo.Board;
import kr.co.hta.peanuts.vo.Pagination;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.Reply;
import kr.co.hta.peanuts.vo.Ticket;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.web.form.AddTicketForm;
import kr.co.hta.peanuts.web.form.BoardForm;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private AdminService adminService;
	@Autowired
	private TicketService ticketService;
	
	@Value("${ticket.photo.saved.directory}")
	private String ticketPath;
	
	private List<MultipartFile> topImages;
	private List<MultipartFile> mainImages;
	
	//////////////////////////////////////////////////////////////////////////////////
	// 공통으로 사용하는 기능
	// 삭제된 게시글을 검색할 수 있는 기능(할까말까 고민된다)
	@RequestMapping("/getDelBoard.do")
	public String getDelBoard(String category, Model model, HttpSession session, String currentPageNo, String currentBlock) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		int cnt = adminService.boardlistCnt(category);
		
		Pagination page = new Pagination();
		Map<String, Object> getList = new HashMap<>();
		if (currentPageNo != null && currentBlock != null) {
			getList = page.pagination(cnt, Integer.parseInt(currentPageNo), Integer.parseInt(currentBlock));
		} else {
			getList = page.pagination(cnt);
		}
		getList.put("category", category);
		model.addAttribute("page", getList);
		
		List<BoardForm> boards = adminService.getBoardList(getList);
		model.addAttribute("boards", boards);
		
		// 카테고리별로 지운 글들 
		if ("QNA".equals(category)) {
			return "";
		}
		
		return "redirect:/admin/main.do";
	}
	
	// 특정 category에 따른 검색(title, userId, contents)
	@RequestMapping("/searchBoards.do")
	@ResponseBody
	public List<BoardForm> searchBoards(String category, String keyword) {
		Map<String, Object> searchKeyword = new HashMap<>();
		searchKeyword.put("category", category);
		searchKeyword.put("keyword", keyword);
		List<BoardForm> boards = adminService.searchBoards(searchKeyword);
		
		return boards;
	}
	
	// id를 이용해서 특정 회원의 회원정보를 불러오는 기능
	@RequestMapping("/getUserByUserId.do")
	@ResponseBody
	public User getUserByUserId(String userId) {
		return adminService.getUserByUserId(userId);
	}

	//////////////////////////////////////////////////////////////////////////////////
	// admin main 페이지 관련 기능
	// admin main 페이지로 이동
	@RequestMapping("/main.do")
	public String main(Model model, HttpSession session) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		model.addAttribute("totalDays", adminService.totalDays());
		model.addAttribute("totalDaysAvg", adminService.totalDaysAvg());
		model.addAttribute("totalNumOfTravelDays10", adminService.totalNumOfTravelDays(10));
		model.addAttribute("totalNumOfTravelDays20", adminService.totalNumOfTravelDays(20));
		model.addAttribute("totalNumOfTravelDays30", adminService.totalNumOfTravelDays(30));
		model.addAttribute("totalNumOfTravelDays40", adminService.totalNumOfTravelDays(40));
		
		model.addAttribute("mostVisitedImg", adminService.getMapImage(adminService.mostVisited(), "400", "500"));
		model.addAttribute("haveStayedTotalImg", adminService.getMapImage(adminService.haveStayedTotal(), "400", "500"));
		model.addAttribute("haveStayedAvgImg", adminService.getMapImage(adminService.haveStayedAvg(), "400", "500"));
		
		model.addAttribute("mostVisitedTable", adminService.mostVisited());
		model.addAttribute("haveStayedTotalTable", adminService.haveStayedTotal());
		model.addAttribute("haveStayedAvgTable", adminService.haveStayedAvg());
		
		return "admin/main.jsp";
	}
	
	// 월별 여행일
	@RequestMapping("/totalDaysOfMonth.do")
	@ResponseBody
	public List<AdminDashBoard> totalDaysOfMonth(String year) {
		if ("".equals(year)) {
			year = null;
		}
		return adminService.totalDaysOfMonth(year);
	}
	
	
	//////////////////////////////////////////////////////////////////////////////////
	// 회원관리 페이지 관련 기능
	// 회원관리 페이지로 이동
	@RequestMapping("/userList.do")
	public String userManag(Model model, HttpSession session, String currentPageNo, String currentBlock) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		int cnt = adminService.userCnt();
		Pagination page = new Pagination();
		Map<String, Object> getList = new HashMap<>();
		if (currentPageNo != null && currentBlock != null) {
			getList = page.pagination(cnt, Integer.parseInt(currentPageNo), Integer.parseInt(currentBlock));
		} else {
			getList = page.pagination(cnt);
		}
		model.addAttribute("page", getList);
		
		List<User> users = adminService.getUserList(getList);
		model.addAttribute("users", users);
		
		return "admin/userList.jsp";
	}
	
	// keyword로 유저를 검색하는 기능
	@RequestMapping("/searchUser.do")
	@ResponseBody
	public List<User> searchUser(String keyword) {
		List<User> u = adminService.searchUser(keyword);
		return adminService.searchUser(keyword);
	}
	
	// 유저의 상태를 업데이트 하는 기능(status, userId라는 이름으로 받는다)
	@RequestMapping("/updateUserStatusById.do")
	public String updateUserStatusById(String status, String userId, RedirectAttributes redirectAttributes, String currentPageNo, String currentBlock, HttpSession session) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		Map<String, Object> updateInfo = new HashMap<>();
		updateInfo.put("status", status);
		updateInfo.put("userId", userId);
		
		adminService.updateUserStatusById(updateInfo);
		
		redirectAttributes.addAttribute("currentPageNo", currentPageNo);
		redirectAttributes.addAttribute("currentBlock", currentBlock);
		
		return "redirect:/admin/userList.do";
	}
	
	// user_id를 통해 유저 정보를 받아오는 기능은 getUserByUserId.do로 이미 만들어져 있다
	
	// 땅콩 더하기
	@RequestMapping("/plusPeanuts.do")
	public String plusPeanuts(String userId, int plusNum, RedirectAttributes redirectAttributes, String currentPageNo, String currentBlock, HttpSession session) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		Map<String, Object> plpeanuts = new HashMap<>();
		plpeanuts.put("userId", userId);
		plpeanuts.put("peanuts", plusNum);
		
		adminService.plusPeanuts(plpeanuts);
		
		redirectAttributes.addAttribute("currentPageNo", currentPageNo);
		redirectAttributes.addAttribute("currentBlock", currentBlock);
		
		return "redirect:/admin/userList.do";
	}
	
	//////////////////////////////////////////////////////////////////////////////////
	// 신고댓글관리 페이지 관련 기능
	// 신고댓글관리 페이지로 이동
	@RequestMapping("/repoList.do")
	public String repoList(Model model, HttpSession session, String currentPageNo, String currentBlock) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		int cnt = adminService.repoCnt();
		Pagination page = new Pagination();
		Map<String, Object> getList = new HashMap<>();
		if (currentPageNo != null && currentBlock != null) {
			getList = page.pagination(cnt, Integer.parseInt(currentPageNo), Integer.parseInt(currentBlock));
		} else {
			getList = page.pagination(cnt);
		}
		model.addAttribute("page", getList);
		
		List<Reply> replys = adminService.getRepoList(getList);
		model.addAttribute("replys", replys);
		
		return "admin/repoList.jsp";
	}
	
	// 신고댓글을 검색하는 기능
	@RequestMapping("/searchRepo.do")
	@ResponseBody
	public List<Reply> searchRepo(String keyword) {
		return adminService.searchRepo(keyword);
	}
	
	// 신고댓글을 삭제하는 기능
	@RequestMapping("/delRepoByNo.do")
	public String delRepoByNo(int repNo, RedirectAttributes redirectAttributes, String currentPageNo, String currentBlock, HttpSession session) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		adminService.delRepoByNo(repNo);
		
		redirectAttributes.addAttribute("currentPageNo", currentPageNo);
		redirectAttributes.addAttribute("currentBlock", currentBlock);
		
		return "redirect:/admin/repoList.do";
	}
	
	// 신고댓글의 신고를 취소하는 기능
	@RequestMapping("/returnRepoByNo.do")
	public String returnRepoByNo(int repNo, RedirectAttributes redirectAttributes, String currentPageNo, String currentBlock, HttpSession session) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		adminService.returnRepoByNo(repNo);
		
		redirectAttributes.addAttribute("currentPageNo", currentPageNo);
		redirectAttributes.addAttribute("currentBlock", currentBlock);
		
		return "redirect:/admin/repoList.do";
	}
	
	// 댓글 상세페이지를 위한 기능
	@RequestMapping("/getRepoByRepNo.do")
	@ResponseBody
	public Reply getRepoByRepNo(int repNo) {
		return adminService.getRepoByRepNo(repNo);
	}
	
	//////////////////////////////////////////////////////////////////////////////////
	// planner 게시판 관련 기능
	// planner 게시판으로 이동
	@RequestMapping("/planList.do")
	public String plannerList(Model model, HttpSession session, String currentPageNo, String currentBlock) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		int cnt = adminService.planlistCnt();
		
		Pagination page = new Pagination();
		Map<String, Object> getList = new HashMap<>();
		if (currentPageNo != null && currentBlock != null) {
			getList = page.pagination(cnt, Integer.parseInt(currentPageNo), Integer.parseInt(currentBlock));
		} else {
			getList = page.pagination(cnt);
		}
		model.addAttribute("page", getList);
		
		List<Planner> planners = adminService.getPlanList(getList);
		model.addAttribute("planners", planners);
		
		return "admin/planList.jsp";
	}
	
	// planner를 검색하는 기능
	@RequestMapping("/searchPlan.do")
	@ResponseBody
	public List<Planner> searchPlan(String keyword) {
		return adminService.searchPlan(keyword);
	}
	
	// planner를 삭제하는 기능
	@RequestMapping("/delPlanByNo.do")
	public String delPlanByNo(int no, RedirectAttributes redirectAttributes, String currentPageNo, String currentBlock, HttpSession session) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		adminService.delPlanByNo(no);
		
		redirectAttributes.addAttribute("currentPageNo", currentPageNo);
		redirectAttributes.addAttribute("currentBlock", currentBlock);
		
		return "redirect:/admin/planList.do";
	}
	
	//////////////////////////////////////////////////////////////////////////////////
	// qna 게시판 페이지 관련 기능
	// qna list 페이지로 이동
	@RequestMapping("/qnaList.do")
	public String qnaList(Model model, HttpSession session, String currentPageNo, String currentBlock) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		int cnt = adminService.boardlistCnt("QNA");
		
		Pagination page = new Pagination();
		Map<String, Object> getList = new HashMap<>();
		if (currentPageNo != null && currentBlock != null) {
			getList = page.pagination(cnt, Integer.parseInt(currentPageNo), Integer.parseInt(currentBlock));
		} else {
			getList = page.pagination(cnt);
		}
		getList.put("category", "QNA");
		model.addAttribute("page", getList);
		
		List<BoardForm> boards = adminService.getBoardList(getList);
		model.addAttribute("boards", boards);
		
		return "admin/qnaList.jsp";
	}
	
	// qna detail 페이지로 이동
	@RequestMapping("/qnaDetail.do")
	public String qnaDetail(int no, HttpSession session, Model model, String currentPageNo, String currentBlock) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!("ADMIN".equals(loginUser.getStatus()))) {
			return "redirect:/home.do";
		}
		
		BoardForm board = adminService.getBoardByNo(no);
		model.addAttribute("board", board);
		model.addAttribute("currentPageNo", currentPageNo);
		model.addAttribute("currentBlock", currentBlock);
		
		return "admin/qnaDetail.jsp";
	}
	
	// 게시글을 삭제하는 기능
	@RequestMapping("/delQnaByNo.do")
	public String delBoardNo(int no) {
		adminService.delBoardByNo(no);
		return "redirect:/admin/qnaList.do";
	}
	
	// qna에 댓글을 추가하는 기능
	@RequestMapping("/answerQna.do")
	public String answerQna(Reply re, HttpSession session, RedirectAttributes redirectAttributes, String currentPageNo, String currentBlock) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		re.setUserId(loginUser.getId());
		re.setCategory("QNA");
		
		adminService.answerQna(re);
		
		redirectAttributes.addAttribute("no", re.getBoardNo());
		redirectAttributes.addAttribute("currentPageNo", currentPageNo);
		redirectAttributes.addAttribute("currentBlock", currentBlock);
		
		return "redirect:/admin/qnaDetail.do";
	}
	
	// 댓글을 삭제하는 기능
	@RequestMapping("/delQnaReply.do")
	public String delQnaReply(int no, int repNo, RedirectAttributes redirectAttributes, String currentPageNo, String currentBlock, HttpSession session) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		adminService.delQnaReply(repNo);
		
		redirectAttributes.addAttribute("no", no);
		redirectAttributes.addAttribute("currentPageNo", currentPageNo);
		redirectAttributes.addAttribute("currentBlock", currentBlock);
		
		return "redirect:/admin/qnaDetail.do";
	}
	
	// 댓글을 수정하는 기능
	@RequestMapping("/updateQnaReply.do")
	public String updateQnaReply(Reply re, RedirectAttributes redirectAttributes, String currentPageNo, String currentBlock, HttpSession session) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		adminService.updateQnaReply(re);
		
		redirectAttributes.addAttribute("no", re.getBoardNo());
		redirectAttributes.addAttribute("currentPageNo", currentPageNo);
		redirectAttributes.addAttribute("currentBlock", currentBlock);
		
		return "redirect:/admin/qnaDetail.do";
	}
	
	// repNo로 댓글 정보를 가져오는 기능
	@RequestMapping("/getReplyByRepNo.do")
	@ResponseBody
	public Reply getReplyByRepNo(String repNo) {
		Reply reply = new Reply();
		if (repNo != null) {
			reply = adminService.getReplyByRepNo(Integer.parseInt(repNo));
		}
		return reply;
	}
	
	// qna detail 페이지 아래 댓글을 가져오는 기능
	@RequestMapping("/getReplyByBoardNo.do")
	@ResponseBody
	public List<Reply> getReplyByBoardNo(int boardNo) {
		return adminService.getReplyByBoardNo(boardNo);
	}
	
	/////////////////////////////////////////////////////////////////////////////
	// 광장게시판 관련 메소드
	// plaza list로 이동하는 기능
	@RequestMapping("/plazaList.do")
	public String plazaList(Model model, HttpSession session, String currentPageNo, String currentBlock) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		int cnt = adminService.boardlistCnt("ALL");
		
		Pagination page = new Pagination();
		Map<String, Object> getList = new HashMap<>();
		if (currentPageNo != null && currentBlock != null) {
			getList = page.pagination(cnt, Integer.parseInt(currentPageNo), Integer.parseInt(currentBlock));
		} else {
			getList = page.pagination(cnt);
		}
		getList.put("category", "ALL");
		model.addAttribute("page", getList);
		
		List<BoardForm> boards = adminService.getBoardList(getList);
		model.addAttribute("boards", boards);
		
		return "admin/plazaList.jsp";
	}
	
	// board_no를 통해 detail을 가져오는 기능
	@RequestMapping("/plazaDetail.do")
	@ResponseBody
	public BoardForm plazaDetail(int boardNo) {
		return adminService.getBoardByNo(boardNo);
	}
	
	// board_no를 통해 reply를 가져오는 기능
	// getReplyByBoardNo.do 사용하기(qna에 정의해둠)
	
	// 동행게시판 게시글을 삭제하는 기능
	@RequestMapping("/delPlazaByNo.do")
	public String delPlazaByNo(int boardNo, RedirectAttributes redirectAttributes, String currentPageNo, String currentBlock, HttpSession session) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		adminService.delBoardByNo(boardNo);
		
		redirectAttributes.addAttribute("currentPageNo", currentPageNo);
		redirectAttributes.addAttribute("currentBlock", currentBlock);
		
		return "redirect:/admin/plazaList.do";
	}
	
	/////////////////////////////////////////////////////////////////////////////
	// 동행게시판 관련 메소드
	// together list로 이동하는 기능
	@RequestMapping("/togetherList.do")
	public String togetherList(Model model, HttpSession session, String currentPageNo, String currentBlock) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		int cnt = adminService.boardlistCnt("TOGETHER");
		
		Pagination page = new Pagination();
		Map<String, Object> getList = new HashMap<>();
		if (currentPageNo != null && currentBlock != null) {
			getList = page.pagination(cnt, Integer.parseInt(currentPageNo), Integer.parseInt(currentBlock));
		} else {
			getList = page.pagination(cnt);
		}
		getList.put("category", "TOGETHER");
		model.addAttribute("page", getList);
		
		List<BoardForm> boards = adminService.getBoardList(getList);
		model.addAttribute("boards", boards);
		
		return "admin/togetherList.jsp";
	}
	
	// board_no를 통해 detail을 가져오는 기능
	@RequestMapping("/togetherDetail.do")
	@ResponseBody
	public BoardForm togetherDetail(int boardNo) {
		return adminService.getBoardByNo(boardNo);
	}
	
	// board_no를 통해 reply를 가져오는 기능
	// getReplyByBoardNo.do 사용하기(qna에 정의해둠)
	
	// 동행게시판 게시글을 삭제하는 기능
	@RequestMapping("/delTogetherByNo.do")
	public String delTogetherByNo(int boardNo, RedirectAttributes redirectAttributes, String currentPageNo, String currentBlock, HttpSession session) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		adminService.delBoardByNo(boardNo);
		
		redirectAttributes.addAttribute("currentPageNo", currentPageNo);
		redirectAttributes.addAttribute("currentBlock", currentBlock);
		
		return "redirect:/admin/togetherList.do";
	}
	
	/////////////////////////////////////////////////////////////////////////////
	// 티켓게시판 관련 메소드
	@RequestMapping("/ticketList.do")
	public String ticketList(HttpSession session) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		return "admin/ticketList.jsp";
	}
	
	@RequestMapping("/getTicket.do")
	public @ResponseBody HashMap<String, Object> getTicket(String keyword, int pno) {
		HashMap<String, Object> cr = new HashMap<>();
		int beginIndex = (pno-1)*10 +1;
		int endIndex = pno*10;
		cr.put("beginIndex", beginIndex);
		cr.put("endIndex", endIndex);
		cr.put("keyword", keyword);
		
		HashMap<String, Object> map = ticketService.getAdminTickets(cr);
		
		return map;
	}
	
	@RequestMapping("/getTicketByNo.do")
	public @ResponseBody HashMap<String, Object> getTicketByNo(int ticketNo) {
		HashMap<String, Object> map = new HashMap<>();
		Ticket ticket = ticketService.getTicketByNo(ticketNo);
		map.put("ticket", ticket);
		
		return map;
	}
	
	@RequestMapping("/updateTicket.do")
	public String updateTicket (HttpSession session, int no, String name, int price, Double discountRate, Date sellingEnd, String locationCity, MultipartFile images, String category) throws IOException {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		//System.out.println(images.getOriginalFilename());
		String mainImageName = null;
		if(!images.isEmpty()) {
			mainImageName = name+".jpg";
			FileCopyUtils.copy(images.getBytes(), new File(ticketPath, mainImageName));
		}
		
		Ticket ticket =  new Ticket();
		ticket.setNo(no);
		ticket.setName(name);
		ticket.setDiscountRate(discountRate);
		ticket.setPrice(price);
		ticket.setSellingEnd(sellingEnd);
		ticket.setLocationCity(locationCity);
		ticket.setImages(mainImageName);
		ticket.setCategory(category);
		ticketService.updateTicket(ticket);
		return "redirect:/admin/ticketList.do";
	}
	
	@RequestMapping(value="/addTicket.do", method=RequestMethod.GET)
	public String addTicket(HttpSession session) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!"ADMIN".equals(loginUser.getStatus())) {
			return "redirect:/home.do";
		}
		
		return "admin/addTicket.jsp";
	}
	@RequestMapping(value="/addTicket.do", method=RequestMethod.POST)
	public String addTicket(AddTicketForm addTicketForm) throws IOException {
		topImages = addTicketForm.getTopImages();
		mainImages = addTicketForm.getMainImages();
		List<String> ticketTopImages = new ArrayList<>();
		List<String> ticketImages = new ArrayList<>();
		
		int i = 1;
		for(MultipartFile image : topImages) {
			String filename = addTicketForm.getName()+i+".jpg";
			FileCopyUtils.copy(image.getBytes(),new File(ticketPath, filename));
			i +=1;
			ticketTopImages.add(filename);
		}
		for(MultipartFile image : mainImages) {
			String filename = addTicketForm.getName()+i+".jpg";
			FileCopyUtils.copy(image.getBytes(),new File(ticketPath, filename));
			i +=1;
			ticketImages.add(filename);
		}
		
		String mainImageName = addTicketForm.getName()+".jpg";
		MultipartFile mainImage = addTicketForm.getImage();
		FileCopyUtils.copy(mainImage.getBytes(), new File(ticketPath, mainImageName));
		
		ticketService.addTicket(addTicketForm, ticketImages, ticketTopImages);
		
		return "redirect:/admin/ticketList.do";
	}
	/////////////////////////////////////////////////////////////////////////////
	// 업체게시판 관련 메소드

		
}

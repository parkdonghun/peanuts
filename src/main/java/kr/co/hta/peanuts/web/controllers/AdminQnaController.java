package kr.co.hta.peanuts.web.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hta.peanuts.service.AdminQnaService;
import kr.co.hta.peanuts.vo.Pagination;
import kr.co.hta.peanuts.vo.Reply;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.web.form.BoardForm;

@Controller
@RequestMapping("/adQna")
public class AdminQnaController {

	@Autowired
	private AdminQnaService qnaService;
	
	// qna list 페이지로 이동
	@RequestMapping("/qnaList.do")
	public String qnaList(Model model, HttpSession session, String currentPageNo, String currentBlock) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		int cnt = 0;
		if (loginUser != null) {
			cnt = qnaService.listCnt(loginUser.getId());
		}
		
		Pagination page = new Pagination();
		Map<String, Object> pageInfo = new HashMap<>();
		if (currentPageNo != null && currentBlock != null) {
			pageInfo = page.pagination(cnt, Integer.parseInt(currentPageNo), Integer.parseInt(currentBlock));
			
		} else {
			pageInfo = page.pagination(cnt);
		}
		pageInfo.put("userId", loginUser.getId());
		model.addAttribute("page", pageInfo);
		
		List<BoardForm> boards = qnaService.getQnaList(pageInfo);
		model.addAttribute("boards", boards);
		
		return "board/qnaList.jsp";
	}
	
	// qna detail 페이지로 이동
	@RequestMapping("/qnaDetail.do")
	public String qnaDetail(int no, Model model, String currentPageNo, String currentBlock) {
		BoardForm board = qnaService.getQnaByNo(no);
		model.addAttribute("board", board);
		model.addAttribute("currentPageNo", currentPageNo);
		model.addAttribute("currentBlock", currentBlock);
		return "board/qnaDetail.jsp";
	}
	
	// qna detail 페이지 아래 댓글을 가져오는 기능
	@RequestMapping("/getReplyByBoardNo.do")
	@ResponseBody
	public List<Reply> getReplyByBoardNo(int boardNo) {
		return qnaService.getReplyByBoardNo(boardNo);
	}
	
	// qna detail에서 해당 글을 삭제하는 기능
	@RequestMapping("/delBoardByNo.do")
	public String delBoardByNo(int no) {
		qnaService.delBoardByNo(no);
		return "redirect:/adQna/qnaList.do";
	}
	
	// qna detail에서 글 수정하는 페이지로 이동하는 기능
	@RequestMapping("/updateBoardForm.do")
	public String updateBoardForm(int no, Model model) {
		BoardForm board = qnaService.getQnaByNo(no);
		model.addAttribute("board", board);
		return "board/qnaUpdateForm.jsp";
	}
	
	// qna datail에서 해당 글을 수정하는 기능
	@RequestMapping("/updateBoardByNo.do")
	public String updateBoardByNo(BoardForm board) {
		qnaService.updateBoardByNo(board);
		return "redirect:/adQna/qnaList.do";
	}
	
	// 댓글 단 유저(관리자)의 정보를 가져오는 기능
	@RequestMapping("/getUserByUserId.do")
	@ResponseBody
	public User getUserByUserId(String userId) {
		return qnaService.getUserByUserId(userId);
	}
		
	// qna form 페이지로 이동
	@RequestMapping("/qnaForm.do")
	public String qnaForm() {
		return "board/qnaForm.jsp";
	}
	
	// 새 qna 등록
	@RequestMapping("/addNewQna.do")
	public String addNewQna(BoardForm board, HttpSession session) {
		User user = (User) session.getAttribute("LOGIN_USER");
		board.setUserId(user.getId());
		qnaService.addNewQna(board);
		return "redirect:/adQna/qnaList.do";
	}
}

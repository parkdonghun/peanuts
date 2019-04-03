package kr.co.hta.peanuts.web.controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.hta.peanuts.annotation.LoginUser;
import kr.co.hta.peanuts.service.ReplyService;
import kr.co.hta.peanuts.service.TogetherService;
import kr.co.hta.peanuts.vo.Board;
import kr.co.hta.peanuts.vo.Reply;
import kr.co.hta.peanuts.vo.User;

@Controller
@RequestMapping("/reply")
public class ReplyController {

	@Autowired
	private ReplyService replyService;
	
	// 게시글 조회
	@RequestMapping("/reply.do")
	public String reply(int pno, @LoginUser User user, Model model) {
		if(user == null) {
			return "redirect:/user/login.do?err=fail";
		}
		
		List<Board> boardList = replyService.getBoardsByPlanNo(pno);
		model.addAttribute("boardList", boardList);
		model.addAttribute("pno", pno);
		
		return "reply/reply.jsp";
	}
	
	// 게시글 작성
	@RequestMapping("/addBoard.do")
	public String addBoard(Board board,  @LoginUser User user) throws Exception {
		if(user == null) {
			return "redirect:/user/login.do?err=fail";
		}
		
		board.setUserId(user.getId());
		replyService.addBoard(board);
		
		
		return "redirect:/reply/reply.do?pno=" + board.getPlanNo();
	}
	
	// 댓글 작성
	@RequestMapping("/addReply.do")
	public String addReply(Reply reply, int planNo, @LoginUser User user) {
		if(user == null) {
			return "redirect:/user/login.do?err=fail";
		}
		reply.setUserId(user.getId());
		
		replyService.addReply(reply);
		
		return "redirect:/reply/reply.do?pno=" + planNo;
	}
	
	//댓글 수정
	@RequestMapping("/reModi.do")
	@ResponseBody
	public String reModi(@RequestParam("repNo") int repNo, String contents) {
		Reply reply = new Reply();
		reply.setRepNo(repNo);
		reply.setContents(contents);
		replyService.reModiByNo(reply);
		
		return "success";
	}
	
	//댓글 삭제
	@RequestMapping("/redel.do")
	@ResponseBody
	public String reDel(@RequestParam("repNo") int no) {
		replyService.reDelByNo(no);
		return "success";
	}
	
	// 신고
	@RequestMapping("/reByNoReport.do")
	@ResponseBody
	public String reByNoReport(@RequestParam("repNo") int repNo) {
		
		Reply reply = new Reply();
		reply.setRepNo(repNo);
		reply.setStatus("REPORT");
		replyService.reByNoReport(reply);
		
		return "success";
			
	}
	
}






















package kr.co.hta.peanuts.web.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hta.peanuts.service.TogetherService;
import kr.co.hta.peanuts.vo.Board;
import kr.co.hta.peanuts.vo.Reply;
import kr.co.hta.peanuts.vo.Together;
import kr.co.hta.peanuts.vo.TogetherPart;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.web.form.BoardForm;

@Controller
@RequestMapping("/together")
public class TogetherController {

	@Autowired
	TogetherService togetherService;
	
	@RequestMapping("/together.do")
	public String together(Model model) {
		model.addAttribute("topTogethers", togetherService.getTopBoards());
		return "/board/together.jsp";
	}
	
	@RequestMapping("/getAllTogethers.do")
	@ResponseBody
	public List<Board> getAllTogethers(String by, String key) {
		return togetherService.getTogetherBoards(by, key);
	}
	
	@RequestMapping("/getTopJoin.do")
	@ResponseBody
	public List<Board> getTopJoin() {
		return togetherService.getTogetherTopJoin();
	}
	
	@RequestMapping("/getTopLikes.do")
	@ResponseBody
	public List<Board> getTopLikes() {
		return togetherService.getTogetherTopLikes();
	}
	
	@RequestMapping("/getBoardDetail.do")
	@ResponseBody
	public Map<String, Object> getBoardDetail(int no, HttpSession session) {
		User user = (User) session.getAttribute("LOGIN_USER"); 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bno", no);
		map.put("id", user.getId());
		
		Map<String, Object> data = new HashMap<String, Object>();
		//해당 게시글 조회수 올리기
		togetherService.viewBoard(no);
		//해당 로그인 유저가 해당 글을 좋아요했는지 여부
		data.put("hasLiked", togetherService.hasLiked(map));
		//해당 로그인 유저가 해당 글에 동행참여했는지 여부
		data.put("hasJoined", togetherService.hasJoined(map));
		//좋아요를 포함한 게시글 정보
		data.put("boardDetail", togetherService.getBoardDetail(no));
		//해당 게시글 댓글 갯수 
		data.put("replyCnt", togetherService.getReplyCnt(no));
		return data;
	}
	
	@RequestMapping("/getAllJoiner.do")
	@ResponseBody
	public List<TogetherPart> getAllJoiner(int no) {
		return togetherService.getAllJoiner(no);
	}
	
	@RequestMapping("/likeBoard.do")
	@ResponseBody
	public void likeBoard(int no, HttpSession session) {
		User user = (User) session.getAttribute("LOGIN_USER"); 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bno", no);
		map.put("id", user.getId());
		togetherService.likeBoard(map);
	}

	@RequestMapping("/unlikeBoard.do")
	@ResponseBody
	public void unlikeBoard(int no, HttpSession session) {
		User user = (User) session.getAttribute("LOGIN_USER"); 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bno", no);
		map.put("id", user.getId());
		togetherService.unLikeBoard(map);
	}
	
	@RequestMapping("/addJoin.do")
	@ResponseBody
	public void addJoin(int no, HttpSession session) {
		User user = (User) session.getAttribute("LOGIN_USER"); 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bno", no);
		map.put("id", user.getId());
		togetherService.joinBoard(map);
	}
	
	@RequestMapping("/cancelJoin.do")
	@ResponseBody
	public void cancelJoin(int no, HttpSession session) {
		User user = (User) session.getAttribute("LOGIN_USER"); 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bno", no);
		map.put("id", user.getId());
		togetherService.cancelJoinBoard(map);
	}
	
	@RequestMapping("/getAllReplys.do")
	@ResponseBody
	public List<Reply> getAllReplys(int no) {
		return togetherService.getAllReplys(no);
	}
	
	@RequestMapping("/addReply.do")
	@ResponseBody
	public Reply addReply(int no, String contents, HttpSession session) {
		
		//로그인 유저 땅콩갯수 + 1
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) session.getAttribute("LOGIN_USER"); 	
		map.put("id", user.getId());
		map.put("peanuts", 1);
		togetherService.addPeanuts(map);
		
		//댓글추가하기
		int currVal = togetherService.getReplySeq();
		Reply reply = new Reply();
		reply.setBoardNo(no);
		reply.setRepNo(currVal);
		reply.setUserId(user.getId());
		reply.setContents(contents);
		togetherService.addReply(reply);
		return togetherService.getReply(currVal);
	}
	
	@RequestMapping("/modifyReply.do")
	@ResponseBody
	public Reply modifyReply(int no, String contents) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("repNo", no);
		map.put("contents", contents);
		togetherService.modifyReply(map);
		return togetherService.getReply(no);
	}
	
	@RequestMapping("/delReply.do")
	@ResponseBody
	public void delReply(int no) {
		togetherService.delReply(no);
	}
	
	@RequestMapping("/reportReply.do")
	@ResponseBody
	public void reportReply(int no) {
		togetherService.reportReply(no);
	}
	
	@RequestMapping("/addNewBoard.do")
	public String addNewBoard(BoardForm boardForm) {
		if(boardForm.getNo() != 0) {
			Board board = new Board();
			BeanUtils.copyProperties(boardForm, board);
			togetherService.modifyBoard(board);
			return "redirect:/together/together.do";
		} else {
			//해당 유저 땅콩 3개 증정
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("peanuts", 3);
			map.put("id", boardForm.getUserId());
			togetherService.addPeanuts(map);
			
			Board board = new Board();
			BeanUtils.copyProperties(boardForm, board);
			togetherService.addNewBoard(board);
			return "redirect:/together/together.do";
		}
	}
	
	@RequestMapping("/delBoard.do")
	public String delBoard(int no) {
		togetherService.deleteBoard(no);
		return "redirect:/together/together.do";
	}
	
	@RequestMapping("/getBoard.do")
	@ResponseBody
	public Board getBoard(int no) {
		return togetherService.getBoardDetail(no);
	}
	
	@RequestMapping("getMyTogethers.do")
	@ResponseBody
	public List<Together> getMyTogethers(HttpSession session) {
		User user = (User) session.getAttribute("LOGIN_USER"); 	
		String id = user.getId();
		return togetherService.getMyTogethers(id);
	}
	
	@RequestMapping("/cancelSelectedTogethers.do")
	@ResponseBody
	public void cancelSelectedTogethers(@RequestBody String[] keys, HttpSession session) {
		User user = (User) session.getAttribute("LOGIN_USER"); 	
		String id = user.getId();
		togetherService.cancelMyTogethers(id, keys);
	}
	
}

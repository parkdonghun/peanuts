package kr.co.hta.peanuts.web.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hta.peanuts.annotation.LoginUser;
import kr.co.hta.peanuts.service.PlazaService;
import kr.co.hta.peanuts.vo.Likes;
import kr.co.hta.peanuts.vo.Plaza;
import kr.co.hta.peanuts.vo.Reply;
import kr.co.hta.peanuts.vo.User;

@Controller
@RequestMapping("/board")
public class PlazaController {
	
	@Autowired
	private PlazaService plazaService;
	//광장게시판 홈
	@RequestMapping("/plaza.do")
	public String view() {
		return "board/plaza.jsp";
	}
	//광장게시판 전체 불러오기 (ajax)
	@RequestMapping("/allplaza.do")
	@ResponseBody
	public Map<String, Object> plazaList(int currentPageNo, String option, String keyword, int currentNo) {
		
		Map<String, Object> pageInfo = new HashMap();
		pageInfo.put("beginIndex", (((currentPageNo-1)*10)+1));
		pageInfo.put("endIndex", (currentPageNo*10));
		pageInfo.put("option", option);
		pageInfo.put("keyword", keyword);
		pageInfo.put("no", currentNo);
		
		int totalCnt = plazaService.plazaCnt(pageInfo);
		
		Map<String, Object> map = new HashMap();
		List<Plaza> Allplaza = plazaService.getAllPlaza(pageInfo); //일반게시글 전체
		List<Plaza> bestplaza = plazaService.bestPlazalist(); //좋아요 베스트5글 
		List<Reply> newReply = plazaService.newReList(); //최신5글
		map.put("list", Allplaza);
		map.put("best", bestplaza);
		map.put("newRe", newReply);
		map.put("page", pageInfo);
		map.put("totalCnt", totalCnt);
		return map;
	}
	//게시글 입력
	@RequestMapping("/addplaza.do")
	public String addPlaza(@LoginUser User user, String content) {
		Plaza plaza = new Plaza();
		plaza.setId(user.getId());
		plaza.setContent(content);
		
		plazaService.addPlaza(plaza);
		Map<String, Object> map = new HashMap();
		map.put("id", user.getId());
		map.put("peanuts", 3);
		plazaService.addpeanuts(map);
		return "redirect:/board/plaza.do";
	}
	//광장게시판 댓글 조회 (ajax)
	@RequestMapping("/reply.do")
	@ResponseBody
	public List<Reply> reply(int no) {
		List<Reply> re = plazaService.getReplyByNo(no);
		return re;
	}
	//댓글 등록
	@RequestMapping("/addRe.do")
	public String addRe(@LoginUser User user, int boardNo, String contents) {
		Reply re = new Reply();
		re.setUserId(user.getId());
		re.setBoardNo(boardNo);
		re.setContents(contents);
		
		plazaService.addReply(re);
		Map<String, Object> map = new HashMap();
		map.put("id", user.getId());
		map.put("peanuts", 1);
		plazaService.addpeanuts(map);
		return "redirect:/board/plaza.do";
	}
	//광장게시글 수정
	@RequestMapping("/listModi.do")
	public String listModi(@RequestParam("no") int no, String content) {
		Plaza plaza = new Plaza();
		plaza.setNo(no);
		plaza.setContent(content);
		plazaService.listModiByNo(plaza);
		return "redirect:/board/plaza.do";
	}
	//광장게시글 삭제
	@RequestMapping("/listdel.do")
	public String listDel(@RequestParam("no") int no) {
		plazaService.listDelByNo(no);
		return "redirect:/board/plaza.do";
	}
	//댓글 수정
	@RequestMapping("/reModi.do")
	public String reModi(@RequestParam("reno") int no, String contents) {
		Reply re = new Reply();
		re.setRepNo(no);
		re.setContents(contents);
		plazaService.reModiByNo(re);
		return "redirect:/board/plaza.do";
	}
	//댓글 삭제
	@RequestMapping("/redel.do")
	public String reDel(@RequestParam("reno") int no) {
		plazaService.reDelByNo(no);
		return "redirect:/board/plaza.do";
	}
	//좋아요 추가 및 취소
	@RequestMapping("/addlike.do")
	public String addlike(@RequestParam("no") int no, @LoginUser User user) {	
		Likes like = new Likes();
		like.setNo(no);
		like.setUserId(user.getId());
		int cnt = plazaService.getUserIdLike(like);
		if(cnt == 0) {
			plazaService.addlike(like); //좋아요 추가
		} else {
			plazaService.dellike(like.getNo()); //좋아요 취소
			return "redirect:/board/plaza.do?like=cancel";
		}
		return "redirect:/board/plaza.do";
	}
	// 댓글 신고하기
	@RequestMapping("/report.do")
	public String report(@RequestParam("no") int no) {
		plazaService.getByNoReport(no);
		return "redirect:/board/plaza.do?reply=report";
	}

}


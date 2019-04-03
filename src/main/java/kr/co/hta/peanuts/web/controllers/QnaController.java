package kr.co.hta.peanuts.web.controllers;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hta.peanuts.service.QnaService;

@Controller
@RequestMapping("/qna")
public class QnaController {

	@Autowired
	private QnaService qnaService;
	
	@RequestMapping("/allQna.do")
	public @ResponseBody HashMap<String, Object> getAllQna(int ticketNo, int pno) {
		int beginIndex = ((pno-1)*10 +1);
		int endIndex = pno*10;
		HashMap<String, Object> index = new HashMap();
		index.put("ticketNo", ticketNo);
		index.put("beginIndex", beginIndex);
		index.put("endIndex", endIndex);
		
		List<HashMap<String, Object>> qnas = qnaService.getAllQna(index);
		int totalCnt = qnaService.getAllQnaCnt(ticketNo);
		
		HashMap<String, Object> map = new HashMap();
		map.put("qnas", qnas);
		map.put("totalCnt", totalCnt);
		
		return map;
	}
	
	@RequestMapping("/getQna.do")
	public @ResponseBody HashMap<String, Object> getAllQna(int qnaNo) {
		HashMap<String, Object> qna = qnaService.getQnaByNo(qnaNo);
		return qna;
	}
	
	@RequestMapping("/deleteQnaAnswer.do")
	public String deleteQnaAnswer(int qnaNo, int ticketNo) {
		qnaService.deleteQnaAnswer(qnaNo);
		
		return  "redirect:/ticket/detail.do?ticketNo="+ ticketNo;
	}
}

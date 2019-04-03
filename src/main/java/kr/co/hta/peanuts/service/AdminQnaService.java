package kr.co.hta.peanuts.service;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import kr.co.hta.peanuts.vo.Reply;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.web.form.BoardForm;

@Transactional
public interface AdminQnaService {

	List<BoardForm> getQnaList(Map<String, Object> getList);
	BoardForm getQnaByNo(int no);
	void addNewQna(BoardForm board);
	List<Reply> getReplyByBoardNo(int boardNo);
	void answerQna(Reply re);
	
	void delBoardByNo(int no);
	void updateBoardByNo(BoardForm board);
	
	User getUserByUserId(String userId);
	
	// 페이징
	int listCnt(String userId);
}

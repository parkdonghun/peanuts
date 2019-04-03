package kr.co.hta.peanuts.dao;

import java.util.List;
import java.util.Map;

import kr.co.hta.peanuts.vo.Reply;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.web.form.BoardForm;

public interface AdminQnaDao {

	List<BoardForm> getQnaList(Map<String, Object> getList);
	BoardForm getQnaByNo(int no);
	void addNewQna(BoardForm board);
	List<Reply> getReplyByBoardNo(int boardNo);
	void answerQna(Reply re);
	
	void delBoardByNo(int no);
	void updateBoardByNo(BoardForm board);
	void plusView(int no);
	
	User getUserByUserId(String userId);
	
	// 페이징
	int listCnt(String userId);
}

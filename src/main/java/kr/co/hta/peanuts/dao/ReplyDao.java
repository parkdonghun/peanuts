package kr.co.hta.peanuts.dao;

import java.util.List;

import kr.co.hta.peanuts.vo.Board;
import kr.co.hta.peanuts.vo.Reply;

public interface ReplyDao {

	// 조회
	List<Reply> getReplyByBoardNo(int boardNo);
	// 댓글 등록
	void addReply(Reply reply);
	
	void addBoard(Board board);
	
	List<Board> getBoardsByPlanNo(int planNo);

	void reModiByNo(Reply reply);
	
	void reDelByNo(int no);
	
	void reByNoReport(Reply reply);
	
}

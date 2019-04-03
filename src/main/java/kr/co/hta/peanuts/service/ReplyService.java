package kr.co.hta.peanuts.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.co.hta.peanuts.vo.Board;
import kr.co.hta.peanuts.vo.Reply;

@Service
public interface ReplyService {

	void addReply(Reply reply);
	
	void addBoard(Board board);
	
	List<Board> getBoardsByPlanNo(int planNo);
	
	void reModiByNo(Reply reply);
	
	void reDelByNo(int no);
	
	void reByNoReport(Reply reply);
}

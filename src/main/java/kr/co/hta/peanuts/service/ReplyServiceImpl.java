package kr.co.hta.peanuts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hta.peanuts.dao.ReplyDao;
import kr.co.hta.peanuts.vo.Board;
import kr.co.hta.peanuts.vo.Reply;

@Service
public class ReplyServiceImpl implements ReplyService{

	@Autowired
	private ReplyDao replyDao;
	
	
	@Override
	public void addReply(Reply addReply) {
		replyDao.addReply(addReply);
		
	}
	
	@Override
	public void addBoard(Board board) {
		replyDao.addBoard(board);
	}
	
	@Override
	public List<Board> getBoardsByPlanNo(int planNo) {
		List<Board> boardList = replyDao.getBoardsByPlanNo(planNo);
		for (Board board : boardList) {
			List<Reply> replyList = replyDao.getReplyByBoardNo(board.getNo());
			board.setReplyList(replyList);
		}
		return boardList;
	}
	
	@Override
	public void reModiByNo(Reply reply) {
		replyDao.reModiByNo(reply);
	}

	@Override
	public void reDelByNo(int no) {
		replyDao.reDelByNo(no);
	}
	
	@Override
	public void reByNoReport(Reply reply) {
		replyDao.reByNoReport(reply);
		
	}
	
}

package kr.co.hta.peanuts.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hta.peanuts.dao.AdminQnaDao;
import kr.co.hta.peanuts.vo.Reply;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.web.form.BoardForm;

@Service
public class AdminQnaServiceImpl implements AdminQnaService {

	@Autowired
	private AdminQnaDao qnaDao;
	
	@Override
	public List<BoardForm> getQnaList(Map<String, Object> getList) {
		List<BoardForm> sampleBoards = qnaDao.getQnaList(getList);
		List<BoardForm> boards = new ArrayList<>();
		
		for (BoardForm board : sampleBoards) {
			List<Reply> replys = qnaDao.getReplyByBoardNo(board.getNo());
			if (replys.size() != 0) {
				board.setHasReply(true);
			}
			if (board.getStatus().equals("E")) {
				boards.add(board);
			}
		}
		
		return boards;
	}
	
	@Override
	public BoardForm getQnaByNo(int no) {
		qnaDao.plusView(no);
		return qnaDao.getQnaByNo(no);
	}
	
	@Override
	public void addNewQna(BoardForm board) {
		qnaDao.addNewQna(board);
	}
	
	@Override
	public List<Reply> getReplyByBoardNo(int boardNo) {
		return qnaDao.getReplyByBoardNo(boardNo);
	}
	
	@Override
	public void answerQna(Reply re) {
		qnaDao.answerQna(re);
	}
	
	@Override
	public void delBoardByNo(int no) {
		qnaDao.delBoardByNo(no);
	}
	
	@Override
	public void updateBoardByNo(BoardForm board) {
		qnaDao.updateBoardByNo(board);
	}
	
	@Override
	public User getUserByUserId(String userId) {
		return qnaDao.getUserByUserId(userId);
	}
	
	@Override
	public int listCnt(String userId) {
		return qnaDao.listCnt(userId);
	}
}

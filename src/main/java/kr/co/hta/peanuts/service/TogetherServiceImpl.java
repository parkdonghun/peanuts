package kr.co.hta.peanuts.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hta.peanuts.dao.TogetherDao;
import kr.co.hta.peanuts.vo.Board;
import kr.co.hta.peanuts.vo.Reply;
import kr.co.hta.peanuts.vo.Together;
import kr.co.hta.peanuts.vo.TogetherPart;

@Service
public class TogetherServiceImpl implements TogetherService {

	@Autowired
	TogetherDao togetherDao;
	
	@Override
	public List<Board> getTopBoards() {
		return togetherDao.getTopBoards();
	}
	@Override
	public List<Board> getTogetherBoards(String by, String keyword) {
		Map<String, Object> map = new HashMap<String, Object>();
		if(by.equals("all")) {
			map.put("all", keyword);
		} else if(by.equals("writer")) {
			map.put("writer", keyword);
		} else if(by.equals("title")) {
			map.put("title", keyword);
		} else if(by.equals("contents")) {
			map.put("contents", keyword);
		} else if(by.equals("board")) {
			map.put("board", keyword);
		}
		return togetherDao.getTogetherBoards(map);
	}
	@Override
	public List<Board> getTogetherTopJoin() {
		return togetherDao.getTogetherTopJoin();
	}
	@Override
	public List<Board> getTogetherTopLikes() {
		return togetherDao.getTogetherTopLikes();
	}
	@Override
	public Board getBoardDetail(int bno) {
		return togetherDao.getBoardDetail(bno);
	}
	@Override
	public List<TogetherPart> getAllJoiner(int bno) {
		return togetherDao.getAllJoiner(bno);
	}
	@Override
	public int hasJoined(Map<String, Object> map) {
		return togetherDao.hasJoined(map);
	}
	@Override
	public void joinBoard(Map<String, Object> map) {
		togetherDao.joinBoard(map);
	}
	@Override
	public void cancelJoinBoard(Map<String, Object> map) {
		togetherDao.cancelJoinBoard(map);
	}
	@Override
	public int hasLiked(Map<String, Object> map) {
		return togetherDao.hasLiked(map);
	}
	@Override
	public void likeBoard(Map<String, Object> map) {
		togetherDao.likeBoard(map);
	}
	@Override
	public void unLikeBoard(Map<String, Object> map) {
		togetherDao.unLikeBoard(map);
	}
	@Override
	public void viewBoard(int bno) {
		togetherDao.viewBoard(bno);
	}
	@Override
	public Integer getReplyCnt(int bno) {
		int replyCnt = 0;
		if(togetherDao.getReplyCnt(bno) != null) {
			replyCnt = togetherDao.getReplyCnt(bno);
		}
		return replyCnt;
	}
	@Override
	public List<Reply> getAllReplys(int bno) {
		return togetherDao.getAllReplys(bno);
	}
	@Override
	public void addPeanuts(Map<String, Object> map) {
		togetherDao.addPeanuts(map);
	}
	@Override
	public int getReplySeq() {
		return togetherDao.getReplySeq();
	}
	@Override
	public void addReply(Reply reply) {
		togetherDao.addReply(reply);
	}
	@Override
	public Reply getReply(int rno) {
		return togetherDao.getReply(rno);
	}
	@Override
	public void modifyReply(Map<String, Object> map) {
		togetherDao.modifyReply(map);
	}
	@Override
	public void delReply(int rno) {
		togetherDao.delReply(rno);
	}
	@Override
	public void reportReply(int rno) {
		togetherDao.reportReply(rno);
	}
	@Override
	public void addNewBoard(Board board) {
		togetherDao.addNewBoard(board);
	}
	@Override
	public void modifyBoard(Board board) {
		togetherDao.modifyBoard(board);
	}
	@Override
	public void deleteBoard(int bno) {
		togetherDao.deleteBoard(bno);
	}
	@Override
	public List<Together> getMyTogethers(String id) {
		return togetherDao.getMyTogethers(id);
	}
	@Override
	public void cancelMyTogethers(String id, String[] keys) {
		if(id.length() != 0) {
			for(int i=0; i<keys.length; i++) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", id);
				map.put("bno", keys[i]);
				togetherDao.cancelJoinBoard(map);
			}
		}
	}
}

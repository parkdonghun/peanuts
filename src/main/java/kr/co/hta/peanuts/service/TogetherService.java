package kr.co.hta.peanuts.service;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import kr.co.hta.peanuts.vo.Board;
import kr.co.hta.peanuts.vo.Reply;
import kr.co.hta.peanuts.vo.Together;
import kr.co.hta.peanuts.vo.TogetherPart;

@Transactional
public interface TogetherService {

	List<Board> getTopBoards();
	List<Board> getTogetherBoards(String by, String keyword);
	List<Board> getTogetherTopJoin();
	List<Board> getTogetherTopLikes();	
	Board getBoardDetail(int bno);
	List<TogetherPart> getAllJoiner(int bno);
	int hasJoined(Map<String, Object> map);
	void joinBoard(Map<String, Object> map);
	void cancelJoinBoard(Map<String, Object> map);	
	int hasLiked(Map<String, Object> map);
	void likeBoard(Map<String, Object> map);
	void unLikeBoard(Map<String, Object> map);
	void viewBoard(int bno);	
	Integer getReplyCnt(int bno);
	List<Reply> getAllReplys(int bno);
	void addPeanuts(Map<String, Object> map);
	int getReplySeq();
	void addReply(Reply reply);
	Reply getReply(int rno);	
	void modifyReply(Map<String, Object> map);
	void delReply(int rno);
	void reportReply(int rno);
	void addNewBoard(Board board);
	void modifyBoard(Board board);
	void deleteBoard(int bno);
	List<Together> getMyTogethers(String id);
	void cancelMyTogethers(String id, String[] keys);
}

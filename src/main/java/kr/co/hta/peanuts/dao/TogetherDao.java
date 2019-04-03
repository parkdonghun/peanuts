package kr.co.hta.peanuts.dao;

import java.util.List;
import java.util.Map;

import kr.co.hta.peanuts.vo.Board;
import kr.co.hta.peanuts.vo.Reply;
import kr.co.hta.peanuts.vo.Together;
import kr.co.hta.peanuts.vo.TogetherPart;

public interface TogetherDao {

	//최근 일주일 조회수 탑 3 동행 게시글
	List<Board> getTopBoards();
	//전체 동행게시글 조회
	List<Board> getTogetherBoards(Map<String, Object> map);
	//최근3개월 동행 참여수 탑 5
	List<Board> getTogetherTopJoin();
	//최근3개월 좋아요 탑5
	List<Board> getTogetherTopLikes();
	//해당 게시글 정보 가져오기 (좋아요수까지)
	Board getBoardDetail(int bno);
	//해당 게시글에 동행참여한 참여자 리스트 가져오기
	List<TogetherPart> getAllJoiner(int bno);
	//해당 게시글 동행 참여 여부
	int hasJoined(Map<String, Object> map);
	//해당 게시글 동행 참여
	void joinBoard(Map<String, Object> map);
	//해당 게시글 동행 참여취소
	void cancelJoinBoard(Map<String, Object> map);
	//해당 게시글 좋아요 여부
	int hasLiked(Map<String, Object> map);
	//해당 게시글 좋아요 +1
	void likeBoard(Map<String, Object> map);
	//해당 게시글 좋아요 -1
	void unLikeBoard(Map<String, Object> map);
	//해당 게시글 조회수 +1
	void viewBoard(int bno);
	//해당 게시글의 댓글 갯수 조회
	Integer getReplyCnt(int bno);
	//해당 게시글의 메인 댓글 가져오기 + 유저 프사
	List<Reply> getAllReplys(int bno);
	//로그인 유저 땅콩갯수 + 1 or 3
	void addPeanuts(Map<String, Object> map);
	//현재 댓글시퀀스 조회하기
	int getReplySeq();
	//댓글추가하기
	void addReply(Reply reply);
	//해당 번호, 댓글 조회해오기
	Reply getReply(int rno);
	//수정된 댓글 내용 업데이트하기
	void modifyReply(Map<String, Object> map);
	//해당 댓글 지우기
	void delReply(int rno);
	//해당 댓글 신고하기
	void reportReply(int rno);
	//새로운 동행게시글 추가하기
	void addNewBoard(Board board);
	//수정된 게시글 재등록
	void modifyBoard(Board board);
	//게시글 삭제
	void deleteBoard(int bno);
	//로그인 유저가 동행참여한 모든게시글 리스트 가져오기
	List<Together> getMyTogethers(String id);
}

package kr.co.hta.peanuts.service;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import kr.co.hta.peanuts.vo.AdminDashBoard;
import kr.co.hta.peanuts.vo.Board;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.Reply;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.web.form.BoardForm;

@Transactional
public interface AdminService {

	// 공통 메소드
	void plusView(int boardNo);
	List<Reply> getReplyByBoardNo(int boardNo);
	int boardlistCnt(String cetegory);
	List<BoardForm> getBoardList(Map<String, Object> getList);
	BoardForm getBoardByNo(int boardNo);
	void delBoardByNo(int no);
	
	List<BoardForm> searchBoards(Map<String, Object> searchKeyword);
	
	User getUserByUserId(String userId);
	
	// 회원관리 관련 메소드
	int userCnt();
	List<User> getUserList(Map<String, Object> getList);
	List<User> searchUser(String keyword);
	void updateUserStatusById(Map<String, Object> updateInfo);
	void plusPeanuts(Map<String, Object> peanuts);
	
	// 신고 댓글 관련 메소드
	int repoCnt();
	List<Reply> getRepoList(Map<String, Object> getList);
	List<Reply> searchRepo(String keyword);
	void delRepoByNo(int repNo);
	void returnRepoByNo(int repNo);
	Reply getRepoByRepNo(int repNo);
	
	// planner 관련 메소드
	int planlistCnt();
	List<Planner> getPlanList(Map<String, Object> getList);
	List<Planner> searchPlan(String keyword);
	void delPlanByNo(int no);
	Planner getPlanByNo(int no);
	
	// qna 관련 메소드 - list, detail 순서
	void answerQna(Reply re);
	void delQnaReply(int reNo);
	void updateQnaReply(Reply re);
	Reply getReplyByRepNo(int repNo);
	
	// 광장게시판 관련 메소드
	
	// 동행게시판 관련 메소드
	int getTogetherPersonCnt(int boardNo);
	
	// 티켓게시판 관련 메소드
	
	// 업체게시판 관련 메소드
	
	// admin main page 관련 메소드
	int totalDays();
	int totalDaysAvg();
	int totalNumOfTravelDays(int days);	// 10, 20, 30, 40
	List<AdminDashBoard> totalDaysOfMonth(String year); // 0이면 년도지정x
	List<AdminDashBoard> mostVisited();
	List<AdminDashBoard> haveStayedTotal();
	List<AdminDashBoard> haveStayedAvg();
	String getMapImage(List<AdminDashBoard> marks, String width, String height);
}

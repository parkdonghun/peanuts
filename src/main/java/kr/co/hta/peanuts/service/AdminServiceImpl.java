package kr.co.hta.peanuts.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hta.peanuts.dao.AdminDao;
import kr.co.hta.peanuts.vo.AdminDashBoard;
import kr.co.hta.peanuts.vo.Board;
import kr.co.hta.peanuts.vo.Location;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.Reply;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.web.form.BoardForm;
import kr.co.hta.peanuts.web.form.PlannerLocationForm;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDao adminDao;

	/////////////////////////////////////////////////////////////////////////////	
	// 공통 메소드
	@Override
	public void plusView(int boardNo) {
		adminDao.plusView(boardNo);
	}
	
	@Override
	public List<Reply> getReplyByBoardNo(int boardNo) {
		List<Reply> replys = adminDao.getReplyByBoardNo(boardNo);
		for (Reply reply : replys) {
			User user = adminDao.getUserByUserId(reply.getUserId());
			reply.setProfile(user.getProfile());
		}
		
		return replys;
	}
	
	@Override
	public int boardlistCnt(String cetegory) {
		return adminDao.boardlistCnt(cetegory);
	}
	
	@Override
	public List<BoardForm> getBoardList(Map<String, Object> getList) {
		List<BoardForm> boards = adminDao.getBoardList(getList);
		
		for (BoardForm board : boards) {
			// 댓글이 달렸는지 안달렸는지 알 수 있는 기능
			List<Reply> replys = adminDao.getReplyByBoardNo(board.getNo());
			if (replys.size() != 0) {
				board.setHasReply(true);
			}
			
			// together의 동행인수 구해서 넣기
			if ("TOGETHER".equals(board.getCategory())) {
				int people = 0;
				people = adminDao.getTogetherPersonCnt(board.getNo());
				board.setPeople(people);
			}
		}
		
		return boards;
	}
	
	@Override
	public BoardForm getBoardByNo(int boardNo) {
		BoardForm board = adminDao.getBoardByNo(boardNo);
		List<Reply> replys = adminDao.getReplyByBoardNo(board.getNo());
		
		// 해당글에 댓글이 존재하는지 여부를 확인한다
		if (replys.size() != 0) {
			board.setHasReply(true);
		}
		
		// together의 동행인수 구해서 넣기
		if ("TOGETHER".equals(board.getCategory())) {
			int people = 0;
			people = adminDao.getTogetherPersonCnt(board.getNo());
			board.setPeople(people);
		}
		
		return board;
	}
	
	@Override
	public void delBoardByNo(int no) {
		adminDao.delBoardByNo(no);
	}
	
	@Override
	public List<BoardForm> searchBoards(Map<String, Object> searchKeyword) {
		List<BoardForm> boards = adminDao.searchBoards(searchKeyword);
		
		for (BoardForm board : boards) {
			// 해당 글에 댓글이 있는지 여부를 반환한다
			List<Reply> replys = adminDao.getReplyByBoardNo(board.getNo());
			if (replys.size() != 0) {
				board.setHasReply(true);
			}
			
			// together의 동행인수 구해서 넣기
			if ("TOGETHER".equals(board.getCategory())) {
				int people = 0;
				people = adminDao.getTogetherPersonCnt(board.getNo());
				board.setPeople(people);
			}
		}
		
		return boards;
	}
	
	@Override
	public User getUserByUserId(String userId) {
		return adminDao.getUserByUserId(userId);
	}
	
	/////////////////////////////////////////////////////////////////////////////
	// 회원관리 관련 메소드
	@Override
	public int userCnt() {
		return adminDao.userCnt();
	}
	
	@Override
	public List<User> getUserList(Map<String, Object> getList) {
		List<User> users = adminDao.getUserList(getList);
		int repoCnt = 0;
		
		for (User user : users) {
			repoCnt = adminDao.getRepoCntById(user.getId());
			user.setRepoReplyCnt(repoCnt);
		}
			
		return users;
	}
	
	@Override
	public List<User> searchUser(String keyword) {
		return adminDao.searchUser(keyword);
	}
	
	@Override
	public void updateUserStatusById(Map<String, Object> updateInfo) {
		adminDao.updateUserStatusById(updateInfo);
	}
	
	@Override
	public void plusPeanuts(Map<String, Object> peanuts) {
		adminDao.plusPeanuts(peanuts);
	}
	
	/////////////////////////////////////////////////////////////////////////////
	// report reply 관련 메소드
	@Override
	public int repoCnt() {
		return adminDao.repoCnt();
	}
	
	@Override
	public List<Reply> getRepoList(Map<String, Object> getList) {
		return adminDao.getRepoList(getList);
	}
	
	@Override
	public List<Reply> searchRepo(String keyword) {
		return adminDao.searchRepo(keyword);
	}
	
	@Override
	public void delRepoByNo(int repNo) {
		adminDao.delRepoByNo(repNo);
	}
	
	@Override
	public void returnRepoByNo(int repNo) {
		adminDao.returnRepoByNo(repNo);
	}
	
	@Override
	public Reply getRepoByRepNo(int repNo) {
		return adminDao.getRepoByRepNo(repNo);
	}
	
	/////////////////////////////////////////////////////////////////////////////
	// planner 관련 메소드
	@Override
	public int planlistCnt() {
		return adminDao.planlistCnt();
	}
	
	@Override
	public List<Planner> getPlanList(Map<String, Object> getList) {
		return adminDao.getPlanList(getList);
	}
	
	@Override
	public List<Planner> searchPlan(String keyword) {
		return adminDao.searchPlan(keyword);
	}
	
	@Override
	public void delPlanByNo(int no) {
		adminDao.delPlanByNo(no);
	}
	
	@Override
	public Planner getPlanByNo(int no) {
		return adminDao.getPlanByNo(no);
	}
	
	/////////////////////////////////////////////////////////////////////////////	
	// qna 관련 메소드 - list, detail 순서
	@Override
	public void answerQna(Reply re) {
		adminDao.answerQna(re);
	}
	
	@Override
	public void delQnaReply(int reNo) {
		adminDao.delQnaReply(reNo);
	}
	
	@Override
	public void updateQnaReply(Reply re) {
		adminDao.updateQnaReply(re);
	}
	
	@Override
	public Reply getReplyByRepNo(int repNo) {
		return adminDao.getReplyByRepNo(repNo);
	}

	/////////////////////////////////////////////////////////////////////////////
	// 광장게시판 관련 메소드
	

	/////////////////////////////////////////////////////////////////////////////
	// 동행게시판 관련 메소드
	@Override
	public int getTogetherPersonCnt(int boardNo) {
		return adminDao.getTogetherPersonCnt(boardNo);
	}
	
	/////////////////////////////////////////////////////////////////////////////
	// 티켓게시판 관련 메소드
	
	/////////////////////////////////////////////////////////////////////////////
	// 업체게시판 관련 메소드
	
	/////////////////////////////////////////////////////////////////////////////
	// admin main page 관련 메소드
	@Override
	public int totalDays() {
		return adminDao.totalDays();
	}
	
	@Override
	public int totalDaysAvg() {
		return adminDao.totalDaysAvg();
	}
	
	@Override
	public int totalNumOfTravelDays(int days) {
		return adminDao.totalNumOfTravelDays(days);
	}
	
	@Override
	public List<AdminDashBoard> totalDaysOfMonth(String year) {
		return adminDao.totalDaysOfMonth(year);
	}
	
	@Override
	public List<AdminDashBoard> mostVisited() {
		return adminDao.mostVisited();
	}
	
	@Override
	public List<AdminDashBoard> haveStayedTotal() {
		return adminDao.haveStayedTotal();
	}
	
	@Override
	public List<AdminDashBoard> haveStayedAvg() {
		return adminDao.haveStayedAvg();
	}
	
	// <img src="${mapImg }">
	// 이런 형식으로 쓰기
	public String getMapImage(List<AdminDashBoard> marks, String width, String height) {
		String markers = "";
		for (int i=0; i<9; i++) {
			AdminDashBoard mark = marks.get(i);
			markers += "&markers=size:mid%7Ccolor:0xff0000%7Clabel:"+(i+1)+"%7C" + mark.getLineX() + "," + mark.getLineY();
		}
		
		String mapImg = "https://maps.googleapis.com/maps/api/staticmap"
				+ "?size=" + width + "x" + height
				+ "&maptype=roadmap"
				+ "&scale=1"
				+ markers
				+ "&key=AIzaSyCcqLcnhoN-_GQw1a9bJXgR0xq8Qvi3W4U";
		
		return mapImg;
	}
	
}

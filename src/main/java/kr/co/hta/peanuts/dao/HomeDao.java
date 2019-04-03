package kr.co.hta.peanuts.dao;

import java.util.List;
import java.util.Map;

import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.Ticket;
import kr.co.hta.peanuts.vo.User;

public interface HomeDao {
	
	//메인 플래너 top4 출력
	List<Planner> planTopList();
	//메인 티켓 top6 출력
	List<Ticket> ticketTopList(Map<String, String> map);
	//플래너 정보 조회하기
	Planner getPlannerInfo(int pno);
	//플래너 생성유저의 유저정보조회하기
	User getUserInfo(int pno);
	//플래너의 좋아요 갯수 조회하기
	int getPlannerLikes(int pno);
	//플래너의 댓글 갯수 조회하기
	int getPlannerReply(int pno);
	//해당 플래너 제목 수정하기
	void modifyPlannerNm(Map<String, Object> map);
	//해당 플래너 삭제하기
	void deletePlanner(int pno);
	//해당 플래너 좋아요여부
	Integer hasLikedPlanner(Map<String, Object> map);
	//해당 플래너 좋아요하기
	void likePlanner(Map<String, Object> map);
	//해당 플래너 좋아요취소하기
	void unlikePlanner(Map<String, Object> map);
}

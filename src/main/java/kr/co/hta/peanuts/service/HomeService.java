package kr.co.hta.peanuts.service;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.Ticket;
import kr.co.hta.peanuts.vo.User;

@Transactional
public interface HomeService {
	
	Planner getPlannerInfo(int pno);
	User getUserInfo(int pno);
	int getPlannerLikes(int pno);
	int getPlannerReply(int pno);	
	void modifyPlannerNm(Map<String, Object> map);
	void deletePlanner(int pno);
	List<Planner> planTopList();
	List<Ticket> ticketTopList(Map<String, String> map);
	Integer hasLikedPlanner(Map<String, Object> map);
	void likePlanner(Map<String, Object> map);
	void unlikePlanner(Map<String, Object> map);

}
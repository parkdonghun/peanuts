package kr.co.hta.peanuts.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hta.peanuts.dao.HomeDao;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.Ticket;
import kr.co.hta.peanuts.vo.User;

@Service
public class HomeServiceImpl implements HomeService {

	@Autowired
	HomeDao homeDao;
	
	@Override
	public List<Planner> planTopList() {
		List<Planner> plans = homeDao.planTopList();
		return plans;
	}
	@Override
	public List<Ticket> ticketTopList(Map<String, String> map) {
		List<Ticket> tickets = homeDao.ticketTopList(map);
		return tickets;
	}
	@Override
	public Planner getPlannerInfo(int pno) {
		return homeDao.getPlannerInfo(pno);
	}
	@Override
	public User getUserInfo(int pno) {
		return homeDao.getUserInfo(pno);
	}
	@Override
	public int getPlannerLikes(int pno) {
		return homeDao.getPlannerLikes(pno);
	}
	@Override
	public int getPlannerReply(int pno) {
		return homeDao.getPlannerReply(pno);
	}
	@Override
	public void modifyPlannerNm(Map<String, Object> map) {
		homeDao.modifyPlannerNm(map);
	}
	@Override
	public void deletePlanner(int pno) {
		homeDao.deletePlanner(pno);
	}
	@Override
	public Integer hasLikedPlanner(Map<String, Object> map) {
		return homeDao.hasLikedPlanner(map);
	}
	@Override
	public void likePlanner(Map<String, Object> map) {
		homeDao.likePlanner(map);
	}
	@Override
	public void unlikePlanner(Map<String, Object> map) {
		homeDao.unlikePlanner(map);
	}
}

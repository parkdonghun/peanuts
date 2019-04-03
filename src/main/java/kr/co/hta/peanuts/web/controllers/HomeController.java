package kr.co.hta.peanuts.web.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hta.peanuts.service.HomeService;
import kr.co.hta.peanuts.service.MapService;
import kr.co.hta.peanuts.service.UserService;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.Ticket;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.web.form.SearchForm;


@Controller
public class HomeController {

	@Autowired
	HomeService homeService;
	@Autowired
	UserService userService;
	@Autowired
	MapService mapService;
	
	@RequestMapping("/home.do")
	public String  home() {
		return "home.jsp";
	}
	@RequestMapping("/planlist.do")
	@ResponseBody
	public Map<String, Object> homelist(){
		List<Planner> plans = homeService.planTopList();
		for(Planner plan : plans) {
			String mapContent = mapService.getMapImage(plan.getNo(), "160", "230");
			plan.setMapImg(mapContent);
			User profile = homeService.getUserInfo(plan.getNo());
			plan.setProfile(profile);	
		}
		Map<String, Object> map = new HashMap<>();
		map.put("topList", plans);
		return map;
	}
	@RequestMapping("/ticketlist.do")
	@ResponseBody
	public List<Ticket> ticketlist(@RequestParam("value") String value){
		
		Map<String, String> map = new HashMap<>();
		map.put("location", value);
		
		List<Ticket> tickets = homeService.ticketTopList(map);
		return tickets;
	}
	
	@RequestMapping("/planner.do")
	@ResponseBody
	public Map<String, Object> planner(int pno, HttpSession session) {
		//플래너정보
		Planner planner = homeService.getPlannerInfo(pno);
		//플래너 생성유저정보
		User user = homeService.getUserInfo(pno);
		//플래너 좋아요여부
		User loginuser = (User) session.getAttribute("LOGIN_USER");
		Map<String, Object> dataMap = new HashMap<>();
		dataMap.put("pno", pno);
		if(loginuser != null) {
			dataMap.put("id", loginuser.getId());
		}
		int hasLiked = homeService.hasLikedPlanner(dataMap);
		//플래너 좋아요수
		int likes = homeService.getPlannerLikes(pno);
		//플래너 댓글수
		int reply = homeService.getPlannerReply(pno);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("planner", planner);
		map.put("user", user);
		map.put("hasLiked", hasLiked);
		map.put("likes", likes);
		map.put("reply", reply);
		map.put("loginUser", loginuser.getId());
		return map;
	}
	
	@RequestMapping("/modifyPNm.do")
	@ResponseBody
	public Planner modifyPNm(String name, int pno) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("modifyPNm", name);
		map.put("pno", pno);
		homeService.modifyPlannerNm(map);
		return homeService.getPlannerInfo(pno);
	}
	
	@RequestMapping("/delPlanner.do")
	public String delPlanner(int pno, HttpSession session) {
		User user = (User) session.getAttribute("LOGIN_USER");
		homeService.deletePlanner(pno);
		return "redirect:/user/mypage.do?id=" + user.getId();
	}
	
	@RequestMapping("/getMiniUser.do")
	@ResponseBody
	public User getMiniUser(String id) {
		return userService.getUserDetail(id);
	}
	
	@RequestMapping("/likePlanner.do")
	@ResponseBody
	public void likePlanner(int pno, HttpSession session) {
		User user = (User) session.getAttribute("LOGIN_USER");
		Map<String, Object> map = new HashMap<>();
		map.put("pno",pno);
		map.put("id", user.getId());
		homeService.likePlanner(map);
	}
	
	@RequestMapping("/unlikePlanner.do")
	@ResponseBody
	public void unlikePlanner(int pno, HttpSession session) {
		User user = (User) session.getAttribute("LOGIN_USER");
		Map<String, Object> map = new HashMap<>();
		map.put("pno",pno);
		map.put("id", user.getId());
		homeService.unlikePlanner(map);
	}
	
}

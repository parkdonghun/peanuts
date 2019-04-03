package kr.co.hta.peanuts.web.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.hta.peanuts.service.MapService;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.User;

@Controller
@RequestMapping("/planner")
public class PlannerController {

	@Autowired MapService mapService;
	
	@RequestMapping("/dashboard.do")
	public String dashboard(int pno, HttpSession session, Model model) {
		User user = (User) session.getAttribute("LOGIN_USER");
		if(user == null) {
			return "redirect:/user/login.do?err=deny";
		}
		Planner planner = mapService.getPlannerByNo(pno);
		boolean isWriter = false;
		if (user.getId().equals(planner.getUserId())) {
			isWriter = true;
		}
		model.addAttribute("isWriter", isWriter);
		
		String mapImg = mapService.getMapImage(pno, "470", "380");
		model.addAttribute("mapImg", mapImg);
		
		model.addAttribute("pno", pno);
		model.addAttribute("endDate", planner.getEndDate());
		model.addAttribute("status", planner.getStatus());
		return "planner/dashboard.jsp";
	}
	
}

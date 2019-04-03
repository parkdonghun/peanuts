package kr.co.hta.peanuts.web.controllers;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.hta.peanuts.annotation.LoginUser;
import kr.co.hta.peanuts.service.MapService;
import kr.co.hta.peanuts.vo.Daily;
import kr.co.hta.peanuts.vo.Location;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.PlannerLocation;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.web.form.PlannerLocationForm;

@Controller
@RequestMapping("/map")
public class MapController {

	@Autowired
	private MapService mapService;
	
	// planner를 삭제하는 기능(해당 planner를 삭제시키고 addPlanForm으로 이동한다)
	@RequestMapping("/delPlanner.do")
	public String delPlanner(HttpSession session) {
		Planner planner = (Planner) session.getAttribute("planner");
		mapService.delInsertToMap(planner.getNo());
		session.removeAttribute("planner");
		
		return "redirect:/map/addPlanForm.do";
	}
	
	// addNewPlan으로 진입하는 기능
	@RequestMapping("/addPlanForm.do")
	public String addPlanForm(@LoginUser User user) {
		if (user == null) {
			return "redirect:/home.do?fail=login";
		}
		return "map/addNewPlan.jsp";
	}
	
	// 새로운 planner를 생성함과 동시에 해당 날짜에 맞는 daily 테이블을 생성해서 key를 부여하기
	@RequestMapping("/addPlan.do")
	public String addPlan(Planner planner, HttpSession session) throws ParseException {
		User user = (User) session.getAttribute("LOGIN_USER");
		// 새로운 planner 생성
		int planNo = mapService.getPlanSeq();
		planner.setNo(planNo);
		planner.setUserId(user.getId());
		
		mapService.addNewPlan(planner);
		
		// daily key 생성
		int dates = mapService.dailyNum(planner);
		
		for (int i=0; i<dates; i++) {
			Daily daily = new Daily();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date startDate = sdf.parse(planner.getStartDate());
			
			Calendar c = Calendar.getInstance();
			c.setTime(startDate);		// 여행 시작일
			c.add(Calendar.DATE, i);	// 여행시작일 + i
			Date output = c.getTime();
			
			daily.setPlanNo(planner.getNo());
			daily.setIndex(i+1);
			daily.setDate(output);
			
			mapService.addNewDaily(daily);
		}
		
		session.setAttribute("planner", planner);
		return "redirect:/map/map.do";
	}
	
	// map.jsp로 이동하는 기능
	@RequestMapping("/map.do")
	public String map(HttpSession session, Model model, String pno) {
		Planner planner = (Planner) session.getAttribute("planner");
		
		if (pno != null) {
			// 만약 pno로 값을 받아왔으면
			int planNo = Integer.parseInt(pno);
			planner = mapService.getPlannerByNo(planNo);
			session.removeAttribute("planner");
			session.setAttribute("planner", planner);
			
		} else if (planner != null) {
			// session을 통해 planner을 전달해줬으면 값을 바로 넘긴다
			
		} else {
			// 만약 pno도 없고 session에 planner도 없으면 메인 화면으로 보낸다
			return "redirect:/map/addPlanForm.do";
			
		}
		
		// 달력의 min값을 설정해준다
		String minDate = mapService.getMinDate(planner.getNo());
		model.addAttribute("minDate", minDate);
		
		return "map/map.jsp";
	}
	
	// city로 name을 찾고, name으로 해당 id를 찾아내는 기능
	@RequestMapping("/getLocation.do")
	@ResponseBody
	public List<Location> getLocation(Location location) {
		return mapService.getLocation(location);
	}
	
	// PlannerLocation에 데이터를 넣어준다
	// RedirectAttributes는 redirect할때 한번 데이터를 넘겨줄 수 있게 도와준다
	// planner를 session에 넣어놨기 때문에 RedirectAttributes redirectAttributes는 필요없어보이지만 일단 놔둠 
	@RequestMapping("/addPL.do")
	public String addPL(PlannerLocationForm pl, RedirectAttributes redirectAttributes) {
		Planner planner = mapService.addPL(pl);
		redirectAttributes.addFlashAttribute("planner", planner);
		return "redirect:/map/map.do";
	}
	
	// planNo이 일치하는 일정의 plannerLocation을 불러온다
	@RequestMapping("/getPLByPno.do")
	@ResponseBody
	public List<PlannerLocationForm> getPLByPno(int planNo) {
		return mapService.getPLByPno(planNo);
	}
	
	// planNo와 locationId로 일정을 삭제한다
	@RequestMapping("/delPLByPnoAndLid.do")
	public String delPLByPnoAndLid(HttpSession session) {
		Planner planner = (Planner) session.getAttribute("planner");
		mapService.delPLByPnoAndLid(planner.getNo());
		return "redirect:/map/map.do";
	}
	
	
	// img page를 로딩하는 기능
	@RequestMapping("/getMapImg.do")
	public String getMapImg(Model model) {
		String mapImg = mapService.getMapImage(30, "100", "150");
		model.addAttribute("mapImg", mapImg);
		return "map/image-map.jsp";
	}
	
	
	// planner status를 Y로 업데이트 하는 기능
	@RequestMapping("/completePlanStatus.do")
	public String completePlanStatus(HttpSession session, String open, RedirectAttributes redirectAttributes) {
		Planner planner = (Planner) session.getAttribute("planner");
		User user = (User) session.getAttribute("LOGIN_USER");
		
		Map<String, Object> userInfo = new HashMap<>();
		userInfo.put("id", user.getId());
		
		if ("Y".equals(open) && (user.getPeanuts() >= 5)) {
			userInfo.put("peanuts", 5);
			mapService.minusPeanuts(userInfo);
			mapService.completePlanStatus(planner.getNo());
		} else if ("N".equals(open) && (user.getPeanuts() >= 10)) {
			userInfo.put("peanuts", 10);
			mapService.minusPeanuts(userInfo);
			mapService.updatePlanClose(planner.getNo());
			mapService.completePlanStatus(planner.getNo());
		} else {
			mapService.delPLByPnoAndLid(planner.getNo());
			return "/map/warningPeanuts.jsp";
		}
		
		redirectAttributes.addAttribute("pno", planner.getNo());
		
		return "redirect:/planner/dashboard.do";
	}
	
	// planner_location의 마지막 일정의 마지막 날짜와 planner의 여행종료일이 같으면 true를 반환한다
	@RequestMapping("/completePlan")
	@ResponseBody
	public boolean completePlan(HttpSession session) {
		boolean isTrue = false;
		
		Planner planner = (Planner) session.getAttribute("planner");
		String lastLocationDate = mapService.getMinDate(planner.getNo());
		String lastPlannerDate = planner.getEndDate();
		if (lastLocationDate.equals(lastPlannerDate)) {
			isTrue = true;
		}
		
		return isTrue;
	}

	// mapModule 페이지로 이동하는 기능
	@RequestMapping("/mapModule.do")
	public String mapModule(HttpSession session, int pno, Model model) {
		User user = (User) session.getAttribute("LOGIN_USER");
		Planner planner = mapService.getPlannerByNo(pno);
		boolean isWriter = false;
		if (user.getId().equals(planner.getUserId())) {
			isWriter = true;
		}
		model.addAttribute("isWriter", isWriter);
		
		model.addAttribute("pno", pno);
		model.addAttribute("status", planner.getStatus());
		
		return "map/dashMap.jsp";
	}
}
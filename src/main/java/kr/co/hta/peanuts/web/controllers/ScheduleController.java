package kr.co.hta.peanuts.web.controllers;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hta.peanuts.service.ScheduleService;
import kr.co.hta.peanuts.vo.CalendarEvent;
import kr.co.hta.peanuts.vo.Daily;
import kr.co.hta.peanuts.vo.DailyHotel;
import kr.co.hta.peanuts.vo.DailyTour;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.PlannerLocation;
import kr.co.hta.peanuts.vo.TransLocation;
import kr.co.hta.peanuts.vo.Transportation;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.vo.Wallet;
import kr.co.hta.peanuts.web.form.DailyHotelForm;
import kr.co.hta.peanuts.web.form.TransportationForm;
import oracle.net.aso.c;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {

	@Autowired ScheduleService scheduleService;
	
	@RequestMapping("/list.do")
	public String list(int pno, Model model, HttpSession session) {
		//전체 daily key 가져오기
		List<Daily> allDaily = scheduleService.dailyByPlanNo(pno);
		String status = scheduleService.getPlannerStatus(pno);
		if (status.equals("N")) {
			return "redirect:/planner/dashboard.do?pno="+pno;
		}
		
		User loginedUser = (User) session.getAttribute("LOGIN_USER");
		Planner planner = scheduleService.getPlanner(allDaily.get(0).getKey());
		String isWriter = "false";
		if(loginedUser.getId().equals(planner.getUserId())) {
			isWriter = "true";
		}
		model.addAttribute("pno", pno);
		model.addAttribute("allDaily", allDaily);
		model.addAttribute("isWriter", isWriter);
		return "schedule/list.jsp";
	}
	
	@RequestMapping("/dailyList.do")
	@ResponseBody
	public Map<String, Object> dailyLocations(int key) {
		Map<String, Object> map = new HashMap<String, Object>();
		List<PlannerLocation> locations = scheduleService.locationByDaily(key);
		List<TransLocation> transportations = scheduleService.transByDaily(key);
		List<DailyTour> tours = scheduleService.tourByDaily(key);
		List<DailyHotel> hotels = scheduleService.hotelByDaily(key);		
		map.put("locations", locations);
		map.put("transportations", transportations);
		map.put("tours", tours);
		map.put("hotels", hotels);
		return map;
	}

	@RequestMapping("/delTrans.do")
	public String delTrans(int pno, int tKey) {
		scheduleService.delTransByTkey(tKey);
		scheduleService.delWalletTransByTkey(tKey);
		return "redirect:/schedule/list.do?pno="+pno;
	}
	
	@RequestMapping("/getTrans.do")
	@ResponseBody
	public Map<String, Object> getTrans(int key) {
		int transKey = key;
		// 해당 트랜스키의 이동정보 
		TransLocation orgTrans = scheduleService.getTrans(transKey);
		// 해당 일의 도시정보
		List<PlannerLocation> orgLocations = scheduleService.locationByDaily(orgTrans.getKey());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgTrans", orgTrans);
		map.put("orgLocations", orgLocations);
		return map;
	}
	
	@RequestMapping("/getCities.do")
	@ResponseBody
	public List<PlannerLocation> getCities(int key) {
		return scheduleService.locationByDaily(key);
	}
	
	@RequestMapping("modifyTrans.do")
	public String modifyTrans(TransportationForm transportationForm) {
		int transKey = transportationForm.getKey();
		
		//수정된 데이터의 이동수단 
		Transportation transportation = new Transportation();
		if(transportationForm.getStartTime() == "") {
			transportationForm.setStartTime(null);
		}
		if(transportationForm.getEndTime() == "") {
			transportationForm.setEndTime(null);
		}
		if(transportationForm.getMemo() == "") {
			transportationForm.setMemo(null);
		}
		BeanUtils.copyProperties(transportationForm, transportation);
		transportation.setTransKey(transKey);
		
		//수정된 가계부 데이터
		Wallet wallet = new Wallet();
		wallet.setFrgKey(transKey);
		if(transportation.getCategory().equals("AIR")) {
			wallet.setTitle("항공비");
		}
		if(transportation.getCategory().equals("TRAIN")) {
			wallet.setTitle("기차비");
		}
		if(transportation.getCategory().equals("TAXI")) {
			wallet.setTitle("택시비");
		}
		if(transportation.getCategory().equals("BUS")) {
			wallet.setTitle("버스비");
		}
		if(transportation.getCategory().equals("ETC")) {
			wallet.setTitle("이동비");
		}		
		
		scheduleService.modifyTrans(transportation);
		scheduleService.modifyWalletTrans(wallet);
		return "redirect:/schedule/list.do?pno="+transportationForm.getPno();
	}
	
	@RequestMapping("/addTrans.do")
	public String addTrans(TransportationForm transportationForm) {
		//신규 이동수단 데이터
		Transportation transportation = new Transportation();
		if(transportationForm.getStartTime() == "") {
			transportationForm.setStartTime(null);
		}
		if(transportationForm.getEndTime() == "") {
			transportationForm.setEndTime(null);
		}
		if(transportationForm.getMemo() == "") {
			transportationForm.setMemo(null);
		}
		BeanUtils.copyProperties(transportationForm, transportation);
		int getTKey = scheduleService.getTransKey();
		transportation.setTransKey(getTKey);
		
		//가계부 데이터
		Wallet wallet = new Wallet();
		wallet.setDaily(transportationForm.getKey());
		wallet.setFrgKey(getTKey);
		if(transportation.getCategory().equals("AIR")) {
			wallet.setTitle("항공비");
		}
		if(transportation.getCategory().equals("TRAIN")) {
			wallet.setTitle("기차비");
		}
		if(transportation.getCategory().equals("TAXI")) {
			wallet.setTitle("택시비");
		}
		if(transportation.getCategory().equals("BUS")) {
			wallet.setTitle("버스비");
		}
		if(transportation.getCategory().equals("ETC")) {
			wallet.setTitle("이동비");
		}
		
		scheduleService.addTrans(transportation);
		scheduleService.addWalletTrans(wallet);
		return "redirect:/schedule/list.do?pno="+transportationForm.getPno();
	}
	
	@RequestMapping("/insertTour.do")
	@ResponseBody
	public DailyTour insertTour(int key, String tTitle) {
		
		DailyTour dailyTour = new DailyTour();
		dailyTour.setKey(key);
		dailyTour.setTitle(tTitle);
		dailyTour.setTourKey(scheduleService.getTourKey());
		scheduleService.addTour(dailyTour);		
		return dailyTour;
	}
	
	@RequestMapping("/delTour.do")
	public String delTour(int pno, int tKey) {
		scheduleService.delTour(tKey);
		return "redirect:/schedule/list.do?pno="+pno;
	}
	
	@RequestMapping("/addHotel.do")
	public String addHotel(DailyHotelForm dailyHotelForm) {
		int getHkey = scheduleService.getHotelKey();

		DailyHotel dailyHotel = new DailyHotel();
		BeanUtils.copyProperties(dailyHotelForm, dailyHotel);
		dailyHotel.setHotelKey(getHkey);
		
		Wallet wallet = new Wallet();
		wallet.setDaily(dailyHotel.getKey());
		wallet.setTitle(dailyHotel.getTitle()+"("+dailyHotel.getTerm()+"박)");
		wallet.setFrgKey(getHkey);
		
		scheduleService.addHotel(dailyHotel);
		scheduleService.addWalletHotel(wallet);
		return "redirect:/schedule/list.do?pno="+dailyHotelForm.getPno();
	}
	
	@RequestMapping("delHotel.do")
	public String delHotel(int pno, int hkey) {
		scheduleService.delHotel(hkey);
		scheduleService.delWalletHotel(hkey);
		return "redirect:/schedule/list.do?pno="+pno;
	}
	
	@RequestMapping("/calendar.do")
	public String calendar(int pno, Model model) {
		String status = scheduleService.getPlannerStatus(pno);
		if (status.equals("N")) {
			return "redirect:/planner/dashboard.do?pno="+pno;
		}
		model.addAttribute("pno", pno);
		return "schedule/calendar.jsp";
	}
	
	@RequestMapping("/calEvent.do")
	@ResponseBody
	public List<CalendarEvent> calEvent(int pno) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar c = Calendar.getInstance(); 
		List<PlannerLocation> locations = scheduleService.getCalEvent(pno);
		List<CalendarEvent> events = new ArrayList<CalendarEvent>();
		
		for(PlannerLocation location : locations) {
			CalendarEvent calendarEvent = new CalendarEvent();
			Date endDate = location.getEndDate();
			c.setTime(endDate);
			c.add(Calendar.DATE, 1);

			calendarEvent.setTitle(location.getLocationName());
			calendarEvent.setStart(sdf.format(location.getStartDate()));
			calendarEvent.setEnd(sdf.format(c.getTime()));
			events.add(calendarEvent);
		}
		return events;
	}
	
	@RequestMapping("/getLoadMonth.do")
	@ResponseBody
	public Date getLoadMonth(int pno) {
		return scheduleService.getLoadMonth(pno);
	}
}

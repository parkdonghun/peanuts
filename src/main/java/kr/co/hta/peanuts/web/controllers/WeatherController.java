package kr.co.hta.peanuts.web.controllers;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.deser.impl.ExternalTypeHandler.Builder;

import kr.co.hta.peanuts.annotation.LoginUser;
import kr.co.hta.peanuts.service.HomeService;
import kr.co.hta.peanuts.service.WeatherService;
import kr.co.hta.peanuts.vo.Location;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.vo.Weather;

@Controller
@RequestMapping("/weather")
public class WeatherController {

	@Autowired
	WeatherService weatherService;
	
	@Autowired
	HomeService homeService;
	
	@RequestMapping("/weather.do")
	public String weather(int pno, @LoginUser User user, Model model) {
		if(user == null) {
			return "redirect:/user/login.do?err=fail";
		}
		model.addAttribute("pno", pno);
		
		return "/weather/weather.jsp";
	}
	
	@RequestMapping("/past.do")
	public void  pastWeather(String locationId, String date, HttpServletResponse response) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		response.getWriter().write(weatherService.getPastWeather(locationId, date));
	}
	
	@RequestMapping("/current.do")
	@ResponseBody
	public List<Weather> currentWeather(String locationId) throws Exception {
		return  weatherService.getCurrentWeather(locationId);
	}
	
	@RequestMapping("/searchLocationByCity.do")
	@ResponseBody
	public List<Location> searchLocationByCity(String city) {
		return weatherService.searchLocationByCity(city);
	}
	
	@RequestMapping("/searchLocationById.do")
	@ResponseBody
	public Location searchLocationId(String id) {
		return weatherService.searchLocationById(id);
	}

	@RequestMapping("/getWeatherLocations.do")
	@ResponseBody
	public List<Location> getWeatherLocations(int pno) {
		
		return weatherService.getWetherLocationsByPlannerNo(pno);
	}
	
	@RequestMapping("/getPastWeather.do")
	public void getLoadMonth(int pno, String locationId, HttpServletResponse response) throws Exception {
		Planner planner = homeService.getPlannerInfo(pno);
		
		String[] dateItems = planner.getStartDate().split("-");
		String date = (Integer.parseInt(dateItems[0]) - 1)  + dateItems[1];
		System.out.println("여행 시작월: " + date);
		
		
		response.setContentType("text/html;charset=utf-8");
		response.getWriter().write(weatherService.getPastWeather(locationId, date));
	}
}



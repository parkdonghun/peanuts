package kr.co.hta.peanuts.web.controllers;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hta.peanuts.service.MapService;
import kr.co.hta.peanuts.service.SearchService;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.web.form.SearchForm;

@Controller
@RequestMapping("/search")
public class SearchController {

	@Autowired SearchService searchService;
	@Autowired MapService mapService;
	
	@RequestMapping("/search.do")
	public String globalSearch(SearchForm searchForm, Model model) {
		
		List<Planner> result =  searchService.searchPlanners(searchForm);
		List<User> userList = searchService.searchUsers(result);
		model.addAttribute("resultCnt", result.size());
		model.addAttribute("mentos", userList);
		model.addAttribute("result", result);
		return "/search/result.jsp";
	}
	
	@RequestMapping("/resultMap.do")
	@ResponseBody
	public String getResultMap(int pno) {
		return mapService.getMapImage(pno, "260", "300");
	}
	
	@RequestMapping("/resultLocation.do")
	@ResponseBody
	public List<String> getResultLocations(int pno) {
		return searchService.searchLocations(pno);
	}
	
}

package kr.co.hta.peanuts.service;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.web.form.SearchForm;

@Transactional
public interface SearchService {

	List<Planner> searchPlanners(SearchForm searchForm);
	List<User> searchUsers(List<Planner> result);
	List<String> searchLocations(int pno);
}

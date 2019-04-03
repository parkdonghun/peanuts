package kr.co.hta.peanuts.dao;

import java.util.List;

import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.web.form.SearchForm;

public interface SearchDao {

	//플래너 조건 검색
	List<Planner> searchPlanners(SearchForm searchForm);
	//검색결과 플래너의 유저들 검색
	List<User> searchUsers(List<String> ids);
	//플래너가 방문하는 지역목록
	List<String> searchLocations(int pno);
}

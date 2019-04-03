package kr.co.hta.peanuts.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hta.peanuts.dao.SearchDao;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.web.form.SearchForm;

@Service
public class SearchServiceImpl implements SearchService {

	@Autowired
	SearchDao searchDao;
	
	@Override
	public List<Planner> searchPlanners(SearchForm searchForm) {
		Integer members = searchForm.getSearchMemebers();
		if(members == 0) {
			searchForm.setSearchMemebers(null);
		}
		return searchDao.searchPlanners(searchForm);
	}
	@Override
	public List<User> searchUsers(List<Planner> result) {
		//검색결과가 없는 경우
		if(result == null) {
			return null;
		}
		if(result.isEmpty()) {
			return null;
		}
		//검색결과 플래너의 유저아이디들로만 이루어진 리스트 생성
		List<String> ids = new ArrayList<>();
		for(Planner p : result) {
			if(!ids.contains(p.getUserId())) {
				ids.add(p.getUserId());
			}
		}
		//유저 리스트가 6칸 이상이면 6개만 표시
		List<User> userList = searchDao.searchUsers(ids);
		if(userList.size() >= 6) {
			return userList.subList(0, 6);
		}
		return searchDao.searchUsers(ids);
	}
	@Override
	public List<String> searchLocations(int pno) {
		List<String> result = searchDao.searchLocations(pno);
		List<String> array = new ArrayList<>();
		for(String s : result) {
			if(!array.contains(s)) {
				array.add(s);
			}
		}
		return array;
	}
}

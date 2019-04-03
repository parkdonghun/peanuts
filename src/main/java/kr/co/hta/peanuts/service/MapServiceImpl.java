package kr.co.hta.peanuts.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hta.peanuts.dao.MapDao;
import kr.co.hta.peanuts.vo.Daily;
import kr.co.hta.peanuts.vo.Location;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.web.form.PlannerLocationForm;

@Service
public class MapServiceImpl implements MapService {

	@Autowired
	private MapDao mapDao;
	
	@Override
	public int getPlanSeq() {
		return mapDao.getPlanSeq();
	}
	
	@Override
	public void delInsertToMap(int planNo) {
		mapDao.delPlanLocation(planNo);
		mapDao.delDaily(planNo);
		mapDao.delPlanner(planNo);
	}
	
	@Override
	public void addNewPlan(Planner planner) {
		mapDao.addNewPlan(planner);
	}
	
	@Override
	public List<Location> getLocation(Location location) {
		return mapDao.getLocation(location);
	}
	
	@Override
	public Location getLocationById(String locationId) {
		return mapDao.getLocationById(locationId);
	}
	
	@Override
	public int dailyNum(Planner planner) {
		return mapDao.dailyNum(planner);
	}
	
	@Override
	public void addNewDaily(Daily daily) {
		mapDao.addNewDaily(daily);
	}
	
	@Override
	public Planner getPlannerByNo(int no) {
		return mapDao.getPlannerByNo(no);
	}

	@Override
	public Planner addPL(PlannerLocationForm pl) {
		// 만약 endDate 또는 locationId 이 null로 넘어오면 에러발생시키기
		if (pl.getEndDate() == null) {
			// 에러페이지 생기면 넣기
		}
		if (pl.getLocationId() == null) {
			// 에러페이지 생기면 넣기
		}
		
		Planner planner = mapDao.getPlannerByNo(pl.getPlanNo());
		String startDate = planner.getStartDate();		// 여행 시작일
		
		List<PlannerLocationForm> pls = mapDao.getPLByPno(pl.getPlanNo());
		
		// 만약 planner_location이 하나도 존재하지 않으면 
		// planner의 plan_no와 일치하는 데이터의 plan_start를 start_date로 넣어줘야 한다
		if (pls.size() == 0) {
			pl.setStartDate(startDate);
		}
		// 만약 planner_location이 하나라도 존재하면 
		// planner_location의 end_date를 새로 추가할 planner_location의 start_date로 넣어줘야 한다
		if (pls.size() != 0) {
			// list의 마지막 데이터를 저장한다
			int index = pls.size()-1;
			PlannerLocationForm last = pls.get(index);
			pl.setStartDate(last.getEndDate());
		}
		
		// planner_location에 해당 데이터 저장하기
		mapDao.addPL(pl);
		
		return planner;
		
	}

	@Override
	public List<PlannerLocationForm> getPLByPno(int planNo) {
		List<PlannerLocationForm> pls = mapDao.getPLByPno(planNo);
		for (PlannerLocationForm pl : pls) {
			Location loId= new Location();
			loId.setId(pl.getLocationId());
			List<Location> locations = mapDao.getLocation(loId);
			Location location = locations.get(0);
			
			pl.setLocationCity(location.getCity());
			pl.setLocationName(location.getName());
			pl.setLineX(location.getLineX());
			pl.setLineY(location.getLineY());
		}
		return pls;
	}

	@Override
	public void delPLByPnoAndLid(int planNo) {
		// planner_id로 planner_location들을 찾아서 마지막 인덱스의 planner_location을 삭제한다
		List<PlannerLocationForm> pls = mapDao.getPLByPno(planNo);
		int index = pls.size()-1;
		PlannerLocationForm last = pls.get(index);
		
		mapDao.delPLByPnoAndLid(last);
	}
	
	// planNo로 planner_location 검색해서 
	// 데이터가 존재하면 map.jsp 페이지의 달력에 min값을 planner의 start_date로 설정
	// 데이터가 존재하지 않으면 min값을 planner_location의 마지막 일정의 end_date로 설정
	public String getMinDate(int planNo) {
		// 화면에 보내줄 min값을 담은 String 객체
		String minDate = null;
		
		// planNo에 따른 planner_location이 있나?
		List<PlannerLocationForm> pls = mapDao.getPLByPno(planNo);
		
		// pls의 size가 0이면 planner_location이 존재하지 않으므로 planner의 start_date를 minDate로 설정
		if (pls.size() == 0) {
			Planner planner = mapDao.getPlannerByNo(planNo);
			minDate = planner.getStartDate();
		}
		// pls의 size가 0이 아니면 planner_location의 마지막 일정의 end_date를 minDate로 설정
		if (pls.size() != 0) {
			int index = pls.size()-1;
			PlannerLocationForm last = pls.get(index);
			minDate = last.getEndDate();
		}
		
		return minDate;
	}
	
	
	// <img src="${mapImg }">
	// 이런 형식으로 쓰기
	public String getMapImage(int planNo, String width, String height) {
		// 일정의 위도/경도를 담을 locations를 생성한다
		List<Location> locations = new ArrayList<>();
		
		// planNo로 planner_location을 불러온다
		List<PlannerLocationForm> pls = getPLByPno(planNo);
		
		// 불러온 planner_location list에 저장돼있는 location_id를 이용해서 위도/경도를 알아내서 저장한다
		for (PlannerLocationForm pl : pls) {
			Location location = mapDao.getLocationById(pl.getLocationId());
			locations.add(location);
		}
		
		String markers = "";
		String path = "";
		for (Location location : locations) {
			markers += "&markers=size:mid%7Ccolor:0xff0000%7Clabel:%7C" + location.getLineX() + "," + location.getLineY();
			path += "%7C" + location.getLineX() + "," + location.getLineY();
		}
		//System.out.println(markers);
		//System.out.println(path);
		
		String mapImg = "https://maps.googleapis.com/maps/api/staticmap"
				+ "?size=" + width + "x" + height
				+ "&maptype=roadmap"
				+ "&scale=1"
				+ markers
				+ "&path=color:0xff0000%7Cweight:3"
				+ path
				+ "&key=AIzaSyCcqLcnhoN-_GQw1a9bJXgR0xq8Qvi3W4U";
		
		return mapImg;
	}
	
	@Override
	public void completePlanStatus(int pno) {
		mapDao.completePlanStatus(pno);
	}
	
	@Override
	public void minusPeanuts(Map<String, Object> userInfo) {
		mapDao.minusPeanuts(userInfo);
	}
	
	@Override
	public void updatePlanClose(int pno) {
		mapDao.updatePlanClose(pno);
	}
}

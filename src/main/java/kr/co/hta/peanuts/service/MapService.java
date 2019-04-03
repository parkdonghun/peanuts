package kr.co.hta.peanuts.service;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import kr.co.hta.peanuts.vo.Daily;
import kr.co.hta.peanuts.vo.Location;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.web.form.PlannerLocationForm;

@Transactional
public interface MapService {

	int getPlanSeq();
	void delInsertToMap(int planNo);
	//void delPlanLocation(int planNo);
	//void delDaily(int planNo);
	//void delPlanner(int planNo);
	void addNewPlan(Planner planner);
	List<Location> getLocation(Location location);
	Location getLocationById(String locationId);
	int dailyNum(Planner planner);
	void addNewDaily(Daily daily);
	Planner getPlannerByNo(int no);
	Planner addPL(PlannerLocationForm pl);
	List<PlannerLocationForm> getPLByPno(int planNo);
	void delPLByPnoAndLid(int planNo);
	void completePlanStatus(int pno);
	void minusPeanuts(Map<String, Object> userInfo);
	void updatePlanClose(int pno);
	
	// dao에 없는 기능
	String getMinDate(int planNo);
	String getMapImage(int planNo, String width, String height);
}

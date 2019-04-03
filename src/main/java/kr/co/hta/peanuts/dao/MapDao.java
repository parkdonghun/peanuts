package kr.co.hta.peanuts.dao;

import java.util.List;
import java.util.Map;

import kr.co.hta.peanuts.vo.Daily;
import kr.co.hta.peanuts.vo.Location;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.web.form.PlannerLocationForm;

public interface MapDao {

	int getPlanSeq();
	void delPlanLocation(int planNo);
	void delDaily(int planNo);
	void delPlanner(int planNo);
	void addNewPlan(Planner planner);
	List<Location> getLocation(Location location);
	Location getLocationById(String locationId);
	int dailyNum(Planner planner);
	void addNewDaily(Daily daily);
	Planner getPlannerByNo(int no);
	void addPL(PlannerLocationForm pl);
	List<PlannerLocationForm> getPLByPno(int planNo);
	void delPLByPnoAndLid(PlannerLocationForm pl);
	void completePlanStatus(int pno);
	void minusPeanuts(Map<String, Object> userInfo);
	void updatePlanClose(int pno);
}

package kr.co.hta.peanuts.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import kr.co.hta.peanuts.vo.Daily;
import kr.co.hta.peanuts.vo.DailyHotel;
import kr.co.hta.peanuts.vo.DailyTour;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.PlannerLocation;
import kr.co.hta.peanuts.vo.TransLocation;
import kr.co.hta.peanuts.vo.Transportation;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.vo.Wallet;

@Transactional
public interface ScheduleService {

	String getPlannerStatus(int pno);
	Planner getPlanner(int key);	
	List<Daily> dailyByPlanNo(int planNo);
	Date dailyByKey(int key);
	List<TransLocation> transByDaily(int key);	
	List<PlannerLocation> locationByDaily(int key);
	List<PlannerLocation> getCities(int pno);	
	List<DailyTour> tourByDaily(int key);
	List<DailyHotel> hotelByDaily(int key);
	void delTransByTkey(int tKey);
	void delWalletTransByTkey(int tKey);	
	TransLocation getTrans(int tkey);
	void modifyTrans(Transportation transportation);
	void modifyWalletTrans(Wallet wallet);	
	void addTrans(Transportation transportation);	
	void addWalletTrans(Wallet wallet);
	int getTransKey();	
	void addTour(DailyTour dailyTour);
	int getTourKey();	
	void delTour(int tourKey);
	void addHotel(DailyHotel dailyHotel);
	void addWalletHotel(Wallet wallet);
	int getHotelKey();
	void delHotel(int hotelKey);
	void delWalletHotel(int hotelKey);
	List<PlannerLocation> getCalEvent(int pno);
	Date getLoadMonth(int pno);
}

package kr.co.hta.peanuts.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hta.peanuts.dao.ScheduleDao;
import kr.co.hta.peanuts.vo.Daily;
import kr.co.hta.peanuts.vo.DailyHotel;
import kr.co.hta.peanuts.vo.DailyTour;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.PlannerLocation;
import kr.co.hta.peanuts.vo.TransLocation;
import kr.co.hta.peanuts.vo.Transportation;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.vo.Wallet;

@Service
public class ScheduleServiceImpl implements ScheduleService {

	@Autowired
	ScheduleDao scheduleDao; 
	
	@Override
	public String getPlannerStatus(int pno) {
		return scheduleDao.getPlannerStatus(pno);
	}
	@Override
	public Planner getPlanner(int key) {
		return scheduleDao.getPlanner(key);
	}
	@Override
	public List<Daily> dailyByPlanNo(int planNo) {
		return scheduleDao.dailyByPlanNo(planNo);
	}
	@Override
	public Date dailyByKey(int key) {
		return scheduleDao.dailyByKey(key);
	}
	@Override
	public List<TransLocation> transByDaily(int key) {
		return scheduleDao.transByDaily(key);
	}
	@Override
	public List<PlannerLocation> locationByDaily(int key) {
		Date date = scheduleDao.dailyByKey(key);
		Planner planner = scheduleDao.getPlanner(key);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("day", date);
		map.put("pno", planner.getNo());
		return scheduleDao.locationByDaily(map);
	}
	@Override
	public List<PlannerLocation> getCities(int pno) {
		return scheduleDao.getCities(pno);
	}
	@Override
	public List<DailyTour> tourByDaily(int key) {
		return scheduleDao.tourByDaily(key);
	}
	@Override
	public List<DailyHotel> hotelByDaily(int key) {
		return scheduleDao.hotelByDaily(key);
	}
	@Override
	public void delTransByTkey(int tKey) {
		scheduleDao.delTransByTkey(tKey);
	}
	@Override
	public void delWalletTransByTkey(int tno) {
		scheduleDao.delWalletTransByTkey(tno);
	}
	@Override
	public TransLocation getTrans(int tkey) {
		return scheduleDao.getTrans(tkey);
	}
	@Override
	public void modifyTrans(Transportation transportation) {
		scheduleDao.modifyTrans(transportation);
	}
	@Override
	public void modifyWalletTrans(Wallet wallet) {
		scheduleDao.modifyWalletTrans(wallet);
	}
	@Override
	public void addTrans(Transportation transportation) {
		scheduleDao.addTrans(transportation);
	}
	@Override
	public void addWalletTrans(Wallet wallet) {
		scheduleDao.addWalletTrans(wallet);
	}
	@Override
	public int getTransKey() {
		return scheduleDao.getTransKey();
	}
	@Override
	public void addTour(DailyTour dailyTour) {
		scheduleDao.addTour(dailyTour);
	}
	@Override
	public int getTourKey() {
		return scheduleDao.getTourKey();
	}
	@Override
	public void delTour(int tourKey) {
		scheduleDao.delTour(tourKey);
	}
	@Override
	public void addHotel(DailyHotel dailyHotel) {
		scheduleDao.addHotel(dailyHotel);
	}
	@Override
	public void addWalletHotel(Wallet wallet) {
		scheduleDao.addWalletHotel(wallet);
	}
	@Override
	public int getHotelKey() {
		return scheduleDao.getHotelKey();
	}
	@Override
	public void delHotel(int hotelKey) {
		scheduleDao.delHotel(hotelKey);
	}
	@Override
	public void delWalletHotel(int hotelKey) {
		scheduleDao.delWalletHotel(hotelKey);
	}
	@Override
	public List<PlannerLocation> getCalEvent(int pno) {
		return scheduleDao.getCalEvent(pno);
	}
	@Override
	public Date getLoadMonth(int pno) {
		return scheduleDao.getLoadMonth(pno);
	}
}

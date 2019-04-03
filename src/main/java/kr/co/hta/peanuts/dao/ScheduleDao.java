package kr.co.hta.peanuts.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import kr.co.hta.peanuts.vo.Daily;
import kr.co.hta.peanuts.vo.DailyHotel;
import kr.co.hta.peanuts.vo.DailyTour;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.PlannerLocation;
import kr.co.hta.peanuts.vo.TransLocation;
import kr.co.hta.peanuts.vo.Transportation;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.vo.Wallet;

public interface ScheduleDao {
	
	//해당 번호의 플래너 상태 가져오기
	String getPlannerStatus(int pno);
	//해당 키가 속한 플래너 알아오기
	Planner getPlanner(int key);
	//해당 플래너의 Daily목록 가져오기
	List<Daily> dailyByPlanNo(int planNo);
	//해당 키의 날짜 가져오기
	Date dailyByKey(int key);
	//해당 키 날짜에 이용하는 교통편 가져오기
	List<TransLocation> transByDaily(int key);
	//해당 플래너 + 해당 날짜에 방문하는 지역목록 가져오기(플래너도시-도시 조인)
	List<PlannerLocation> locationByDaily(Map map);
	//해당 플래너에서 방문하는 도시목록 가져오기
	List<PlannerLocation> getCities(int pno);
	//해당 키 날짜에 방문하는 관광일정 가져오기
	List<DailyTour> tourByDaily(int key);
	//해당 키 날짜에 방문하는 숙박일정 가져오기
	List<DailyHotel> hotelByDaily(int key);
	//해당 이동관련 데이터 하나 삭제하기
	void delTransByTkey(int tKey);
	//가계부에 이동관련 데이터 삭제하기
	void delWalletTransByTkey(int tKey);
	//해당 trans 키의 이동정보 가져오기
	TransLocation getTrans(int tKey);
	//Transportation 객체를 받아 해당 레코드 수정하기
	void modifyTrans(Transportation transportation);
	//가계부에서 해당하는 이동관련 데이터 수정하기
	void modifyWalletTrans(Wallet wallet);
	//Transportation 객체를 받아 신규 레코드 등록하기
	void addTrans(Transportation transportation);
	//가계부에 이동관련 데이터 저장하기
	void addWalletTrans(Wallet wallet);
	//현재 교통seq key 조회하기
	int getTransKey();
	//DailyTour 객체를 받아 신규 관광레코드 등록하기
	void addTour(DailyTour dailyTour);
	//현재 Tour key 조회하기
	int getTourKey();
	//해당 관광일정 하나 삭제하기
	void delTour(int tourKey);
	//DailyHotel 객체를 받아 신규 숙박레코드 등록하기
	void addHotel(DailyHotel dailyHotel);
	//가계부에 숙박관련 데이터 저장하기
	void addWalletHotel(Wallet wallet);
	//현재 숙박seq key 조회하기
	int getHotelKey();
	//해당 숙박관련 데이터 하나 삭제하기
	void delHotel(int hotelKey);
	//가계부에 숙박관련 데이터 삭제하기
	void delWalletHotel(int hotelKey);
	//해당 플래너의 지역이벤트 데이터 조회하기
	List<PlannerLocation> getCalEvent(int pno);
	//해당pno의 플래너의 첫날 date로 가져오기
	Date getLoadMonth(int pno);
	
}
package kr.co.hta.peanuts.dao;

import java.util.Date;
import java.util.List;

import kr.co.hta.peanuts.vo.Location;

public interface WeatherDao {

	List<Location> searchLocationByCity(String city);
	Location searchLocationById(String id);
	
	Date getLoadMonth(int pno);
	List<Location> getWetherLocationsByPlannerNo(int planNo);
}

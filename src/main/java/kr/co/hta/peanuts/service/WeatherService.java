package kr.co.hta.peanuts.service;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import kr.co.hta.peanuts.vo.Location;
import kr.co.hta.peanuts.vo.Weather;

@Transactional
public interface WeatherService {

	String getPastWeather(String locationId, String date) throws IOException;
	List<Weather> getCurrentWeather(String locationId) throws Exception;
	List<Location> searchLocationByCity(String city);
	Location searchLocationById(String id);
	
	List<Location> getWetherLocationsByPlannerNo(int planNo);
	
	Date getLoadMonth(int pno);
}


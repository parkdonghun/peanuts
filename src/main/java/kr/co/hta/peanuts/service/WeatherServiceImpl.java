package kr.co.hta.peanuts.service;

import java.io.IOException;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.jdom2.input.SAXBuilder;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hta.peanuts.dao.WeatherDao;
import kr.co.hta.peanuts.vo.Location;
import kr.co.hta.peanuts.vo.Weather;

@Service
public class WeatherServiceImpl implements WeatherService {

	@Autowired
	WeatherDao weatherDao;
	
	@Override
	public String getPastWeather(String locationId, String date) throws IOException {
		
		String path = "https://weather.naver.com/period/pastWetrMain.nhn?ym="+date+"&naverRgnCd="+ locationId;
		
		Document document = Jsoup.connect(path).get();
		document.charset(Charset.forName("UTF-8"));

		Element element = document.selectFirst("#print_content");
				
		return element.html();
	}
	
	@Override
	public List<Weather> getCurrentWeather(String locationId) throws Exception {
		
		List<Weather> currentWeathers = new ArrayList<>();
		String path = "http://www.weather.go.kr/wid/queryDFSRSS.jsp?zone=" + locationId;
		
		SAXBuilder builder = new SAXBuilder();
		org.jdom2.Document doc = builder.build(new URL(path));
		List<org.jdom2.Element> elements = doc.getRootElement().getChild("channel").getChild("item").getChild("description").getChild("body").getChildren("data");
		for (org.jdom2.Element e : elements) {
			Weather w = new Weather();
			
			w.setHour(e.getChildText("hour"));
			w.setDay(e.getChildText("day"));
			w.setTemp(e.getChildText("temp"));
			w.setTmx(e.getChildText("tmx"));
			w.setTmn(e.getChildText("tmn"));
			w.setSky(e.getChildText("sky"));
			w.setPty(e.getChildText("pty"));
			w.setWfKor(e.getChildText("wfKor"));
			w.setWfEn(e.getChildText("wfEn"));
			w.setPop(e.getChildText("pop"));
			w.setR12(e.getChildText("r12"));
			w.setS12(e.getChildText("s12"));
			w.setWs(e.getChildText("ws"));
			w.setWd(e.getChildText("wd"));
			w.setWdKor(e.getChildText("wdKor"));
			w.setWdEn(e.getChildText("wdEn"));
			w.setReh(e.getChildText("reh"));
			w.setR06(e.getChildText("r06"));
			w.setS06(e.getChildText("s06"));
			
			currentWeathers.add(w);
		}
		
		return currentWeathers;
	}
	
	@Override
	public List<Location> searchLocationByCity(String city) {
		return weatherDao.searchLocationByCity(city);
	}
	
	@Override
	public Location searchLocationById(String id) {
		return weatherDao.searchLocationById(id);
	}
	
	@Override
	public Date getLoadMonth(int pno) {
		return weatherDao.getLoadMonth(pno);
	}
	
	@Override
	public List<Location> getWetherLocationsByPlannerNo(int planNo) {
		return weatherDao.getWetherLocationsByPlannerNo(planNo);
	}
}







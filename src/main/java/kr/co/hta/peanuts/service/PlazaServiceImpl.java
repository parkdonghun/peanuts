package kr.co.hta.peanuts.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.hta.peanuts.dao.PlazaDao;
import kr.co.hta.peanuts.vo.Likes;
import kr.co.hta.peanuts.vo.Plaza;
import kr.co.hta.peanuts.vo.Reply;

@Service
@Transactional
public class PlazaServiceImpl implements PlazaService{
	
	@Autowired
	private PlazaDao plazaDao;
	
	@Override
	public void addpeanuts(Map<String, Object> map) {
		plazaDao.addpeanuts(map);
	}
	
	@Override
	public void addPlaza(Plaza plaza) {
		plazaDao.addPlaza(plaza);
	}
	@Override
	public List<Plaza> getAllPlaza(Map<String, Object> map) {
		List<Plaza> AllPlaza = plazaDao.getAllPlaza(map);
		return AllPlaza;
	}
	@Override
	public List<Reply> getReplyByNo(int no) {
		List<Reply> re = plazaDao.getReplyByNo(no);
		return re;
	}
	@Override
	public void addReply(Reply re) {
		plazaDao.addReply(re);
	}
	@Override
	public void listModiByNo(Plaza plaza) {
		plazaDao.listModiByNo(plaza);
	}
	@Override
	public void listDelByNo(int no) {
		plazaDao.listDelByNo(no);
	}
	@Override
	public void reModiByNo(Reply re) {
		plazaDao.reModiByNo(re);
	}
	@Override
	public void reDelByNo(int no) {
		plazaDao.reDelByNo(no);
	}
	@Override
	public void addlike(Likes like) {
		plazaDao.addlike(like);
	}
	@Override
	public int getUserIdLike(Likes like) {
		int cnt = plazaDao.getUserIdLike(like);
		return cnt;
	}
	@Override
	public void dellike(int no) {
		plazaDao.dellike(no);
	}
	@Override
	public List<Plaza> bestPlazalist() {
		List<Plaza> best = plazaDao.bestPlazalist();
		return best;
	}
	@Override
	public List<Reply> newReList() {
		List<Reply> re = plazaDao.newReList();
		return re;
	}
	@Override
	public List<Plaza> searchPlaza(Map<String, Object> map) {
		List<Plaza> result = plazaDao.searchPlaza(map);
		return result;
	}
	@Override
	public int plazaCnt(Map<String, Object> map) {
		int cnt = plazaDao.plazaCnt(map);
		return cnt;
	}
	@Override
	public void getByNoReport(int no) {
		plazaDao.getByNoReport(no);
	}

}

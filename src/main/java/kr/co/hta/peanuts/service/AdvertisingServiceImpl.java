package kr.co.hta.peanuts.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hta.peanuts.dao.AdvertisingDao;
import kr.co.hta.peanuts.vo.Advertising;
import kr.co.hta.peanuts.vo.AdvertisingBoard;

@Service
public class AdvertisingServiceImpl implements AdvertisingService {
	
	@Autowired
	private AdvertisingDao adDao;

	@Override
	public void addAdvertising(Advertising advertising) {
		adDao.addAdvertising(advertising);
	}

	@Override
	public Advertising getAdvertisingById(String id) {
		return adDao.getAdvertisingById(id);
	}

	@Override
	public void delAdById(String id) {
		adDao.delAdById(id);
	}

	@Override
	public List<AdvertisingBoard> getAllMyAdBoard(String id) {
		return adDao.getAllMyAdBoard(id);
	}

	@Override
	public void addAdBoard(AdvertisingBoard advertisingBoard) {
		adDao.addAdBoard(advertisingBoard);
	}

	@Override
	public AdvertisingBoard getAdBoardByAdNo(String no) {
		return adDao.getAdBoardByAdNo(no);
	}

	@Override
	public void updateAdBoard(AdvertisingBoard advertisingBoard) {
		adDao.updateAdBoard(advertisingBoard);
	}

	@Override
	public void delAdBoard(String no) {
		adDao.delAdBoard(no);
	}

	@Override
	public List<Advertising> getAllAdvertising() {
		return adDao.getAllAdvertising();
	}

	@Override
	public List<Advertising> searchAdvertising(String keyword) {
		return adDao.searchAdvertising(keyword);
	}

	@Override
	public void updateAdStatus(AdvertisingBoard advertisingBoard) {
		adDao.updateAdStatus(advertisingBoard);
	}

	@Override
	public List<AdvertisingBoard> getAllAdBoards() {
		List<AdvertisingBoard> adBoards = adDao.getAllAdBoards();
		for (AdvertisingBoard adBoard : adBoards) {
			Advertising ad = adDao.getAdvertisingById(adBoard.getId());
			adBoard.setManager(ad.getManager());
		}
		return adBoards;
	}

	@Override
	public List<AdvertisingBoard> searchAdBoard(String keyword) {
		List<AdvertisingBoard> adBoards = adDao.searchAdBoard(keyword);
		for (AdvertisingBoard adBoard : adBoards) {
			Advertising ad = adDao.getAdvertisingById(adBoard.getId());
			adBoard.setManager(ad.getManager());
		}
		return adBoards;
	}
	
}

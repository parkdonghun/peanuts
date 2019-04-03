package kr.co.hta.peanuts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.hta.peanuts.dao.WalletDao;
import kr.co.hta.peanuts.vo.Daily;
import kr.co.hta.peanuts.vo.Wallet;
import kr.co.hta.peanuts.web.form.WalletForm;


@Service
@Transactional
public class WalletServiceImpl implements WalletService {

	@Autowired
	private WalletDao walletDao;
	
	@Override
	public String getUserId(int pno) {
		String userId = walletDao.getUserId(pno);
		return userId;
	}
	
	@Override
	public List<Wallet> allWalletByNo(int planNo) {
		List<Wallet> allWallet =  walletDao.allWalletByNo(planNo);
		return allWallet;
	}
	@Override
	public List<Wallet> dashboardChart(int pno) {
		List<Wallet> wallet = walletDao.dashboardChart(pno);
		return wallet;
	}
	
	@Override
	public List<Daily> planerDays(int planNo) {
		List<Daily> planerDays = walletDao.planerDays(planNo);
		return planerDays;
	}
	@Override
	public void addDailyWallet(WalletForm wallet) {
		walletDao.addDailyWallet(wallet);
		
	}
	@Override
	public void deleteWallet(int keyno) {
		walletDao.deleteWallet(keyno);
	}
	@Override
	public Wallet getByWalletKey(int WalletKey) {
		Wallet wallet = walletDao.getByWalletKey(WalletKey);
		return wallet;
	}
	@Override
	public void modifygetKeyNo(WalletForm wallet) {
		walletDao.modifygetKeyNo(wallet);
	}
}

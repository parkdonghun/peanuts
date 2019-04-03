package kr.co.hta.peanuts.service;


import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import kr.co.hta.peanuts.vo.Daily;
import kr.co.hta.peanuts.vo.Wallet;
import kr.co.hta.peanuts.web.form.WalletForm;

@Transactional
public interface WalletService {
	// 플래너별 한눈에보기 모든정보 불러오기
	List<Wallet> allWalletByNo(int planNo);
	// 플래너별 날짜 받아오기
	List<Daily> planerDays(int planNo);
	// 플래너별 가계부 새로운 비용 추가(일별/카테고리별)
	void addDailyWallet(WalletForm wallet);
	// 일자별 비용 삭제하기
	void deleteWallet(int keyno);
	// 모달 walletKey별 비용 불럴오기
	Wallet getByWalletKey(int WalletKey);
	// 일자별 비용 수정 업데이트하기
	void modifygetKeyNo(WalletForm wallet);
	List<Wallet> dashboardChart(int pno);
	String getUserId(int pno);
}

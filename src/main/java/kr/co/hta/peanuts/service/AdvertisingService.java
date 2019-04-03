package kr.co.hta.peanuts.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.hta.peanuts.vo.Advertising;
import kr.co.hta.peanuts.vo.AdvertisingBoard;

@Transactional
public interface AdvertisingService  {
	
	// 광고주 관련 기능
	// 광고주 회원가입
	void addAdvertising(Advertising advertising);
	// id로 광고주 찾기
	Advertising getAdvertisingById(String id);
	// 회원 탈퇴하는 기능
	void delAdById(String id);
	
	// 게시판 관련 기능
	// 해당 광고주의 광고 게시글 모두 가져오기
	List<AdvertisingBoard> getAllMyAdBoard(String id);
	// 새로운 광고 게시글 등록
	void addAdBoard(AdvertisingBoard advertisingBoard);
	// 게시글 번호로 해당 게시글의 모든 정보 불러오기
	AdvertisingBoard getAdBoardByAdNo(String no);
	// 게시글 번호로 게시글 수정하는 기능(업데이트)
	void updateAdBoard(AdvertisingBoard advertisingBoard);
	// 게시글 번호로 게시글 삭제하는 기능
	void delAdBoard(String no);

	// 관리자 관련 기능
	// 모든 광고주 리스트 가져오기
	List<Advertising> getAllAdvertising();
	// 아이디, 사업자번호, 카테고리(종류), 이름, 매니저로 광고주 검색하기
	List<Advertising> searchAdvertising(String keyword);
	// 게시글 번호로 상태 업데이트하는 기능
	void updateAdStatus(AdvertisingBoard advertisingBoard);
	// 모든 광고 게시글을 가져오는 기능
	List<AdvertisingBoard> getAllAdBoards();
	// 광고 게시글 검색
	List<AdvertisingBoard> searchAdBoard(String keyword);

}

package kr.co.hta.peanuts.web.controllers;

import java.io.File;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.co.hta.peanuts.service.AdvertisingService;
import kr.co.hta.peanuts.vo.Advertising;
import kr.co.hta.peanuts.vo.AdvertisingBoard;
import kr.co.hta.peanuts.vo.User;

@Controller
@RequestMapping("/advertising")
public class AdvertisingController {

	@Value("${advertising.photo.saved.directory}")
	private String directory;

	@Autowired
	private AdvertisingService adService;

	// 광고주 관련 기능
	// 광고주 회원가입
	// 회원가입 페이지로 넘어가기
	@RequestMapping("/addAdvertisingForm.do")
	public String addAdvertisingForm() {
		return "advertising/insertform.jsp";
	}

	// 아이디 중복체크
	@RequestMapping("/checkId.do")
	@ResponseBody
	public List<Advertising> checkId(String adId) {
		List<Advertising> ads = new ArrayList<>();
		ads.add(adService.getAdvertisingById(adId));
		return ads;
	}

	// 폼에 입력한 값을 db에 저장하기
	@RequestMapping("/addAdvertising.do")
	public String addAdvertising(Advertising advertising) {
		adService.addAdvertising(advertising);
		return "redirect:/user/login.do";
	}

	// 광고주 회원탈퇴
	@RequestMapping("/delAdById.do")
	public String delAdById(HttpSession session, String pwd) {
		Advertising advertising = (Advertising) session.getAttribute("LOGIN_AD");
		if (advertising == null) {
			return "redirect:/user/login.do?err=fail";
		}
		adService.delAdById(advertising.getId());
		return "redirect:/home.do";
	}

	// 게시판 관련 기능
	// 내 게시판으로 이동
	@RequestMapping("/getMyList.do")
	public String getMyList(HttpSession session, Model model) {
		Advertising ad = (Advertising) session.getAttribute("LOGIN_AD");
		if (ad == null) {
			return "redirect:/user/login.do?err=fail";
		}
		List<AdvertisingBoard> adBoards = adService.getAllMyAdBoard(ad.getId());
		model.addAttribute("adBoards", adBoards);

		return "advertising/myboardlist.jsp";
	}

	// 새 광고 등록 폼으로 이동
	@RequestMapping("/addAdBoardForm.do")
	public String addAdBoardForm(Model model, HttpSession session) {
		Advertising advertising = (Advertising) session.getAttribute("LOGIN_AD");
		if (advertising == null) {
			return "redirect:/user/login.do?err=fail";
		}
		LocalDate today = LocalDate.now();
		LocalDate after = today.plusDays(15);
		String dateDay = after.toString();
		model.addAttribute("dateDay", dateDay);

		return "advertising/boardform.jsp";
	}

	// 새로운 광고 게시글 등록
	@RequestMapping("/addAdBoard.do")
	public String addAdBoard(AdvertisingBoard adBoard, MultipartFile imageFile, HttpSession session) throws Exception {
		// 광고 이미지 지정된 폴더에 저장
		Advertising ad = (Advertising) session.getAttribute("LOGIN_AD");
		if (ad == null) {
			return "redirect:/user/login.do?err=fail";
		}
		String filename = ad.getId() + "_" + imageFile.getOriginalFilename();
		FileCopyUtils.copy(imageFile.getBytes(), new File(directory, filename));
		
		// DB에 해당 정보 저장하기
		adBoard.setId(ad.getId());
		adBoard.setImage(filename);
		adService.addAdBoard(adBoard);
		return "redirect:/advertising/getMyList.do";
	}

	// 게시글 번호로 게시글 수정
	@RequestMapping("/updateAdBoard.do")
	public String updateAdBoard(AdvertisingBoard adBoard, MultipartFile imageFile) throws Exception {
		if (imageFile.isEmpty()) {
			return "redirect:/advertising/getAdBoardByAdNo.do";
		}
		// 광고 이미지 지정된 폴더에 저장
		String filename = adBoard.getNo() + "_" + imageFile.getOriginalFilename();
		FileCopyUtils.copy(imageFile.getBytes(), new File(directory, filename));
		
		// 새로운 파일 이름 업데이트하기
		adBoard.setImage(filename);
		adService.updateAdBoard(adBoard);
		return "redirect:/advertising/getMyList.do";
	}

	// 게시글 삭제
	@RequestMapping("/delAdBoard.do")
	public String delAdBoard(String no) {
		adService.delAdBoard(no);
		return "redirect:/advertising/getMyList.do";
	}

	// 게시글 체크시 사용
	@RequestMapping("/checkBoard.do")
	@ResponseBody
	public List<AdvertisingBoard> checkBoard(String no) {
		List<AdvertisingBoard> adboards = new ArrayList<>();
		adboards.add(adService.getAdBoardByAdNo(no));
		return adboards;
	}

	// 관리자 관련 기능
	// 모든 광고주 리스트 가져오기
	@RequestMapping("/getAdList.do")
	public String getAdList(Model model, HttpSession session) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!loginUser.getStatus().equals("ADMIN")) {
			session.setAttribute("LOGIN_USER", loginUser);
			return "redirect:/home.do";
		}
		model.addAttribute("ads", adService.getAllAdvertising());
		return "advertising/adlist.jsp";
	}

	// 광고주 검색
	@RequestMapping("/searchAdvertising.do")
	@ResponseBody
	public List<Advertising> searchAdvertising(String keyword) {
		return adService.searchAdvertising(keyword);
	}

	// 모든 광고게시글을 가져오는 기능
	@RequestMapping("/getAllAdBoards.do")
	public String getAllAdBoards(Model model, HttpSession session) {
		User loginUser = (User) session.getAttribute("LOGIN_USER");
		if (!loginUser.getStatus().equals("ADMIN") || loginUser == null) {
			session.setAttribute("LOGIN_USER", loginUser);
			return "redirect:/home.do";
		}
		
		model.addAttribute("adBoards", adService.getAllAdBoards());
		return "advertising/adboardlist.jsp";
	}

	// 상태 업데이트
	@RequestMapping("/updateAdStatus.do")
	public String updateAdStatus(String status, String no) {
		AdvertisingBoard adBoard = new AdvertisingBoard();
		adBoard.setNo(no);
		adBoard.setStatus(status);
		adService.updateAdStatus(adBoard);
		return "redirect:/advertising/getAllAdBoards.do";
	}

	// 광고 게시글 검색
	@RequestMapping("/searchAdBoard.do")
	@ResponseBody
	public List<AdvertisingBoard> searchAdBoard(String keyword) {
		return adService.searchAdBoard(keyword);
	}
}

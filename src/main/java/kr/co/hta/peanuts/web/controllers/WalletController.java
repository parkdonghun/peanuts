package kr.co.hta.peanuts.web.controllers;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.co.hta.peanuts.annotation.LoginUser;
import kr.co.hta.peanuts.service.WalletService;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.vo.Wallet;
import kr.co.hta.peanuts.web.form.WalletForm;

@Controller
@RequestMapping("/wallet")
public class WalletController {
	
	@Autowired
	private WalletService walletService;
	
	//대쉬보드 차트 출력
	@RequestMapping("/dashboard.do")
	@ResponseBody
	public List<Wallet> dashboardChart(@RequestParam("pno") int pno){
		List<Wallet> wallet = walletService.dashboardChart(pno);
		
		return wallet;
	}
	
	
	// 플래너별 한눈에보기 출력
	@RequestMapping("/view.do")
	public String allWalletView(@RequestParam("pno") int planNo, Model model, @LoginUser User user) {
		List<Wallet> wallet = walletService.allWalletByNo(planNo);
		model.addAttribute("wallet", wallet);
		model.addAttribute("days", walletService.planerDays(planNo)); //플래너별 날짜 받아오기
		model.addAttribute("pno", planNo);
		String userId = walletService.getUserId(planNo);
		String isWriter = "false";
		if(userId.equals(user.getId())) {
			isWriter = "true";
		}
		model.addAttribute("isWriter", isWriter);
		return "wallet/view.jsp?pno="+planNo;
	}
	// 일자별 비용 등록하기
	@RequestMapping("/add.do")
	public String add(WalletForm wallet) throws Exception{
		walletService.addDailyWallet(wallet);	
		return "redirect:/wallet/view.do?pno="+wallet.getPno()+"&dno="+wallet.getDayIndex();
	}
	//일자별 모달 수정용 비용 불러오기 (ajax)
	@RequestMapping("/getmodal.do")
	@ResponseBody
	public  Wallet getWallekey(@RequestParam("keyno") int keyno) {
		Wallet wallet = walletService.getByWalletKey(keyno);
		return wallet;
	} 
	//일자별 비용 삭제하기
	@RequestMapping("/del.do")
	public String walletDelete(@RequestParam("pno") int pno,
								@RequestParam("dno") int dno,
								@RequestParam("keyno") int keyno) {
		walletService.deleteWallet(keyno);
		return "redirect:/wallet/view.do?pno="+pno+"&dno="+dno;
	}
	//일자별 비용 수정 업데이트
	@RequestMapping("modify.do")
	public String modifyWallet(WalletForm wallet) {
		walletService.modifygetKeyNo(wallet);
		return "redirect:/wallet/view.do?pno="+wallet.getPno()+"&dno="+wallet.getDayIndex();
	}
	
}

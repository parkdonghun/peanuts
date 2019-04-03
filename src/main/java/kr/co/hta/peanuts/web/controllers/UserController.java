package kr.co.hta.peanuts.web.controllers;

import static org.hamcrest.CoreMatchers.is;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.hta.peanuts.annotation.LoginUser;
import kr.co.hta.peanuts.service.AdvertisingService;
import kr.co.hta.peanuts.service.MapService;
import kr.co.hta.peanuts.service.UserService;
import kr.co.hta.peanuts.vo.Advertising;
import kr.co.hta.peanuts.vo.Images;
import kr.co.hta.peanuts.vo.Message;
import kr.co.hta.peanuts.vo.MessageUser;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.User;
import kr.co.hta.peanuts.web.form.UserForm;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Value("${user.photo.saved.directory}")
	private String path;
	
	@Value("${album.photo.saved.directory}")
	private String albumPath;
	
	@Autowired
	private UserService userService;
	@Autowired
	private MapService mapService;
	@Autowired
	private AdvertisingService advertisingService;
	
	// dashboard 이동
	@RequestMapping("/dashboard.do")
	public String dashboard(@RequestParam("pno") int pno, @LoginUser User user) {
		return "redirect:/planner/dashboard.do?pno="+pno;
	}
	
	// 마이페이지 홈
	@RequestMapping("/mypage.do")
	public String mypagehome(Model model, @RequestParam("id") String id) {
		User userInfo = userService.getUserDetail(id);
		model.addAttribute("userInfo", userInfo);
		int planCnt = userService.getUserPlanner(id);
		model.addAttribute("planCnt", planCnt);
		String likeplanCnt = userService.getUserLikePlan(id);
		if(likeplanCnt != null) {
			model.addAttribute("likePlanCnt", likeplanCnt);
		} else {
			model.addAttribute("likePlanCnt", "0");
		}
		model.addAttribute("planCnt", planCnt);
		return "user/mypage.jsp";
	}
	// 마이페이지 플래너리스트
	@RequestMapping("/planList.do")
	@ResponseBody
	public List<Planner> mypageView(@RequestParam("id") String id, String type, int planNo, String openStatus) {
		Map<String, Object> planInfo = new HashMap();
		planInfo.put("userId", id);
		planInfo.put("type", type);

		if (planNo != 0 && openStatus != null) {
			
			Map<String, Object> open = new HashMap();
			open.put("planNo", planNo);
			open.put("openStatus", openStatus);
			userService.OpenStatus(open);
		}
		
		List<Planner> plans = userService.getUserPlanners(planInfo);
		for(Planner plan  : plans) {
			String mapContent = mapService.getMapImage(plan.getNo(), "350", "250");
			plan.setMapImg(mapContent);
			plan.setPlanType(type);
		}
		return plans;
	}
	//관심플래너 추가
	@RequestMapping("/addPlanLike.do")
	public String addPlanLike(@RequestParam("pno") int pno, @LoginUser User user, @RequestParam("id") String id) {
		Map<String, Object> map = new HashMap();
		map.put("id", user.getId());
		map.put("pno", pno);
		int cnt = userService.getUserIdLike(map);
		
		if(cnt == 0 ) {
			userService.addPlanLike(map);			
		} else {
			return "redirect:/user/mypage.do?id="+id+"&err=already";
		}
		
		return "redirect:/user/mypage.do?id="+id;
	}
	
	//마이페이지 플래너 삭제
	@RequestMapping("/delPlanner.do")
	public String delPlanner(@RequestParam("pno") int pno,  @LoginUser User user) {
		userService.delPlanner(pno);
		return "redirect:/user/mypage.do?id="+user.getId();
	}
	//마이페이지 관심플래너 삭제
	@RequestMapping("/delLikePlanner.do")
	public String delLikePlanner(@RequestParam("pno") int pno, @LoginUser User user) {
		Map<String, Object> map = new HashMap();
		map.put("userId", user.getId());
		map.put("pno", pno);
		userService.delLikePlanner(map);
		return "redirect:/user/mypage.do?id="+user.getId();
	}

	
	
	@RequestMapping("/form.do")
	public String addUserForm() {
		return "user/form.jsp";
	}
	
	@RequestMapping("/register.do")
	public String addUser(UserForm userForm) throws IOException {
		
		User user = new User();
		user.setName(userForm.getName());
		user.setId(userForm.getId());
		user.setPwd(userForm.getPwd());
		user.setEmail(userForm.getEmail());
		user.setTel(userForm.getPhone());
		
		MultipartFile upfile = userForm.getProfile();
		if(!upfile.isEmpty()) {
			String originalFileName = upfile.getOriginalFilename();
			FileCopyUtils.copy(upfile.getBytes(), new File(path,originalFileName));
			user.setProfile(upfile.getOriginalFilename());
		} else {
			user.setProfile("DEFAULT_PROFILE.JPG");
		}
		
		userService.addUser(user);
		
		return "redirect:/home.do";
	}
	
	@RequestMapping(value="/login.do", method=RequestMethod.GET)
	public String login() {
		return "user/loginform.jsp";
	}
	
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	public String login(String id, String pwd, String status,HttpSession session) {
		
		if("user".equals(status)) {
			User user = userService.getUserDetail(id);
			if(user == null) {
				return "redirect:/user/login.do?err=fail";
			}
			if(!user.getPwd().equals(pwd)) {
				return "redirect:/user/login.do?err=fail";
			}
			if(user.getStatus().equals("IN")) {			
				session.setAttribute("LOGIN_USER", user);
			} else if(user.getStatus().equals("ADMIN")) {
				session.setAttribute("LOGIN_USER", user);
				return "redirect:/home.do";
			} else {
				return "redirect:/user/login.do?err=outPutUser";
			}
		} else if("ad".equals(status)) {
			Advertising advertising = advertisingService.getAdvertisingById(id);
			if(advertising == null) {
				return "redirect:/user/login.do?err=fail";
			}
			if(!advertising.getPwd().equals(pwd)) {
				return "redirect:/user/login.do?err=fail";
			}
			session.setAttribute("LOGIN_AD", advertising);
		}
		return "redirect:/home.do";
	}
	
	@RequestMapping("/logout.do")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/home.do";
	}
	// 사용자 프로필 파일변경
	@RequestMapping("/imgModify.do")
	public String imgModify(@LoginUser User user, MultipartFile profile) throws Exception {
		User userform = new User();
		userform.setId(user.getId());

		MultipartFile modifile = profile;
		if(!modifile.isEmpty()) {
			String originalFileName = modifile.getOriginalFilename();
			FileCopyUtils.copy(modifile.getBytes(), new File(path,originalFileName));
			userform.setProfile(modifile.getOriginalFilename());
		} else {
			userform.setProfile("DEFAULT_PROFILE.JPG");
		}
		
		userService.imgModify(userform);
		
		return "redirect:/user/mypage.do?id="+userform.getId();
	}
	
	@RequestMapping("/getMessages.do")
	@ResponseBody
	public List<Message> getMessages(String keyword, HttpSession session) {
		User user = (User) session.getAttribute("LOGIN_USER");
		Map<String , Object> map = new HashMap<String, Object>();
		map.put("id", user.getId());
		map.put("keyword", keyword);
		return userService.getMessages(map);
	}
	
	@RequestMapping("/getSentMessages.do")
	@ResponseBody
	public List<Message> getSentMessages(HttpSession session) {
		User user = (User) session.getAttribute("LOGIN_USER");
		return userService.getSentMessages(user.getId());
	}

	@RequestMapping("/getdelMessages.do")
	@ResponseBody
	public List<Message> getdelMessages(HttpSession session) {
		User user = (User) session.getAttribute("LOGIN_USER");
		return userService.getDelMessages(user.getId());
	}
	
	@RequestMapping("/sendMessage.do")
	@ResponseBody
	public void sendMessage(String receiver, String contents, HttpSession session) {
		User user = (User) session.getAttribute("LOGIN_USER");
		Message message = new Message();
		message.setUserId(user.getId());
		message.setContents(contents);
		message.setReceiver(receiver);
		userService.sendMessages(message);
	}
	
	@RequestMapping("/getMessageDetail.do")
	@ResponseBody
	public MessageUser getMessageDetail(String category, int key, HttpSession session) {
		User user = (User) session.getAttribute("LOGIN_USER");		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("category", category);
		map.put("id", user.getId());
		map.put("key", key);
		return userService.getMessageDetail(map);
	}
	
	@RequestMapping("markMessage.do")
	@ResponseBody
	public void markMessage(int key) {
		userService.markMessage(key);
	}

	@RequestMapping("delMessage.do")
	@ResponseBody
	public void delMessage(@RequestBody String[] keys) {
		userService.delMessages(keys);
	}
	
	@RequestMapping("cancelSendMessage.do")
	@ResponseBody
	public void cancelSendMessage(@RequestBody String[] keys) {
		userService.cancelSendMessage(keys);
	}
	
	@RequestMapping("recoveryMessage.do")
	@ResponseBody
	public void recoveryMessage(@RequestBody String[] keys) {
		userService.recoveryMessage(keys);
	}
	
	@RequestMapping("/formfilter.do")
	public String formfilter() {
		
		return "user/formfilter.jsp";
	}
	
	// 앨범 리스트로 넘어가는 기능
	@RequestMapping("/photoList.do")
	public String photoList(int pno, HttpSession session, Model model) {
		// 로그인 유저가 플래너를 작성한 사람인지 확인한다
		User user = (User) session.getAttribute("LOGIN_USER");
		Planner planner = userService.getPlanByPno(pno);
		boolean isWriter = false;
		if (user.getId().equals(planner.getUserId())) {
			isWriter = true;
		}
		
		model.addAttribute("isWriter", isWriter);
		
		// 넘겨준 pno를 통해서 해당 이미지들을 불러오기
		List<Images> photos = userService.getAlbumByPno(pno);
		model.addAttribute("photos", photos);
		model.addAttribute("size", photos.size());
		model.addAttribute("pno", pno);
		
		return "/album/photoList.jsp";
	}
	
	// 새로운 사진을 추가하는 기능
	@RequestMapping("/addPhoto.do")
	public String addPhoto(int pno, MultipartFile photo, HttpSession session, RedirectAttributes redirectAttributes) throws Exception {
		Random random = new Random();
		String filename = random.nextInt() + "_" + photo.getOriginalFilename();
		
		if(!photo.isEmpty()) {
			FileCopyUtils.copy(photo.getBytes(), new File(albumPath, filename));
			
			Images addPhoto = new Images();
			addPhoto.setNo(pno);
			addPhoto.setCategory("PLANNER");
			addPhoto.setName(filename);
			
			userService.addPhoto(addPhoto);
			
			redirectAttributes.addAttribute("pno", pno);
			
		}
		return "redirect:/user/photoList.do";
	}
	
	// 사진을 삭제하는 기능
	@RequestMapping("delPhoto.do")
	public String delPhoto(String pno, String name, RedirectAttributes redirectAttributes) throws Exception {
		int planNo = 0;
		if (pno != null) {
			planNo = Integer.parseInt(pno);
		}
		
		Map<String, Object> imgInfo = new HashMap<>();
		imgInfo.put("planNo", planNo);
		imgInfo.put("name", name);
		
		userService.delPhoto(imgInfo);
		
		redirectAttributes.addAttribute("pno", planNo);
		
		return "redirect:/user/photoList.do";
	}
	
	@RequestMapping("/checkUser.do")
	@ResponseBody
	public boolean checkUser(String userId) {
		boolean isExist = true;
		User user = userService.getUserDetail(userId);
		if(user == null) {
			isExist = false;
		}
		return isExist;
	}
	
	@RequestMapping("/updateUser.do")
	public String updateUser(@LoginUser User user, String pwd, String tel, String email) {
			user.setEmail(email);
			user.setPwd(pwd);
			user.setTel(tel);
			
			userService.updateUserById(user);
			
		return "redirect:/user/mypage.do?id="+user.getId();
	}
	
	@RequestMapping("/outPut.do")
	public String outPutUser(@LoginUser User user, HttpSession session) {
		String userId = user.getId();
		userService.outPutUserById(userId);
		
		session.invalidate();
		return "redirect:/home.do";
	}
}
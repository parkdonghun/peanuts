package kr.co.hta.peanuts.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import kr.co.hta.peanuts.vo.Images;
import kr.co.hta.peanuts.vo.Message;
import kr.co.hta.peanuts.vo.MessageUser;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.User;

@Transactional
public interface UserService {

	void addUser(User user);
	User getUserDetail(String id);
	void imgModify(User user);
	List<Message> getMessages(Map<String, Object> map);
	List<Message> getSentMessages(String id);
	List<Message> getDelMessages(String id);
	Message getMessage(int msgKey);
	void delMessages(String[] msgKey);
	void markMessage(int msgKey);
	void cancelSendMessage(String[] msgKey);
	void recoveryMessage(String[] msgKey);
	void sendMessages(Message message);
	MessageUser getMessageDetail(Map<String, Object> map);
	void addPhoto(Images addPhoto);
	List<Images> getAlbumByPno(int pno);
	
	List<Planner> getUserPlanners(Map<String, Object> planInfo);
	int getUserPlanner(String userId);
	void delPlanner(int pno);
	void delLikePlanner(Map<String, Object> map);
	String getUserLikePlan(String userId);
	void OpenStatus(Map<String, Object> map);
	void addPlanLike(Map<String, Object> map);
	void delPhoto(Map<String, Object> imgInfo);
	int getUserIdLike(Map<String, Object> map);
	Planner getPlanByPno(int pno);
	
	void updateUserById(User user);
	void outPutUserById(String userId);
	void addPeanut(HashMap<String, Object> peanut);
}

package kr.co.hta.peanuts.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hta.peanuts.dao.UserDao;
import kr.co.hta.peanuts.vo.Images;
import kr.co.hta.peanuts.vo.Message;
import kr.co.hta.peanuts.vo.MessageUser;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	
	@Override
	public List<Planner> getUserPlanners(Map<String, Object> planInfo) {
		List<Planner> plans = userDao.getUserPlanners(planInfo);
		return plans;
	}
	@Override
	public int getUserPlanner(String userId) {
		int planCnt = userDao.getUserPlanner(userId);
		return planCnt;
	}
	@Override
	public void delPlanner(int pno) {
		userDao.delPlanner(pno);
	}
	@Override
	public void delLikePlanner(Map<String, Object> map) {
		userDao.delLikePlanner(map);
	}
	@Override
	public String getUserLikePlan(String userId) {
		String cnt = userDao.getUserLikePlan(userId);
		return cnt;
	}
	@Override
	public void OpenStatus(Map<String, Object> map) {
		userDao.OpenStatus(map);
	}
	@Override
	public void addPlanLike(Map<String, Object> map) {
		userDao.addPlanLike(map);
	}
	@Override
	public int getUserIdLike(Map<String, Object> map) {
		int cnt = userDao.getUserIdLike(map);
		return cnt;
	}
	
	
	
	@Override
	public void addUser(User user) {
		userDao.addUser(user);
	}
	@Override
	public User getUserDetail(String id) {
		User user = userDao.getUserDetail(id);
		return user;
	}
	@Override
	public void imgModify(User user) {
		userDao.imgModify(user);
	}
	@Override
	public List<Message> getMessages(Map<String, Object> map) {
		Message message = new Message();
		message.setReceiver((String) map.get("id"));
		String keyword = (String)map.get("keyword");
		if(keyword.equals("all")) {
			message.setCriteria("all");
		}
		if(keyword.equals("mark")) {
			message.setCriteria("mark");
		}
		if(keyword.equals("unread")) {
			message.setCriteria("unread");
		}
		if(keyword.equals("read")) {
			message.setCriteria("read");
		}
		return userDao.getMessages(message);
	}
	@Override
	public List<Message> getSentMessages(String id) {
		return userDao.getSentMessages(id);
	}
	@Override
	public List<Message> getDelMessages(String id) {
		return userDao.getDelMessages(id);
	}
	@Override
	public Message getMessage(int msgKey) {
		return userDao.getMessage(msgKey);
	}
	@Override
	public void delMessages(String[] msgKey) {
		//삭제 : 즐겨찾기되어있는경우 해제시키고 삭제
		for(int i=0; i<msgKey.length; i++) {
			int key = Integer.parseInt(msgKey[i]);
			this.markMessage(key);
			userDao.delMessages(key);
		}
	}
	@Override
	public void markMessage(int msgKey) {
		Message msg = userDao.getMessage(msgKey);		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("key", msgKey);
		if(msg.getMark().equals("Y")) {
			map.put("mark", "N");
		} else {
			map.put("mark", "Y");
		}		
		userDao.markMessage(map);
	}
	@Override
	public void cancelSendMessage(String[] msgKey) {
		for(int i=0; i<msgKey.length; i++) {
			int key = Integer.parseInt(msgKey[i]);
			userDao.cancelSendMessage(key);
		}
	}
	@Override
	public void recoveryMessage(String[] msgKey) {
		Map<String, Object> map = new HashMap<String, Object>();
		for(int i=0; i<msgKey.length; i++) {
			int key = Integer.parseInt(msgKey[i]);
			map.put("key", key);
			//복구시킬 이전의 상태 알아보기
			Message msg = this.getMessage(key);
			if(msg.getReadDate() == null) {
				map.put("read", "N");
			} else {
				map.put("read", "Y");
			}
			userDao.recoveryMessage(map);
		}
	}
	@Override
	public void sendMessages(Message message) {
		User isExist;
		String receiver = message.getReceiver();
		if(!receiver.contains("|")) {
			isExist = userDao.getUserDetail(receiver.trim());
			if(isExist != null) {
				message.setReceiver(receiver.trim());
				userDao.sendMessages(message);
			}			
		} else {
			String[] receivers = receiver.split("[|]");
			for(int i=0; i<receivers.length; i++) {
				isExist = userDao.getUserDetail(receivers[i].trim());
				if(isExist != null) {
					message.setReceiver(receivers[i].trim());
					userDao.sendMessages(message);
				}
			}
		}		
	}
	
	@Override
	public MessageUser getMessageDetail(Map<String, Object> map) {
		//카테고리에 따른 정보조회
		MessageUser mu = new MessageUser();
		if(map.get("category").equals("rd")) {
			//읽음여부에 따른 설정(내가 수신인 경우에만)
			mu = userDao.getMessageRD(map);
			if(mu.getStatus().equals("N")) {
				userDao.readMessage((Integer) map.get("key"));
			}		
		} else if (map.get("category").equals("s")) {
			mu = userDao.getMessageS(map);
		}
		return mu;
	}
	
	@Override
	public void addPhoto(Images addPhoto) {
		userDao.addPhoto(addPhoto);
	}
	
	@Override
	public List<Images> getAlbumByPno(int pno) {
		List<Images> images = userDao.getAlbumByPno(pno);
		int index = 1;
		for (Images image : images) {
			image.setIndex(index);
			index ++;
		}
		return images;
	}
	
	@Override
	public void delPhoto(Map<String, Object> imgInfo) {
		userDao.delPhoto(imgInfo);
	}
	
	@Override
	public Planner getPlanByPno(int pno) {
		return userDao.getPlanByPno(pno);
	}
	
	@Override
	public void updateUserById(User user) {
		userDao.updateUserById(user);
	}
	
	@Override
	public void outPutUserById(String userId) {
		userDao.outPutUserById(userId);
	}
	
	@Override
	public void addPeanut(HashMap<String, Object> peanut) {
		userDao.addPeanut(peanut);
	}
}

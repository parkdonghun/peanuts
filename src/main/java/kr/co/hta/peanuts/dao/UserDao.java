package kr.co.hta.peanuts.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.co.hta.peanuts.vo.Images;
import kr.co.hta.peanuts.vo.Message;
import kr.co.hta.peanuts.vo.MessageUser;
import kr.co.hta.peanuts.vo.Planner;
import kr.co.hta.peanuts.vo.User;

public interface UserDao {
	
	
	//사용자의 플래너 모두 불러오기
	List<Planner> getUserPlanners(Map<String, Object> planInfo);
	//사용자 플래너 개수
	int getUserPlanner(String userId);
	//플래너 삭제
	void delPlanner(int pno);
	//관심플래너 삭제
	void delLikePlanner(Map<String, Object> map);
	//사용자 관심플래너 개수
	String getUserLikePlan(String userId);
	//플래너 공개여부
	void OpenStatus(Map<String, Object> map);
	//관심플래너 추가
	void addPlanLike(Map<String, Object> map);
	//플래너 관심 여부
	int getUserIdLike(Map<String, Object> map);
	
	//사용자추가
	void addUser(User user);
	//사용자정보 가져오기
	User getUserDetail(String id);
	//사용자 사진 변경
	void imgModify(User user);
	//사용자가 수신한 모든 메시지 가져오기
	List<Message> getMessages(Message message);
	//사용자가 발신한 모든 메시지 가져오기
	List<Message> getSentMessages(String id);
	//사용자가 삭제처리한 모든 메시지 가져오기
	List<Message> getDelMessages(String id);
	//해당하는 메세지 정보 가져오기
	Message getMessage(int msgKey);
	//해당하는 메시지 삭제하기(status => D)
	void delMessages(int msgKey);
	//메시지 즐겨찾기 추가,해제하기
	void markMessage(Map<String, Object> map);
	//해당하는 메시지 발송취소하기(db삭제)
	void cancelSendMessage(int msgKey);
	//해당하는 메시지 복구하기(status D ==> Y or N)
	void recoveryMessage(Map<String, Object> map);
	//메시지 발송하기
	void sendMessages(Message message);
	//메시지 정보 가져오기 + 수/발신자 정보 : 수신, 삭제의 경우
	MessageUser getMessageRD(Map<String, Object> map);
	//메시지 정보 가져오기 + 발신의 경우
	MessageUser getMessageS(Map<String, Object> map);
	//해당 메시지 읽음처리하기
	void readMessage(int msgKey);
	//앨범에 사진 넣기
	void addPhoto(Images addPhoto);
	// pno와 category로 앨범에서 사진을 꺼내오는 기능
	List<Images> getAlbumByPno(int pno);
	// 앨범에서 사진을 지우는 기능
	void delPhoto(Map<String, Object> imgInfo);
	// pno로 planner 정보 불러오기
	Planner getPlanByPno(int pno);
	// 사용자 정보 수정
	void updateUserById(User user);
	// 사용자 탈퇴 처리
	void outPutUserById(String userId);
	// 땅콩 추가
	void addPeanut(HashMap<String, Object> peanut);
}

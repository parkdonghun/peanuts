package kr.co.hta.peanuts.service;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import kr.co.hta.peanuts.vo.Likes;
import kr.co.hta.peanuts.vo.Plaza;
import kr.co.hta.peanuts.vo.Reply;

@Transactional
public interface PlazaService {

	void addPlaza(Plaza plaza);
	List<Plaza> getAllPlaza(Map<String, Object> map);
	List<Reply> getReplyByNo(int no);
	void addReply(Reply re);
	void listModiByNo(Plaza plaza);
	void listDelByNo(int no);
	void reModiByNo(Reply re);
	void reDelByNo(int no);
	void addlike(Likes like);
	int getUserIdLike(Likes like);
	void dellike(int no);
	List<Plaza> bestPlazalist();
	List<Reply> newReList();
	List<Plaza> searchPlaza(Map<String, Object> map);
	int plazaCnt(Map<String, Object> map);
	void getByNoReport(int no);
	void addpeanuts(Map<String, Object> map);
}

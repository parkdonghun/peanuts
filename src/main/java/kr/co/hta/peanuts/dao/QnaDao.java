package kr.co.hta.peanuts.dao;

import java.util.HashMap;
import java.util.List;

import kr.co.hta.peanuts.vo.Qna;

public interface QnaDao {

	List<HashMap<String, Object>> getAllQna(HashMap<String, Object> index);
	void addQna(Qna qna);
	void addQnaAnswer(Qna qna);
	void deleteQna(int qnaNo);
	int getAllQnaCnt(int ticketNo);
	HashMap<String, Object> getQnaByNo(int qnaNo);
	void deleteQnaAnswer(int qnaNo);
}

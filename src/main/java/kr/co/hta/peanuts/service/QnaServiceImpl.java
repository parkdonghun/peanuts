package kr.co.hta.peanuts.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hta.peanuts.dao.QnaDao;
import kr.co.hta.peanuts.vo.Qna;

@Service
public class QnaServiceImpl implements QnaService {

	@Autowired
	private QnaDao qnaDao;
	
	@Override
	public List<HashMap<String, Object>> getAllQna(HashMap<String, Object> index) {
		List<HashMap<String, Object>> qnas = qnaDao.getAllQna(index); 
		return qnas;
	}
	
	@Override
	public void addQna(Qna qna) {
		qnaDao.addQna(qna);
	}
	
	@Override
	public void addQnaAnswer(Qna qna) {
		qnaDao.addQnaAnswer(qna);	
	}
	
	@Override
	public void deleteQna(int qnaNo) {
		qnaDao.deleteQna(qnaNo);	
	}
	
	@Override
	public int getAllQnaCnt(int ticketNo) {
		int totalCnt = qnaDao.getAllQnaCnt(ticketNo);
		return totalCnt;
	}
	
	@Override
	public HashMap<String, Object> getQnaByNo(int qnaNo) {
		HashMap<String, Object> qna = qnaDao.getQnaByNo(qnaNo);
		return qna;
	}
	@Override
	public void deleteQnaAnswer(int qnaNo) {
		qnaDao.deleteQnaAnswer(qnaNo);
	}
}

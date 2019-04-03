package kr.co.hta.peanuts.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface OrderService {

	void addOrder(HashMap<String, Object> order);
	List<HashMap<String, Object>> getAllOrder(HashMap<String, Object> index);
	int getOrderCnt(HashMap<String, Object> index);
	void deleteOrder(int orderNo);
}

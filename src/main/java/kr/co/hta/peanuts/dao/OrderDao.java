package kr.co.hta.peanuts.dao;

import java.util.HashMap;
import java.util.List;

public interface OrderDao {

	void addOrder(HashMap<String, Object> order);
	List<HashMap<String, Object>> getAllOrder(HashMap<String, Object> index);
	int getOrderCnt(HashMap<String, Object> index);
	void deleteOrder(int orderNo);
}

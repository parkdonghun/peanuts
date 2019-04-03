package kr.co.hta.peanuts.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hta.peanuts.dao.OrderDao;

@Service
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderDao orderDao;
	
	@Override
	public void addOrder(HashMap<String, Object> order) {
		orderDao.addOrder(order);
	}
	
	@Override
	public List<HashMap<String, Object>> getAllOrder(HashMap<String, Object> index) {
		List<HashMap<String, Object>> orders = orderDao.getAllOrder(index);
		return orders;
	}
	@Override
	public int getOrderCnt(HashMap<String, Object> index) {
		return orderDao.getOrderCnt(index);
	}
	@Override
	public void deleteOrder(int orderNo) {
		orderDao.deleteOrder(orderNo);
	}
}

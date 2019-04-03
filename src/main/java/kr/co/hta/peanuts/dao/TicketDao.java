package kr.co.hta.peanuts.dao;

import java.util.HashMap;
import java.util.List;

import kr.co.hta.peanuts.vo.Ticket;


public interface TicketDao {

	List<Ticket> getAllTicket();
	Ticket getTicketByNo(int ticketNo);
	List<String> getTicketTopImageByNo(int ticketNo);
	List<String> getTicketMainImageByNo(int ticketNo);
	List<Ticket> getCriteriaTicketByPageNo(HashMap<String, Object> cr);
	int getTotalCnt(HashMap<String, Object> cr);
	List<Ticket> getNewTicket(HashMap<String, Object> cr);
	int getNewTicketCnt(HashMap<String, Object> cr);
	List<Ticket> getDeadlineTicket(HashMap<String, Object> cr);
	int getDeadlineTicketCnt(HashMap<String, Object> cr);
	int getTicketSeq();
	void addTicket(Ticket ticket);
	void addTicketImages(HashMap<String, Object> ticketImages);
	List<Ticket> getPlannerBestTicket(int pno);
	// 관리자 티켓 리스트, 숫자
	List<Ticket> getAdminTickets(HashMap<String, Object> cr);
	int getAdminTicketsCnt(HashMap<String, Object> cr);
	void updateTicket(Ticket ticket);
	void deleteTicket(int ticketNo);
}

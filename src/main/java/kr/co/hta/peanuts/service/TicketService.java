package kr.co.hta.peanuts.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import kr.co.hta.peanuts.vo.Ticket;
import kr.co.hta.peanuts.web.form.AddTicketForm;

@Transactional
public interface TicketService {

	List<Ticket> getTicketList();
	HashMap<String, Object> detail(int ticketNo);
	List<Ticket> getCriteriaTicketByPageNo(HashMap<String, Object> cr);
	int getTotalCnt(HashMap<String, Object> cr);
	List<Ticket> getNewTicket(HashMap<String, Object> cr);
	int getNewTicketCnt(HashMap<String, Object> cr);
	List<Ticket> getDeadlineTicket(HashMap<String, Object> cr);
	int getDeadlineTicketCnt(HashMap<String, Object> cr);
	void addTicket(AddTicketForm addTicketForm, List<String> imagesNames, List<String> topImagesNames);
	List<Ticket> getPlannerBestTicket(int pno);
	HashMap<String, Object> getAdminTickets(HashMap<String, Object> cr);
	Ticket getTicketByNo(int ticketNo);
	void updateTicket(Ticket ticket);
	void deleteTicket(int ticketNo);
}

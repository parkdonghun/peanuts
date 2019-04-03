package kr.co.hta.peanuts.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.hta.peanuts.dao.TicketDao;
import kr.co.hta.peanuts.vo.Ticket;
import kr.co.hta.peanuts.web.form.AddTicketForm;

@Service
public class TicketServiceImpl implements TicketService {
	
	@Autowired
	TicketDao ticketDao;
	
	@Override
	public List<Ticket> getTicketList() {
		List<Ticket> tickets = ticketDao.getAllTicket();
		return tickets;
	}
	
	@Override
	public HashMap<String, Object> detail(int ticketNo) {
		Ticket ticketInfo = ticketDao.getTicketByNo(ticketNo);
		List<String> ticketTopImages = ticketDao.getTicketTopImageByNo(ticketNo);
		List<String> ticketMainImages = ticketDao.getTicketMainImageByNo(ticketNo);
		
		HashMap<String, Object> ticket = new HashMap<>();
		ticket.put("info", ticketInfo);
		ticket.put("topImages", ticketTopImages);
		ticket.put("mainImages", ticketMainImages);
		return ticket;
	}
	
	@Override
	public List<Ticket> getCriteriaTicketByPageNo(HashMap<String, Object> cr) {
		List<Ticket> tickets = ticketDao.getCriteriaTicketByPageNo(cr);
		return tickets;
	}
	
	@Override
	public int getTotalCnt(HashMap<String, Object> cr) {
		int totalCnt = ticketDao.getTotalCnt(cr);
		return totalCnt;
	}
	@Override
	public List<Ticket> getNewTicket(HashMap<String, Object> cr) {
		List<Ticket> tickets = ticketDao.getNewTicket(cr);
		return tickets;
	}
	
	@Override
	public int getNewTicketCnt(HashMap<String, Object> cr) {
		int totalCnt = ticketDao.getNewTicketCnt(cr);
		return totalCnt;
	}
	@Override
	public List<Ticket> getDeadlineTicket(HashMap<String, Object> cr) {
		List<Ticket> tickets = ticketDao.getDeadlineTicket(cr);
		return tickets;
	}
	@Override
	public int getDeadlineTicketCnt(HashMap<String, Object> cr) {
		int totalCnt = ticketDao.getDeadlineTicketCnt(cr);
		return totalCnt;
	}
	
	@Override
	public void addTicket(AddTicketForm addTicketForm, List<String> imagesNames, List<String> topImagesNames) {
		int no = ticketDao.getTicketSeq();
		String mainImageName = addTicketForm.getName()+".jpg";
		
		Ticket ticket =  new Ticket();
		ticket.setNo(no);
		ticket.setName(addTicketForm.getName());
		ticket.setPrice(addTicketForm.getPrice());
		ticket.setCategory(addTicketForm.getCategory());
		ticket.setImages(mainImageName);
		ticket.setDiscountRate(addTicketForm.getDiscountRate());
		ticket.setSellingEnd(addTicketForm.getSellingEnd());
		ticket.setLocationCity(addTicketForm.getLocationCity());
		ticketDao.addTicket(ticket);
		
		HashMap<String, Object> ticketImages = new HashMap<>();
		ticketImages.put("no", no);
		ticketImages.put("category", "TICKET_MAIN");
		
		for(String imageName : imagesNames) {
			ticketImages.put("imageName", imageName);
			ticketDao.addTicketImages(ticketImages);
		}
		
		ticketImages.put("category", "TICKET_TOP");
		for(String imageName : topImagesNames) {
			ticketImages.put("imageName", imageName);
			ticketDao.addTicketImages(ticketImages);
		}
	}
	
	@Override
	public List<Ticket> getPlannerBestTicket(int pno) {
		List<Ticket> tickets = ticketDao.getPlannerBestTicket(pno);
		return tickets;
	}
	@Override
	public HashMap<String, Object> getAdminTickets(HashMap<String, Object> cr) {
		List<Ticket> tickets = ticketDao.getAdminTickets(cr);
		int totalCnt = ticketDao.getAdminTicketsCnt(cr);
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("tickets", tickets);
		map.put("totalCnt", totalCnt);
		return map;
	}
	
	@Override
	public Ticket getTicketByNo(int ticketNo) {
		Ticket ticket = ticketDao.getTicketByNo(ticketNo);
		return ticket;
	}
	@Override
	public void updateTicket(Ticket ticket) {
		ticketDao.updateTicket(ticket);
	}
	
	@Override
	public void deleteTicket(int ticketNo) {
		ticketDao.deleteTicket(ticketNo);
	}
}

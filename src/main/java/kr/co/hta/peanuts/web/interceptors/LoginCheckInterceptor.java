package kr.co.hta.peanuts.web.interceptors;

import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginCheckInterceptor implements HandlerInterceptor {

	//app-servlet.xml에서 설정해준 urls 셋컬렉션에 담아둔
	//해당 요청 페이지들만 미로그인 상태일때 접근 가능하게 하기위해서
	//특정 페이지주소들만 담아두었다.
	private Set<String> urls;
	public void setUrls(Set<String> urls) {
		this.urls = urls;
	}
	
	//컨트롤러가 실행되기 전에 실행되는 인터셉터
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String requestURI = request.getRequestURI();

		//로그인상태가 아니여도 접근가능한 페이지 목록에
		//포함된 페이지를 요청했는가.				
		if(urls.contains(requestURI)) {
			return true;
		}
		
		//로그인 상태인지 확인하기위해서 session 객체를 생성
		HttpSession session = request.getSession();
		//로그인 상태면 어떤 페이지라도 접근할 수 있음
		if(session.getAttribute("LOGIN_USER") != null) {
			return true;
		}
		if(session.getAttribute("LOGIN_AD") != null) {
			return true;
		}
		
		//로그인 안한 상태라면 어떤 페이지라도 접근하려고 하면 
		//접근 못하게 하고, 로그인을 실행하도록 한다.
		//●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
		//로그인창으로 보내는 코딩, 기능구현하고 수정해주세요
		response.sendRedirect("/user/login.do?err=deny");
		//●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
		
		//무조건 리턴값이 있어야하니까 리다이렉션 하더라도								
		//default 값으로라도 return 해야한다.
		//●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
		//return false; 로그인기능구현되면 false로
		return false;
		//●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
	}

	//컨트롤러가 실행된 후에 실행되는 인터셉터
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
	}

	//컨트롤러가 실행되면 항상 실행되는 인터셉터 (자주 사용하지 않음)
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}
}







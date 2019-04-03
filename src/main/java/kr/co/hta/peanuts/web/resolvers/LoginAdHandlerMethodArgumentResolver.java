package kr.co.hta.peanuts.web.resolvers;


import org.springframework.core.MethodParameter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;

import kr.co.hta.peanuts.annotation.LoginAd;
import kr.co.hta.peanuts.vo.Advertising;

public class LoginAdHandlerMethodArgumentResolver implements HandlerMethodArgumentResolver {
//핸들러 메소드의 모든 매개변수/파라미터들을 해석하는 놈

	//매개변수리졸브를 적용할 수 있는 대상인지 검사하는 역할을 수행한다
	@Override
	public boolean supportsParameter(MethodParameter parameter) {
		return parameter.hasParameterAnnotation(LoginAd.class);
	}

	//supportParameter 메소드에서 true를 리턴하는 경우에 실행할 메소드
	//resolveArgument() 메소드가 반환하는 객체가 그 매개변수로 전달된다.
	@Override
	public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer mavContainer,
			NativeWebRequest webRequest, WebDataBinderFactory binderFactory) throws Exception {

		//세션 스코프 안에서 해당 이름으로 저장된 객체가 있는지 찾아보고 있다면 그 객체를 반환
		Advertising ad = (Advertising) webRequest.getAttribute("LOGIN_AD", NativeWebRequest.SCOPE_SESSION);
		return ad;
	}

}

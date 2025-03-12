package kr.or.ddit.cmm.security;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler{

	/**
	 * 작성자 : 김동준
	 * 로그인 성공후의 동작을 정의
	 */
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		log.info("## CustomLoginSuccessHandler.onAuthenticationSuccess() 실행...");
		User user = (User)authentication.getPrincipal(); // 사용자정보 가져오기
		log.info("## username : " + user.getUsername());
		log.info("## password : " + user.getPassword());

		HttpSession session = request.getSession(); 
    session.setAttribute("userId", user.getUsername()); 
		
		clearAuthenticationAttribute(request);
		
		String targetUrl = "/hrms/cmm/index";
		
		log.info("## Login Success Target URL : " + targetUrl);
		response.sendRedirect(targetUrl);
	}

	/**
	 * 작성자 : 김동준
	 * 로그인 실패후 발생한 예외정보를 제거
	 */
	private void clearAuthenticationAttribute(HttpServletRequest request) {
		// session 정보가 존재한다면 현재 session을 반환하고 존재하지 않으면 null을 반환
		HttpSession session = request.getSession();
		if(session == null) {
			return;
		}
		
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	}

}

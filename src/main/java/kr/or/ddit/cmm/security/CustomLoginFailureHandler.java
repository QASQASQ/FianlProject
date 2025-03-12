package kr.or.ddit.cmm.security;

import java.io.IOException;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CustomLoginFailureHandler implements AuthenticationFailureHandler{
	
	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		log.info("## CustomLoginFailureHandler.onAuthenticationFailure() 실행...");
		
		// 로그인 실패 이벤트
		String errorMessage = null;
        if(exception instanceof BadCredentialsException || exception instanceof InternalAuthenticationServiceException){
            errorMessage = "계정이 존재하지 않습니다.";
        }
        request.setAttribute("errorMessage", errorMessage);
        request.getRequestDispatcher("/hrms/cmm/login").forward(request,response);       
		// 로그인 실패 이벤트
        
        // 기존
		//response.sendRedirect("/hrms/cmm/login?msg=fail");
	}

}

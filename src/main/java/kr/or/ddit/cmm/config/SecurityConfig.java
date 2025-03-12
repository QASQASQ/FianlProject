package kr.or.ddit.cmm.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.security.servlet.PathRequest;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;

import jakarta.servlet.DispatcherType;
import kr.or.ddit.cmm.security.CustomLoginFailureHandler;
import kr.or.ddit.cmm.security.CustomLoginSuccessHandler;
import kr.or.ddit.cmm.security.CustomUserDetailsService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {
	@Autowired
	private CustomUserDetailsService customUserDetailsService;
	
	@Bean
	protected SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
		http.csrf((csrf) -> csrf.disable());
		http.authorizeHttpRequests(
			(authorize) ->
				authorize.dispatcherTypeMatchers(DispatcherType.FORWARD, DispatcherType.ASYNC).permitAll() // forward, async 로 오는 요청은 인증이 필요하지않기때문에 모두에게하용
					.requestMatchers(PathRequest.toStaticResources().atCommonLocations()).permitAll() // 정적리소스 접근허용
					.requestMatchers("/assets/**").permitAll() // static/assets 이 경로의 하위에있는 애들을 모두 접근허용
					.requestMatchers("/hrms/cmm/err404").permitAll()
					.requestMatchers("/hrms/cmm/err500").permitAll()
					.requestMatchers("/hrms/react/**").permitAll() // 자사홈페이지 요청경로는 로그인 안해도됨
					//.anyRequest().permitAll() // 이건 모든페이지 접근허용
					.anyRequest().authenticated() // 로그인완성하면 이거 주석해제하고 모든페이지 접근허용하는 코드제거
		);
   
		http.formLogin(login -> login.loginPage("/hrms/cmm/login").loginProcessingUrl("/login").permitAll() // 커스텀 로그인 페이지 설정
			.successHandler(new CustomLoginSuccessHandler()) // 로그인 성공 했을때
			.failureHandler(new CustomLoginFailureHandler()) // 로그인 실패 했을때
		);
		
//		http.exceptionHandling((exception) -> exception.accessDeniedHandler(new CustomAccessDeniedHandler())); // 커스텀 접근제한자
		
		http.logout(
			(logout) -> logout.logoutUrl("/logout")
						.invalidateHttpSession(true)	// 로그아웃 시, session 삭제
						.logoutSuccessUrl("/hrms/cmm/login")		// 로그아웃 시, 이동할 경로
						.deleteCookies("JSESSION_ID")
		);
		
		http.exceptionHandling(exception -> exception
                .accessDeniedPage("/cmm/login") // 접근 거부 시 이동할 페이지
        );


		return http.build();
	}
   
   // 암호화 사용가능하게하는메소드
   @Bean
   protected PasswordEncoder passwordEncoder() {
	 	return new BCryptPasswordEncoder();
   }
   
	@Bean
	protected AuthenticationManager authenticationManager(
	HttpSecurity http, BCryptPasswordEncoder bCryptPasswordEncoder,
	UserDetailsService userDetailsService
	) {
		DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
		authProvider.setUserDetailsService(customUserDetailsService);
		authProvider.setPasswordEncoder(bCryptPasswordEncoder); // 암호화를했을때 주석해제
		return new ProviderManager(authProvider);
	}
	
	@Bean
	public HttpFirewall httpFirewall() {
	    StrictHttpFirewall strictHttpFirewall = new StrictHttpFirewall();
	    strictHttpFirewall.setAllowUrlEncodedDoubleSlash(true);
	    return strictHttpFirewall;
	}
}
